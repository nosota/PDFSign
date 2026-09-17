import Cocoa
import FlutterMacOS
import desktop_multi_window

@main
class AppDelegate: FlutterAppDelegate {
  /// Global Settings window ID, shared across all Flutter engines.
  /// Used to enforce singleton pattern for Settings window.
  static var settingsWindowId: String?

  /// Global map of open PDF files: filePath -> windowId.
  /// Used to prevent opening the same file twice.
  static var openPdfFiles: [String: String] = [:]

  /// Channel for sending file paths to Flutter (main window).
  private var fileHandlerChannel: FlutterMethodChannel?

  /// Files received before Flutter engine is ready.
  private var pendingFiles: [String] = []

  /// Whether Flutter has signaled it's ready to receive files.
  private var isFlutterReady = false

  /// Sets up the file handler channel for Finder integration.
  /// Called asynchronously after app launch to ensure Flutter is ready.
  private func setupFileHandlerChannel() {
    guard let mainController = mainFlutterWindow?.contentViewController as? FlutterViewController else {
      // Retry after a short delay if Flutter window not ready yet
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
        self?.setupFileHandlerChannel()
      }
      return
    }

    setupSettingsSingletonChannel(binaryMessenger: mainController.engine.binaryMessenger)
    setupOpenPdfFilesChannel(binaryMessenger: mainController.engine.binaryMessenger)
    setupWindowListChannel(binaryMessenger: mainController.engine.binaryMessenger)
    setupPdfSecurityChannel(binaryMessenger: mainController.engine.binaryMessenger)

    // Setup file handler channel for Finder integration
    fileHandlerChannel = FlutterMethodChannel(
      name: "com.pdfsign/file_handler",
      binaryMessenger: mainController.engine.binaryMessenger
    )

    fileHandlerChannel?.setMethodCallHandler { [weak self] call, result in
      if call.method == "ready" {
        self?.isFlutterReady = true
        self?.sendPendingFiles()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    // Don't auto-terminate when last window closes
    // Flutter/Welcome window handles app lifecycle with exit(0)
    return false
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationDidFinishLaunching(_ notification: Notification) {
    // Delay channel setup to next run loop iteration
    // This ensures Flutter engine is fully initialized
    DispatchQueue.main.async { [weak self] in
      self?.setupFileHandlerChannel()
    }
    // Register plugin callback for new windows created by desktop_multi_window
    FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
      RegisterGeneratedPlugins(registry: controller)

      // Every window the plugin creates is given the same frame, so without
      // this they would all sit in one spot. Done first, before the window is
      // drawn, so it is never seen in the corner it was created in.
      if let window = controller.view.window {
        WindowCascade.shared.place(window)
      }

      // Setup channels for sub-windows
      setupSettingsSingletonChannel(binaryMessenger: controller.engine.binaryMessenger)
      setupOpenPdfFilesChannel(binaryMessenger: controller.engine.binaryMessenger)
      setupWindowListChannel(binaryMessenger: controller.engine.binaryMessenger)
      setupPdfSecurityChannel(binaryMessenger: controller.engine.binaryMessenger)

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

              // Store reference in static dictionary
              let windowId = ObjectIdentifier(window)
              toolbarHelpers[windowId] = toolbarHelper
            } else {
              // Retry after a short delay if window not ready
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let window = controller.view.window {
                  let toolbarHelper = PDFSignToolbarHelper(
                    window: window,
                    binaryMessenger: controller.engine.binaryMessenger
                  )
                  toolbarHelper.setupToolbar()
                  let windowId = ObjectIdentifier(window)
                  toolbarHelpers[windowId] = toolbarHelper
                }
              }
            }
          }
          result(nil)

        case "setDeleteButtonEnabled":
          // Grey the delete button out when there is nothing selected
          let args = call.arguments as? [String: Any] ?? [:]
          let enabled = args["enabled"] as? Bool ?? false
          let label = args["label"] as? String
          let tooltip = args["tooltip"] as? String
          DispatchQueue.main.async {
            if let window = controller.view.window,
               let toolbarHelper = toolbarHelpers[ObjectIdentifier(window)],
               toolbarHelper.owns(window) {
              toolbarHelper.setDeleteButtonEnabled(enabled, label: label, tooltip: tooltip)
            }
          }
          result(nil)

        case "setProtectionState":
          let args = call.arguments as? [String: Any] ?? [:]
          let isProtected = args["protected"] as? Bool ?? false
          let label = args["label"] as? String
          let tooltip = args["tooltip"] as? String
          DispatchQueue.main.async {
            if let window = controller.view.window,
               let toolbarHelper = toolbarHelpers[ObjectIdentifier(window)],
               toolbarHelper.owns(window) {
              toolbarHelper.setProtectionState(
                protected: isProtected, label: label, tooltip: tooltip)
            }
          }
          result(nil)

