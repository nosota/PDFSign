import Cocoa
import FlutterMacOS
import desktop_multi_window

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    // Don't auto-terminate; Flutter handles window lifecycle
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
    // Register plugin callback for new windows created by desktop_multi_window
    FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
      RegisterGeneratedPlugins(registry: controller)

      // Add toolbar to PDF viewer windows (sub-windows) after window is ready
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
    }
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
