import Cocoa
import FlutterMacOS
import desktop_multi_window

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    // Don't auto-terminate when last window closes
    // Flutter/Welcome window handles app lifecycle with exit(0)
    return false
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
    // Register plugin callback for new windows created by desktop_multi_window
    FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
      RegisterGeneratedPlugins(registry: controller)

      // Setup window lifecycle channel for sub-windows
      // This handles window close events and allows Flutter to control closing
      let windowChannel = FlutterMethodChannel(
        name: "com.pdfsign/window",
        binaryMessenger: controller.engine.binaryMessenger
      )

      // Setup method channel for toolbar requests
      let toolbarChannel = FlutterMethodChannel(
        name: "com.pdfsign/toolbar",
        binaryMessenger: controller.engine.binaryMessenger
      )

      toolbarChannel.setMethodCallHandler { [weak controller] call, result in
        guard let controller = controller else {
          result(nil)
          return
        }

        switch call.method {
        case "setupToolbar":
          // Setup toolbar when Flutter explicitly requests it
          DispatchQueue.main.async {
            if let window = controller.view.window {
              let toolbarHelper = PDFSignToolbarHelper(
                window: window,
                binaryMessenger: controller.engine.binaryMessenger
              )
              toolbarHelper.setupToolbar()

              // Keep reference to prevent deallocation
              objc_setAssociatedObject(
                window,
                "toolbarHelper",
                toolbarHelper,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
              )
            }
          }
          result(nil)

        default:
          result(FlutterMethodNotImplemented)
        }
      }

      // Setup window channel handler for close/destroy operations
      windowChannel.setMethodCallHandler { [weak controller] call, result in
        guard let controller = controller else {
          result(nil)
          return
        }

        DispatchQueue.main.async {
          switch call.method {
          case "close":
            // Close the window (triggers windowShouldClose delegate)
            controller.view.window?.performClose(nil)
            result(nil)

          case "destroy":
            // Force close without asking delegate
            controller.view.window?.close()
            result(nil)

          case "hide":
            // Hide the window
            controller.view.window?.orderOut(nil)
            result(nil)

          case "show":
            // Show and focus the window
            controller.view.window?.makeKeyAndOrderFront(nil)
            result(nil)

          case "setPreventClose":
            // Enable/disable close prevention (sets up delegate)
            let prevent = call.arguments as? Bool ?? false
            if let window = controller.view.window {
              if prevent {
                let delegate = SubWindowDelegate(
                  window: window,
                  channel: windowChannel
                )
                window.delegate = delegate
                // Keep reference
                objc_setAssociatedObject(
                  window,
                  "windowDelegate",
                  delegate,
                  .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
              } else {
                window.delegate = nil
                objc_setAssociatedObject(
                  window,
                  "windowDelegate",
                  nil,
                  .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
              }
            }
            result(nil)

          default:
            result(FlutterMethodNotImplemented)
          }
        }
      }

      // Setup drop target for sub-windows (desktop_drop only handles main window)
      DispatchQueue.main.async {
        if let window = controller.view.window {
          let dropHelper = SubWindowDropTarget(
            flutterViewController: controller,
            binaryMessenger: controller.engine.binaryMessenger
          )
          dropHelper.setup()

          // Keep reference to prevent deallocation
          objc_setAssociatedObject(
            window,
            "dropHelper",
            dropHelper,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
          )
        }
      }
    }
  }
}

/// Delegate for sub-windows to intercept close events and track focus.
/// Sends events to Flutter: onWindowClose, onWindowFocus, onWindowBlur.
/// Flutter decides whether to close and calls 'destroy' when ready.
class SubWindowDelegate: NSObject, NSWindowDelegate {
  private weak var window: NSWindow?
  private let channel: FlutterMethodChannel
  private var preventClose: Bool = true

  init(window: NSWindow, channel: FlutterMethodChannel) {
    self.window = window
    self.channel = channel
    super.init()
  }

  func setPreventClose(_ prevent: Bool) {
    preventClose = prevent
  }

  func windowShouldClose(_ sender: NSWindow) -> Bool {
    if preventClose {
      // Notify Flutter about close request
      channel.invokeMethod("onWindowClose", arguments: nil)
      // Prevent immediate close - Flutter will call 'destroy' when ready
      return false
    }
    return true
  }

  func windowWillClose(_ notification: Notification) {
    // Window is closing, clean up delegate reference
    window?.delegate = nil
  }

  func windowDidBecomeKey(_ notification: Notification) {
    // Window gained focus
    channel.invokeMethod("onWindowFocus", arguments: nil)
  }

  func windowDidResignKey(_ notification: Notification) {
    // Window lost focus
    channel.invokeMethod("onWindowBlur", arguments: nil)
  }
}

/// Helper class to manage NSToolbar for PDF viewer windows.
class PDFSignToolbarHelper: NSObject, NSToolbarDelegate {
  private weak var window: NSWindow?
  private var methodChannel: FlutterMethodChannel?
  private let shareItemIdentifier = NSToolbarItem.Identifier("ShareItem")