        case "setHistoryEnabled":
          // Grey each half of the undo control out on its own
          let args = call.arguments as? [String: Any] ?? [:]
          let canUndo = args["canUndo"] as? Bool ?? false
          let canRedo = args["canRedo"] as? Bool ?? false
          let labels = args["labels"] as? [String]
          DispatchQueue.main.async {
            if let window = controller.view.window,
               let toolbarHelper = toolbarHelpers[ObjectIdentifier(window)],
               toolbarHelper.owns(window) {
              toolbarHelper.setHistoryEnabled(
                canUndo: canUndo, canRedo: canRedo, labels: labels)
            }
          }
          result(nil)

        case "setZOrderEnabled":
          // Grey the restacking control out when there is nothing selected
          let args = call.arguments as? [String: Any] ?? [:]
          let enabled = args["enabled"] as? Bool ?? false
          let labels = args["labels"] as? [String]
          let groupLabel = args["groupLabel"] as? String
          DispatchQueue.main.async {
            if let window = controller.view.window,
               let toolbarHelper = toolbarHelpers[ObjectIdentifier(window)],
               toolbarHelper.owns(window) {
              toolbarHelper.setZOrderEnabled(
                enabled, labels: labels, groupLabel: groupLabel)
            }
          }
          result(nil)

        case "setRotateLabels":
          let args = call.arguments as? [String: Any] ?? [:]
          let left = args["left"] as? String
          let right = args["right"] as? String
          DispatchQueue.main.async {
            if let window = controller.view.window,
               let toolbarHelper = toolbarHelpers[ObjectIdentifier(window)],
               toolbarHelper.owns(window),
               let left = left, let right = right {
              toolbarHelper.setRotateLabels(left: left, right: right)
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
            NSLog("WindowChannel: setPreventClose(%@) called", prevent ? "true" : "false")

            // Helper function to setup delegate
            func setupDelegate(window: NSWindow) {
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
                NSLog("WindowChannel: SubWindowDelegate set up successfully")

                // Send current focus state to Flutter immediately after delegate setup.
                // This ensures Flutter knows the correct state even if the initial
                // windowDidBecomeKey/windowDidResignKey event was missed (e.g., when
                // delegate setup was delayed by 100ms retry).
                if window.isKeyWindow {
                  NSLog("WindowChannel: Window is key, sending onWindowFocus")
                  windowChannel.invokeMethod("onWindowFocus", arguments: nil)
                } else {
                  NSLog("WindowChannel: Window is not key, sending onWindowBlur")
                  windowChannel.invokeMethod("onWindowBlur", arguments: nil)
                }
              } else {
                window.delegate = nil
                objc_setAssociatedObject(
                  window,
                  "windowDelegate",
                  nil,
                  .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
                NSLog("WindowChannel: SubWindowDelegate removed")
              }
            }

            if let window = controller.view.window {
              NSLog("WindowChannel: window found, setting up delegate")
              setupDelegate(window: window)
            } else {
              NSLog("WindowChannel: window is NIL! Retrying in 100ms...")
              // Retry after a short delay - window might not be ready yet
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let window = controller.view.window {
                  NSLog("WindowChannel: retry succeeded, window found")
                  setupDelegate(window: window)
                } else {
                  NSLog("WindowChannel: retry failed, window still nil!")
                }
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

  /// Called by macOS when user opens files via Finder (Open With, double-click, drag to Dock).
  override func application(_ sender: NSApplication, openFiles filenames: [String]) {
    let pdfFiles = filenames
      .filter { $0.lowercased().hasSuffix(".pdf") }
      .filter { FileManager.default.fileExists(atPath: $0) }

    guard !pdfFiles.isEmpty else {
      sender.reply(toOpenOrPrint: .failure)
      return
    }

    if isFlutterReady {
      for file in pdfFiles {
        fileHandlerChannel?.invokeMethod("openFile", arguments: file)
      }
    } else {
      // Flutter not ready yet, queue files for later
      pendingFiles.append(contentsOf: pdfFiles)
    }

    sender.reply(toOpenOrPrint: .success)
  }

  /// Alternative method for opening URLs (macOS 10.13+).
  /// Some versions of macOS may call this instead of openFiles.
  override func application(_ application: NSApplication, open urls: [URL]) {
    let pdfPaths = urls
      .filter { $0.pathExtension.lowercased() == "pdf" }
      .map { $0.path }
      .filter { FileManager.default.fileExists(atPath: $0) }

    guard !pdfPaths.isEmpty else { return }

    if isFlutterReady {
      for path in pdfPaths {
        fileHandlerChannel?.invokeMethod("openFile", arguments: path)
      }
    } else {
      // Only add files not already in queue (prevents duplicates)
      let newPaths = pdfPaths.filter { !pendingFiles.contains($0) }
      if !newPaths.isEmpty {
        pendingFiles.append(contentsOf: newPaths)
      }
    }
  }

  /// Sends queued files to Flutter once it's ready.
  private func sendPendingFiles() {
    guard isFlutterReady,
          !pendingFiles.isEmpty,
          let channel = fileHandlerChannel else { return }

    for file in pendingFiles {
      channel.invokeMethod("openFile", arguments: file)
    }
    pendingFiles.removeAll()
  }
}

/// Sets up the Settings singleton channel for a Flutter engine.
/// This channel allows any Flutter engine to check/set the global Settings window ID.
func setupSettingsSingletonChannel(binaryMessenger: FlutterBinaryMessenger) {
  let channel = FlutterMethodChannel(
    name: "com.pdfsign/settings_singleton",
    binaryMessenger: binaryMessenger
  )

  channel.setMethodCallHandler { call, result in
    switch call.method {
    case "getSettingsWindowId":
      // Return the current Settings window ID (or nil if none)
      result(AppDelegate.settingsWindowId)

    case "setSettingsWindowId":
      // Store the Settings window ID
      let windowId = call.arguments as? String
      AppDelegate.settingsWindowId = windowId
      result(nil)

    case "clearSettingsWindowId":
      // Clear the Settings window ID
      AppDelegate.settingsWindowId = nil
      result(nil)

    case "focusSettingsWindow":
      // Try to bring the Settings window to front
      guard AppDelegate.settingsWindowId != nil else {
        result(false)
        return
      }

      // Find the window with title "Settings" and bring it to front
      for window in NSApplication.shared.windows {
        if window.contentViewController is FlutterViewController {
          if window.title == "Settings" {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            result(true)
            return
          }
        }
      }
      // If we have an ID but couldn't find the window, it was closed
      AppDelegate.settingsWindowId = nil
      result(false)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

/// Sets up the open PDF files channel for a Flutter engine.
/// This channel tracks which PDF files are currently open to prevent duplicates.
func setupOpenPdfFilesChannel(binaryMessenger: FlutterBinaryMessenger) {
  let channel = FlutterMethodChannel(
    name: "com.pdfsign/open_pdf_files",
    binaryMessenger: binaryMessenger
  )

  channel.setMethodCallHandler { call, result in
    switch call.method {
    case "getWindowIdForFile":
      // Return the window ID for a file path (or nil if not open)
      guard let filePath = call.arguments as? String else {
        result(nil)
        return
      }
      result(AppDelegate.openPdfFiles[filePath])

    case "registerPdfFile":
      // Register a file as open with its window ID
      guard let args = call.arguments as? [String: String],
            let filePath = args["filePath"],
            let windowId = args["windowId"] else {
        result(nil)
        return
      }
      AppDelegate.openPdfFiles[filePath] = windowId
      NSLog("OpenPdfFilesChannel: registered %@ -> %@", filePath, windowId)
      result(nil)

    case "unregisterPdfFile":
      // Unregister a file when its window closes
      guard let filePath = call.arguments as? String else {
        result(nil)
        return
      }
      AppDelegate.openPdfFiles.removeValue(forKey: filePath)
      NSLog("OpenPdfFilesChannel: unregistered %@", filePath)
      result(nil)

    case "focusPdfWindow":
      // Try to bring the window for a file to front
      guard let filePath = call.arguments as? String,
            AppDelegate.openPdfFiles[filePath] != nil else {
        result(false)
        return
      }

      // Find the window by checking all Flutter windows
      for window in NSApplication.shared.windows {
        if window.contentViewController is FlutterViewController {
          // Check if this window's title contains the file name
          let fileName = (filePath as NSString).lastPathComponent
          if window.title.contains(fileName) {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            NSLog("OpenPdfFilesChannel: focused window for %@", filePath)
            result(true)
            return
          }
        }
      }

      // Window not found, might be closed - clean up the entry
      AppDelegate.openPdfFiles.removeValue(forKey: filePath)
      NSLog("OpenPdfFilesChannel: window for %@ not found, cleaned up", filePath)
      result(false)

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

/// Sets up the window list channel for a Flutter engine.
/// This channel provides the list of all visible windows for the Window menu.
func setupWindowListChannel(binaryMessenger: FlutterBinaryMessenger) {
  let channel = FlutterMethodChannel(
    name: "com.pdfsign/window_list",
    binaryMessenger: binaryMessenger
  )

  channel.setMethodCallHandler { call, result in
    switch call.method {
    case "getWindowList":
      // Return list of all visible Flutter windows with metadata
      var windowList: [[String: Any]] = []

      for window in NSApplication.shared.windows {
        // Only include Flutter windows (have FlutterViewController)
        guard window.contentViewController is FlutterViewController else {
          continue
        }

        // Skip hidden windows
        guard window.isVisible else {
          continue
        }

        // Determine window type based on title and window number
        // Main window (Welcome) has window number matching main window
        let isMainWindow = window == NSApp.windows.first { $0.contentViewController is FlutterViewController && $0.isMainWindow }
        let title = window.title

        var windowType = "pdf"
        if isMainWindow || title == "PDFSign" {
          windowType = "welcome"
        } else if title == "Settings" || title == "Настройки" {
          windowType = "settings"
        }

        // Get window ID - use window number as string ID
        // For desktop_multi_window, the window number corresponds to the ID
        let windowId = String(window.windowNumber)

        // For Welcome window, use "0" as the conventional ID
        let finalWindowId = windowType == "welcome" ? "0" : windowId

        let windowInfo: [String: Any] = [
          "windowId": finalWindowId,
          "title": title,
          "type": windowType,
          "isKey": window.isKeyWindow,
          "filePath": NSNull()  // Not tracking file paths in native side
        ]

        windowList.append(windowInfo)
      }

      // Sort: PDFs first (by window number/open order), then Settings, then Welcome
      windowList.sort { (a, b) -> Bool in
        let typeA = a["type"] as? String ?? "pdf"
        let typeB = b["type"] as? String ?? "pdf"

        // Define sort order: pdf=0, settings=1, welcome=2
        let orderA = typeA == "pdf" ? 0 : (typeA == "settings" ? 1 : 2)
        let orderB = typeB == "pdf" ? 0 : (typeB == "settings" ? 1 : 2)

        if orderA != orderB {
          return orderA < orderB
        }

        // Within same type, sort by window ID (open order)
        let idA = a["windowId"] as? String ?? ""
        let idB = b["windowId"] as? String ?? ""
        return idA < idB
      }

      result(windowList)

    case "focusWindow":
      // Bring window to front by ID
      guard let windowId = call.arguments as? String else {
        result(false)
        return
      }

      // Special case for Welcome window (ID "0")
      if windowId == "0" {
        for window in NSApplication.shared.windows {
          if window.contentViewController is FlutterViewController {
            if window.title == "PDFSign" || window == NSApp.mainWindow {
              window.makeKeyAndOrderFront(nil)
              NSApp.activate(ignoringOtherApps: true)
              result(true)
              return
            }
          }
        }
      }

      // Find window by window number
      if let windowNumber = Int(windowId) {
        for window in NSApplication.shared.windows {
          if window.windowNumber == windowNumber {
            window.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            result(true)
            return
          }
        }
      }

      result(false)

    case "minimizeWindow":
      // Minimize the key window
      NSApp.keyWindow?.miniaturize(nil)
      result(nil)

    case "zoomWindow":
      // Zoom (maximize/restore) the key window
      NSApp.keyWindow?.zoom(nil)
      result(nil)

    case "bringAllToFront":
      // Bring all app windows to front
      NSApp.activate(ignoringOtherApps: true)
      for window in NSApplication.shared.windows {
        if window.contentViewController is FlutterViewController && window.isVisible {
          window.orderFront(nil)
        }
      }
      result(nil)

    default:
      result(FlutterMethodNotImplemented)
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
    NSLog("SubWindowDelegate: windowShouldClose called, preventClose=%@", preventClose ? "true" : "false")
    if preventClose {
      // Notify Flutter about close request
      NSLog("SubWindowDelegate: invoking onWindowClose to Flutter")
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

/// Toolbar helpers, keyed by window.
///
/// `ObjectIdentifier` is the window's address, which the allocator reuses, so
/// entries must be removed when a window closes and every lookup must confirm
/// ownership with `PDFSignToolbarHelper.owns(_:)`. Internal rather than private
/// so `RunnerTests` can verify that eviction.
var toolbarHelpers: [ObjectIdentifier: PDFSignToolbarHelper] = [:]

/// Helper class to manage NSToolbar for PDF viewer windows.
class PDFSignToolbarHelper: NSObject, NSToolbarDelegate, NSToolbarItemValidation {
  private weak var window: NSWindow?
  private var methodChannel: FlutterMethodChannel?
  private let shareItemIdentifier = NSToolbarItem.Identifier("ShareItem")
  private let deleteItemIdentifier = NSToolbarItem.Identifier("DeleteItem")
  private let protectItemIdentifier = NSToolbarItem.Identifier("ProtectItem")
  private let rotateGroupIdentifier = NSToolbarItem.Identifier("RotateGroup")
  private let historyGroupIdentifier = NSToolbarItem.Identifier("HistoryGroup")
  private let zOrderGroupIdentifier = NSToolbarItem.Identifier("ZOrderGroup")

  /// Localized texts for the rotate control, replaced from Dart.
  ///
  /// English until Dart says otherwise: the toolbar is built before the
  /// Flutter side has resolved a locale, and a window with no labels at all
  /// would be worse than a window with English ones.
  private var rotateLeftLabel = "Rotate Left"
  private var rotateRightLabel = "Rotate Right"

  /// Unique per helper.
  ///
  /// NSToolbar shares its item set *live* between instances created with the
  /// same identifier: removing an item from one window's toolbar removes it
  /// from every other window's toolbar too. A per-window identifier keeps the
  /// windows independent.
  private let toolbarIdentifier = "PDFSignToolbar.\(UUID().uuidString)"

  /// Whether Delete currently has something to act on.
  ///
  /// Kept so a request that arrived before the toolbar existed is not lost:
  /// the Dart listener is edge-triggered and will not repeat it.
  private var deleteEnabled = false

  /// Whether the document has any protection, which is what the lock shows.
  private var documentProtected = false

  private var protectLabel = "Protect"
  private var protectTooltip = "Set this document's passwords and permissions"

  /// Whether each half of the undo control has a step to take.
  ///
  /// Kept for the same reason as the others: the Dart listener is
  /// edge-triggered, so a state that arrives before the toolbar exists would
  /// otherwise be lost.
  private var canUndo = false
  private var canRedo = false

  private var historyLabels = ["Undo", "Redo"]

  /// Whether the restacking control has an object to act on.
  ///
  /// Kept for the same reason as the Delete one: the Dart listener is
  /// edge-triggered, so a request that arrives before the toolbar exists
  /// would otherwise be lost.
  private var zOrderEnabled = false

  private var zOrderLabels = [
    "Send to Back", "Send Backward", "Bring Forward", "Bring to Front",
  ]

  private var deleteLabel: String = "Delete"
  private var deleteTooltip: String = "Delete selected object"

  init(window: NSWindow, binaryMessenger: FlutterBinaryMessenger) {
    self.window = window
    self.methodChannel = FlutterMethodChannel(
      name: "com.pdfsign/toolbar",
      binaryMessenger: binaryMessenger
    )
    super.init()

    // toolbarHelpers is keyed by the window's address, which the allocator
    // reuses. Without this the entry outlives its window and a later window
    // at the same address is handed a helper bound to a dead one.
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(handleWindowWillClose(_:)),
      name: NSWindow.willCloseNotification,
      object: window
    )
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  /// Whether this helper still manages [candidate].
  ///
  /// Callers must check this before use: a matching dictionary key only proves
  /// the addresses match, not that it is the same window.
  func owns(_ candidate: NSWindow) -> Bool {
    return window === candidate
  }

  @objc private func handleWindowWillClose(_ note: Notification) {
    guard let closing = note.object as? NSWindow else { return }
    let key = ObjectIdentifier(closing)
    // Deferred so this helper cannot be deallocated inside its own callback,
    // and guarded by identity so it never evicts a successor that has already
    // claimed the same key.
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      if toolbarHelpers[key] === self {
        toolbarHelpers.removeValue(forKey: key)
      }
    }
  }

  func setupToolbar() {
    guard let window = window else { return }

    let toolbar = NSToolbar(identifier: toolbarIdentifier)
    toolbar.delegate = self
    toolbar.displayMode = .iconOnly
    toolbar.allowsUserCustomization = false
    window.toolbar = toolbar

    // Apply whatever Dart asked for while the toolbar did not yet exist.
    setDeleteButtonEnabled(deleteEnabled, label: nil, tooltip: nil)
  }

  /// Enables or disables the Delete button.
  ///
  /// The item is always in the toolbar. An earlier version inserted and
  /// removed it as the selection changed, which moved everything around it and
  /// which twice put NSToolbar into a state it aborted the process over. A
  /// toolbar whose item set never changes cannot drift, cannot duplicate an
  /// item, and cannot shift the controls beside it.
  func setDeleteButtonEnabled(_ enabled: Bool, label: String?, tooltip: String?) {
    if let label = label {
      deleteLabel = label
    }
    if let tooltip = tooltip {
      deleteTooltip = tooltip
    }
    deleteEnabled = enabled

    guard let item = deleteItem() else { return }
    item.isEnabled = enabled
    item.label = deleteLabel
    item.paletteLabel = deleteLabel
    item.toolTip = deleteTooltip
  }

  /// The Delete item in the live toolbar, or nil before the toolbar exists.
  private func deleteItem() -> NSToolbarItem? {
    return window?.toolbar?.items.first {
      $0.itemIdentifier == deleteItemIdentifier
    }
  }

  // MARK: - NSToolbarDelegate

  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    return [
      historyGroupIdentifier,
      zOrderGroupIdentifier,
      rotateGroupIdentifier,
      deleteItemIdentifier,
      protectItemIdentifier,
      shareItemIdentifier,
      .flexibleSpace,
      .space,
    ]
  }

  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    // Every item, always. Delete is greyed out when nothing is selected rather
    // than taken away: an item set that never changes is an item set that
    // never moves the controls around it.
    return [
      // Undo leads: it undoes whatever any of the others just did.
      historyGroupIdentifier,
      // Restacking sits before the page turns: it acts on the object, and the
      // turns act on the page under it.
      zOrderGroupIdentifier,
      rotateGroupIdentifier,
      .flexibleSpace,
      deleteItemIdentifier,
      // Deleting the selected object, protecting the document and sharing it
      // are three unrelated actions; fixed gaps keep them from reading as one
      // control.
      .space,
      protectItemIdentifier,
      .space,
      shareItemIdentifier,
    ]
  }

  /// Replaces the rotate control's localized texts.
  func setRotateLabels(left: String, right: String) {
    rotateLeftLabel = left
    rotateRightLabel = right

    guard let toolbar = window?.toolbar else { return }
    guard let group = toolbar.items.first(where: {
      $0.itemIdentifier == rotateGroupIdentifier
    }) as? NSToolbarItemGroup else { return }

    group.label = left
    if group.subitems.count == 2 {
      group.subitems[0].label = left
      group.subitems[0].toolTip = left
      group.subitems[1].label = right
      group.subitems[1].toolTip = right
    }
  }

  /// Builds the two-segment rotate control.
  /// The control that takes the document back and forward through its history.
  private func makeHistoryGroup() -> NSToolbarItem {
    let group = NSToolbarItemGroup(itemIdentifier: historyGroupIdentifier)
    group.label = historyLabels[0]
    group.paletteLabel = historyLabels[0]
    group.subitems = [
      makeSymbolItem(
        identifier: "UndoItem",
        symbol: "arrow.uturn.backward",
        label: historyLabels[0],
        action: #selector(undoClicked)
      ),
      makeSymbolItem(
        identifier: "RedoItem",
        symbol: "arrow.uturn.forward",
        label: historyLabels[1],
        action: #selector(redoClicked)
      ),
    ]
    group.subitems[0].isEnabled = canUndo
    group.subitems[1].isEnabled = canRedo

    if #available(macOS 10.15, *) {
      group.controlRepresentation = .expanded
      group.selectionMode = .momentary
    }
    return group
  }

  /// Greys each half out on its own: a document can have somewhere to go back
  /// to and nowhere to come forward from.
  func setHistoryEnabled(canUndo: Bool, canRedo: Bool, labels: [String]?) {
    if let labels = labels, labels.count == 2 {
      historyLabels = labels
    }
    self.canUndo = canUndo
    self.canRedo = canRedo

    guard let group = window?.toolbar?.items.first(where: {
      $0.itemIdentifier == historyGroupIdentifier
    }) as? NSToolbarItemGroup, group.subitems.count == 2 else { return }

    group.label = historyLabels[0]
    for (index, item) in group.subitems.enumerated() {
      item.isEnabled = index == 0 ? canUndo : canRedo
      item.label = historyLabels[index]
      item.paletteLabel = historyLabels[index]
      item.toolTip = historyLabels[index]
    }
  }

  /// The lock, open or closed according to what the document carries.
  private func makeProtectItem() -> NSToolbarItem {
    let item = makeSymbolItem(
      identifier: "ProtectItem",
      symbol: documentProtected ? "lock" : "lock.open",
      label: protectLabel,
      action: #selector(protectClicked)
    )
    item.toolTip = protectTooltip
    return item
  }

  /// Shows the lock closed or open, and replaces its localized texts.
  ///
  /// The document's protection is the one thing in this toolbar a reader
  /// cannot see by looking at the page, so the button carries it.
  func setProtectionState(protected: Bool, label: String?, tooltip: String?) {
    documentProtected = protected
    if let label = label { protectLabel = label }
    if let tooltip = tooltip { protectTooltip = tooltip }

    guard let item = window?.toolbar?.items.first(where: {
      $0.itemIdentifier == protectItemIdentifier
    }) else { return }

    item.label = protectLabel
    item.paletteLabel = protectLabel
    item.toolTip = protectTooltip
    if #available(macOS 11.0, *) {
      item.image = NSImage(
        systemSymbolName: protected ? "lock" : "lock.open",
        accessibilityDescription: protectLabel)
    }
  }

  @objc func protectClicked() {
    methodChannel?.invokeMethod("onProtectPressed", arguments: nil)
  }

  @objc func undoClicked() {
    methodChannel?.invokeMethod("onUndoPressed", arguments: nil)
  }

  @objc func redoClicked() {
    methodChannel?.invokeMethod("onRedoPressed", arguments: nil)
  }

  /// The control that moves the selected object through its page's stack.
  ///
  /// Four segments in the order they move the object: to the back, back one,
  /// forward one, to the front. Reading left to right therefore reads bottom
  /// to top, which is the same direction the arrows point.
  private func makeZOrderGroup() -> NSToolbarItem {
    let group = NSToolbarItemGroup(itemIdentifier: zOrderGroupIdentifier)
    group.label = zOrderLabel
    group.paletteLabel = zOrderLabel

    let symbols = [
      "arrow.down.to.line", "arrow.down", "arrow.up", "arrow.up.to.line",
    ]
    let actions = [
      #selector(sendToBackClicked), #selector(sendBackwardClicked),
      #selector(bringForwardClicked), #selector(bringToFrontClicked),
    ]
    let identifiers = [
      "SendToBackItem", "SendBackwardItem", "BringForwardItem",
      "BringToFrontItem",
    ]

    group.subitems = (0..<4).map { index in
      let item = makeSymbolItem(
        identifier: identifiers[index],
        symbol: symbols[index],
        label: zOrderLabels[index],
        action: actions[index]
      )
      item.isEnabled = zOrderEnabled
      return item
    }

    if #available(macOS 10.15, *) {
      group.controlRepresentation = .expanded
      group.selectionMode = .momentary
    }
    return group
  }

  /// Greys the restacking control out when there is nothing selected.
  func setZOrderEnabled(_ enabled: Bool, labels: [String]?, groupLabel: String?) {
    if let labels = labels, labels.count == 4 {
      zOrderLabels = labels
    }
    if let groupLabel = groupLabel {
      zOrderLabel = groupLabel
    }
    zOrderEnabled = enabled

    guard let group = window?.toolbar?.items.first(where: {
      $0.itemIdentifier == zOrderGroupIdentifier
    }) as? NSToolbarItemGroup else { return }

    group.label = zOrderLabel
    for (index, item) in group.subitems.enumerated() {
      item.isEnabled = enabled
      if index < zOrderLabels.count {
        item.label = zOrderLabels[index]
        item.paletteLabel = zOrderLabels[index]
        item.toolTip = zOrderLabels[index]
      }
    }
  }

  /// What the whole control is called, as against its four segments.
  private var zOrderLabel = "Arrange"

  @objc func sendToBackClicked() {
    methodChannel?.invokeMethod("onSendToBackPressed", arguments: nil)
  }

  @objc func sendBackwardClicked() {
    methodChannel?.invokeMethod("onSendBackwardPressed", arguments: nil)
  }

  @objc func bringForwardClicked() {
    methodChannel?.invokeMethod("onBringForwardPressed", arguments: nil)
  }

  @objc func bringToFrontClicked() {
    methodChannel?.invokeMethod("onBringToFrontPressed", arguments: nil)
  }

  private func makeRotateGroup() -> NSToolbarItem {
    let group = NSToolbarItemGroup(itemIdentifier: rotateGroupIdentifier)
    group.label = rotateLeftLabel
    group.paletteLabel = rotateLeftLabel
    group.subitems = [
      makeSymbolItem(
        identifier: "RotateLeftItem",
        symbol: "rotate.left",
        label: rotateLeftLabel,
        action: #selector(rotateLeftClicked)
      ),
      makeSymbolItem(
        identifier: "RotateRightItem",
        symbol: "rotate.right",
        label: rotateRightLabel,
        action: #selector(rotateRightClicked)
      ),
    ]

    if #available(macOS 10.15, *) {
      // One control of two halves rather than two loose buttons: they are one
      // tool, and a momentary group does not keep a segment pressed.
      group.controlRepresentation = .expanded
      group.selectionMode = .momentary
    }
    return group
  }

  private func makeSymbolItem(
    identifier: String,
    symbol: String,
    label: String,
    action: Selector
  ) -> NSToolbarItem {
    let item = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier(identifier))
    item.label = label
    item.paletteLabel = label
    item.toolTip = label

    if #available(macOS 11.0, *) {
      item.image = NSImage(systemSymbolName: symbol, accessibilityDescription: label)
    }
    if item.image == nil {
      // The symbol set arrived in Big Sur, and a symbol added after that is
      // missing on the systems before it. Either way a button with no picture
      // at all would be worse than the closest template AppKit has always
      // shipped.
      item.image = NSImage(named: NSImage.refreshTemplateName)
    }

    item.action = action
    item.target = self
    item.isEnabled = true
    item.autovalidates = false
    return item
  }

  func toolbar(
    _ toolbar: NSToolbar,
    itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
    willBeInsertedIntoToolbar flag: Bool
  ) -> NSToolbarItem? {
    if itemIdentifier == protectItemIdentifier {
      return makeProtectItem()
    }

    if itemIdentifier == historyGroupIdentifier {
      return makeHistoryGroup()
    }

    if itemIdentifier == zOrderGroupIdentifier {
      return makeZOrderGroup()
    }

    if itemIdentifier == rotateGroupIdentifier {
      return makeRotateGroup()
    }

    if itemIdentifier == shareItemIdentifier {
      let item = NSToolbarItem(itemIdentifier: itemIdentifier)
      item.label = "Share"
      item.paletteLabel = "Share"
      item.toolTip = "Share this document"

      if #available(macOS 11.0, *) {
        if let image = NSImage(systemSymbolName: "square.and.arrow.up", accessibilityDescription: "Share") {
          item.image = image
        }
      } else {
        item.image = NSImage(named: NSImage.actionTemplateName)
      }

      item.action = #selector(shareButtonClicked)
      item.target = self
      item.isEnabled = true
      item.autovalidates = false
      return item
    }

    if itemIdentifier == deleteItemIdentifier {
      let item = NSToolbarItem(itemIdentifier: itemIdentifier)
      item.label = deleteLabel
      item.paletteLabel = deleteLabel
      item.toolTip = deleteTooltip

      if #available(macOS 12.0, *) {
        if let image = NSImage(systemSymbolName: "trash", accessibilityDescription: deleteLabel) {
          let config = NSImage.SymbolConfiguration(paletteColors: [.systemRed])
          item.image = image.withSymbolConfiguration(config)
        }
      } else if #available(macOS 11.0, *) {
        if let image = NSImage(systemSymbolName: "trash", accessibilityDescription: deleteLabel) {
          item.image = image
        }
      } else {
        item.image = NSImage(named: NSImage.stopProgressTemplateName)
      }

      item.action = #selector(deleteButtonClicked)
      item.target = self
      item.isEnabled = deleteEnabled
      item.autovalidates = false
      return item
    }

    return nil
  }

  @objc func shareButtonClicked() {
    methodChannel?.invokeMethod("onSharePressed", arguments: nil)
  }

  @objc func deleteButtonClicked() {
    methodChannel?.invokeMethod("onDeletePressed", arguments: nil)
  }

  @objc func rotateLeftClicked() {
    methodChannel?.invokeMethod("onRotateLeftPressed", arguments: nil)
  }

  @objc func rotateRightClicked() {
    methodChannel?.invokeMethod("onRotateRightPressed", arguments: nil)
  }

  // MARK: - NSToolbarItemValidation

  /// Answers for an item the toolbar asks about on its own.
  ///
  /// The standalone items opt out of validation (`autovalidates = false`), but
  /// a group cannot: `NSToolbarItemGroup` validates its subitems for itself,
  /// and an unconditional "yes" here would light Undo up with nothing to undo
  /// and the restacking arrows with nothing selected — sending presses Dart
  /// then drops in silence.
  @objc func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
    switch item.itemIdentifier.rawValue {
    case "UndoItem":
      return canUndo
    case "RedoItem":
      return canRedo
    case "SendToBackItem", "SendBackwardItem", "BringForwardItem",
      "BringToFrontItem":
      return zOrderEnabled
    default:
      return true
    }
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
