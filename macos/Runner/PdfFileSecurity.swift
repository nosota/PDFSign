import Cocoa
import FlutterMacOS
import Quartz

/// Reads whether a PDF is encrypted, using the parser that renders it.
///
/// Two libraries have a say about a document here and neither can answer this
/// on its own. The renderer, pdfx, refuses every encrypted file on macOS
/// without saying why. The writer, syncfusion, has no public way to report
/// that a document was encrypted at all — its `security.algorithm` returns a
/// default value for a plain file, so it cannot be used to tell one from the
/// other. CoreGraphics is the authority the renderer itself answers to, which
/// makes it the right one to ask.
enum PdfFileSecurity {
  /// Describes the encryption on the PDF at [path].
  ///
  /// Returns nil when the file cannot be parsed as a PDF at all, which is a
  /// different answer from "not encrypted" and is reported as such.
  static func inspect(path: String) -> [String: Any]? {
    guard let document = CGPDFDocument(URL(fileURLWithPath: path) as CFURL) else {
      return nil
    }
    return [
      "isEncrypted": document.isEncrypted,
      // A document carrying only an owner password is encrypted and already
      // open: the empty user password unlocked it. It needs no password from
      // the reader, but its permissions still apply.
      "isUnlocked": document.isUnlocked,
    ]
  }
}

/// Wires `com.pdfsign/pdf_security` for one Flutter engine.
func setupPdfSecurityChannel(binaryMessenger: FlutterBinaryMessenger) {
  let channel = FlutterMethodChannel(
    name: "com.pdfsign/pdf_security",
    binaryMessenger: binaryMessenger
  )

  channel.setMethodCallHandler { call, result in
    switch call.method {
    case "inspect":
      guard let path = call.arguments as? String else {
        result(
          FlutterError(
            code: "INVALID_ARGUMENT", message: "A file path is required", details: nil))
        return
      }
      result(PdfFileSecurity.inspect(path: path))
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