  init(window: NSWindow, binaryMessenger: FlutterBinaryMessenger) {
    self.window = window
    self.methodChannel = FlutterMethodChannel(
      name: "com.pdfsign/toolbar",
      binaryMessenger: binaryMessenger
    )
    super.init()
  }

  func setupToolbar() {
    guard let window = window else { return }

    let toolbar = NSToolbar(identifier: "PDFSignToolbar")
    toolbar.delegate = self
    toolbar.displayMode = .iconOnly
    window.toolbar = toolbar
  }

  // MARK: - NSToolbarDelegate

  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [shareItemIdentifier, .flexibleSpace]
  }

  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [.flexibleSpace, shareItemIdentifier]
  }

  func toolbar(
    _ toolbar: NSToolbar,
    itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
    willBeInsertedIntoToolbar flag: Bool
  ) -> NSToolbarItem? {
    if itemIdentifier == shareItemIdentifier {
      let item = NSToolbarItem(itemIdentifier: itemIdentifier)
      item.label = "Share"
      item.paletteLabel = "Share"
      item.toolTip = "Share this document"

      // Use SF Symbol on macOS 11+, fallback to named image on older versions
      if #available(macOS 11.0, *) {
        if let image = NSImage(systemSymbolName: "square.and.arrow.up", accessibilityDescription: "Share") {
          item.image = image
        }
      } else {
        // Fallback for macOS 10.15
        item.image = NSImage(named: NSImage.actionTemplateName)
      }

      item.action = #selector(shareButtonClicked)
      item.target = self
      return item
    }
    return nil
  }

  @objc func shareButtonClicked() {
    methodChannel?.invokeMethod("onSharePressed", arguments: nil)
  }
}

/// Helper class to setup drop target for sub-windows.
/// desktop_drop only handles the main window, so we need custom handling for sub-windows.
class SubWindowDropTarget: NSObject {
  private weak var flutterViewController: FlutterViewController?
  private var channel: FlutterMethodChannel?
  private var dropView: DropTargetView?

  init(flutterViewController: FlutterViewController, binaryMessenger: FlutterBinaryMessenger) {
    self.flutterViewController = flutterViewController
    self.channel = FlutterMethodChannel(
      name: "desktop_drop",
      binaryMessenger: binaryMessenger
    )
    super.init()
  }

  func setup() {
    guard let vc = flutterViewController, let channel = channel else { return }

    let dropView = DropTargetView(frame: vc.view.bounds, channel: channel)
    dropView.autoresizingMask = [.width, .height]

    dropView.registerForDraggedTypes(
      NSFilePromiseReceiver.readableDraggedTypes.map { NSPasteboard.PasteboardType($0) }
    )
    dropView.registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])

    vc.view.addSubview(dropView)
    self.dropView = dropView
  }
}

/// NSView that handles drag-and-drop operations and sends events to Flutter.
class DropTargetView: NSView {
  private let channel: FlutterMethodChannel

  init(frame frameRect: NSRect, channel: FlutterMethodChannel) {
    self.channel = channel
    super.init(frame: frameRect)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
    channel.invokeMethod("entered", arguments: convertPoint(sender.draggingLocation))
    return .copy
  }

  override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
    channel.invokeMethod("updated", arguments: convertPoint(sender.draggingLocation))
    return .copy
  }

  override func draggingExited(_ sender: NSDraggingInfo?) {
    channel.invokeMethod("exited", arguments: nil)
  }

  /// Directory URL used for accepting file promises.
  private lazy var destinationURL: URL = {
    let destinationURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("Drops")
    try? FileManager.default.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
    return destinationURL
  }()

  /// Queue used for reading and writing file promises.
  private lazy var workQueue: OperationQueue = {
    let providerQueue = OperationQueue()
    providerQueue.qualityOfService = .userInitiated
    return providerQueue
  }()

  override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
    var urls = [String]()

    let searchOptions: [NSPasteboard.ReadingOptionKey: Any] = [
      .urlReadingFileURLsOnly: true,
    ]

    let group = DispatchGroup()

    sender.enumerateDraggingItems(
      options: [],
      for: nil,
      classes: [NSFilePromiseReceiver.self, NSURL.self],
      searchOptions: searchOptions
    ) { draggingItem, _, _ in
      switch draggingItem.item {
      case let filePromiseReceiver as NSFilePromiseReceiver:
        group.enter()
        filePromiseReceiver.receivePromisedFiles(
          atDestination: self.destinationURL,
          options: [:],
          operationQueue: self.workQueue
        ) { fileURL, error in
          if error == nil {
            urls.append(fileURL.path)
          }
          group.leave()
        }
      case let fileURL as URL:
        urls.append(fileURL.path)
      default:
        break
      }
    }

    group.notify(queue: .main) {
      self.channel.invokeMethod("performOperation", arguments: urls)
    }
    return true
  }

  private func convertPoint(_ location: NSPoint) -> [CGFloat] {
    return [location.x, bounds.height - location.y]
  }
}
