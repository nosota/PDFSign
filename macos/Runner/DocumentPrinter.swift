import Cocoa
import FlutterMacOS
import Quartz

/// What came of asking to print.
enum PrintOutcome: String {
  /// The job went to the printer.
  case printed
  /// The reader closed the panel without printing.
  case cancelled
  /// The document withholds printing from whoever opened it.
  case notAllowed
  /// The bytes are not a PDF this system can read, or the password was wrong.
  case unreadable
}

/// A print operation, or the reason there is none.
enum PrintPreparation {
  case ready(NSPrintOperation)
  case notAllowed
  case unreadable
}

/// Prints a document held in memory, through the panel macOS shows for PDFs.
///
/// The panel is the system's own: copies, page range, paper, orientation,
/// scaling, layout, the preview and the PDF menu all come with it, and so do
/// the printer's own settings. Nothing here reimplements any of that.
///
/// The bytes arrive from `PdfSaveService.composePdfBytes` — the document as
/// the reader sees it, objects and page turns included — and are never written
/// to a file of their own (ADR-0011). What the printing system spools is its
/// own business and out of this app's hands.
enum DocumentPrinter {
  /// Builds the print operation for [data], or says why it cannot.
  ///
  /// [password] is what opens the document when it is protected; supplying the
  /// owner's grants full rights, exactly as it does everywhere else. The
  /// permission is read from the document itself rather than taken on trust
  /// from the caller, so a document that withholds printing is refused here
  /// even if something upstream forgot to ask.
  ///
  /// [firstPage] and [lastPage] pre-fill the panel's range. Both nil leaves it
  /// at every page.
  static func prepare(
    data: Data,
    jobName: String,
    firstPage: Int? = nil,
    lastPage: Int? = nil,
    password: String? = nil
  ) -> PrintPreparation {
    guard let document = PDFDocument(data: data) else { return .unreadable }
    // Tried even when the document is not locked: one that carries only an
    // owner password opens for anyone with the permissions it grants, and the
    // owner password is what raises those to full rights. A password that
    // fits nothing changes nothing, which is why the answer is ignored here
    // and the state of the document is read instead.
    if let password = password, !password.isEmpty {
      _ = document.unlock(withPassword: password)
    }
    guard !document.isLocked else { return .unreadable }
    guard document.allowsPrinting else { return .notAllowed }

    let info = (NSPrintInfo.shared.copy() as? NSPrintInfo) ?? NSPrintInfo.shared
    if let first = firstPage, let last = lastPage {
      let attributes = info.dictionary()
      attributes[NSPrintInfo.AttributeKey.allPages] = false
      attributes[NSPrintInfo.AttributeKey.firstPage] = first
      attributes[NSPrintInfo.AttributeKey.lastPage] = last
    }

    // Down to fit rather than to fit: a page smaller than the paper is left
    // at its own size, and one larger is shrunk rather than clipped. Rotation
    // follows, so a landscape page is not printed with its sides cut off.
    guard
      let operation = document.printOperation(
        for: info,
        scalingMode: .pageScaleDownToFit,
        autoRotate: true
      )
    else { return .unreadable }

    operation.jobTitle = jobName
    operation.showsPrintPanel = true
    operation.showsProgressPanel = true
    return .ready(operation)
  }

  /// Shows the print panel over [window] and reports what came of it.
  static func print(
    data: Data,
    jobName: String,
    firstPage: Int? = nil,
    lastPage: Int? = nil,
    password: String? = nil,
    window: NSWindow?,
    completion: @escaping (PrintOutcome) -> Void
  ) {
    switch prepare(
      data: data,
      jobName: jobName,
      firstPage: firstPage,
      lastPage: lastPage,
      password: password
    ) {
    case .notAllowed:
      completion(.notAllowed)
    case .unreadable:
      completion(.unreadable)
    case .ready(let operation):
      guard let window = window else {
        completion(operation.run() ? .printed : .cancelled)
        return
      }
      // The panel is a sheet on the document's own window, so every window
      // prints its own document and none of them blocks the others.
      let watcher = PrintWatcher { success in
        completion(success ? .printed : .cancelled)
      }
      watcher.run(operation, over: window)
    }
  }
}

/// Holds on to itself until the print panel is done with it.
///
/// `runModal(for:delegate:didRun:contextInfo:)` keeps no strong reference to
/// its delegate, and the panel outlives the call that opened it.
private final class PrintWatcher: NSObject {
  private let done: (Bool) -> Void
  private var keepAlive: PrintWatcher?

  init(done: @escaping (Bool) -> Void) {
    self.done = done
  }

  func run(_ operation: NSPrintOperation, over window: NSWindow) {
    keepAlive = self
    operation.runModal(
      for: window,
      delegate: self,
      didRun: #selector(printOperationDidRun(_:success:contextInfo:)),
      contextInfo: nil
    )
  }

  @objc private func printOperationDidRun(
    _ operation: NSPrintOperation,
    success: Bool,
    contextInfo: UnsafeMutableRawPointer?
  ) {
    done(success)
    keepAlive = nil
  }
}

/// Wires `com.pdfsign/print` for one window's engine.
func setupPrintChannel(controller: FlutterViewController) {
  let channel = FlutterMethodChannel(
    name: "com.pdfsign/print",
    binaryMessenger: controller.engine.binaryMessenger
  )

  channel.setMethodCallHandler { [weak controller] call, result in
    switch call.method {
    case "print":
      guard let arguments = call.arguments as? [String: Any],
        let bytes = arguments["bytes"] as? FlutterStandardTypedData
      else {
        result(
          FlutterError(
            code: "INVALID_ARGUMENT", message: "The document to print is required",
            details: nil))
        return
      }

      DocumentPrinter.print(
        data: bytes.data,
        jobName: (arguments["jobName"] as? String) ?? "Document",
        firstPage: arguments["firstPage"] as? Int,
        lastPage: arguments["lastPage"] as? Int,
        password: arguments["password"] as? String,
        window: controller?.view.window
      ) { outcome in
        result(outcome.rawValue)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
