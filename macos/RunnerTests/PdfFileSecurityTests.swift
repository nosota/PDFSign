import Quartz
import XCTest

@testable import PDFSign

/// Covers the answer the app relies on to decide how to open a document.
///
/// The files are made here rather than checked in, so the test says in one
/// place what each case actually is.
final class PdfFileSecurityTests: XCTestCase {
  private var directory: URL!

  override func setUpWithError() throws {
    directory = URL(fileURLWithPath: NSTemporaryDirectory())
      .appendingPathComponent("pdfsign-security-\(UUID().uuidString)")
    try FileManager.default.createDirectory(
      at: directory, withIntermediateDirectories: true)
  }

  override func tearDownWithError() throws {
    try FileManager.default.removeItem(at: directory)
  }

  /// A one-page PDF with nothing protecting it.
  private func makePlainPdf(named name: String) throws -> URL {
    let url = directory.appendingPathComponent(name)
    var media = CGRect(x: 0, y: 0, width: 200, height: 200)
    guard let context = CGContext(url as CFURL, mediaBox: &media, nil) else {
      throw XCTSkip("Could not create a PDF context")
    }
    context.beginPDFPage(nil)
    context.setFillColor(CGColor(gray: 0, alpha: 1))
    context.fill(CGRect(x: 20, y: 20, width: 80, height: 40))
    context.endPDFPage()
    context.closePDF()
    return url
  }

  /// The same PDF, encrypted with whichever passwords are given.
  private func makeEncryptedPdf(
    named name: String,
    userPassword: String?,
    ownerPassword: String
  ) throws -> URL {
    let source = try makePlainPdf(named: "source-\(name)")
    let destination = directory.appendingPathComponent(name)
    guard let document = PDFDocument(url: source) else {
      throw XCTSkip("Could not read the PDF just written")
    }
    var options: [PDFDocumentWriteOption: Any] = [
      .ownerPasswordOption: ownerPassword
    ]
    if let userPassword = userPassword {
      options[.userPasswordOption] = userPassword
    }
    XCTAssertTrue(document.write(to: destination, withOptions: options))
    return destination
  }

  func testShouldReportAPlainDocumentAsUnprotected() throws {
    let url = try makePlainPdf(named: "plain.pdf")

    let result = PdfFileSecurity.inspect(path: url.path)

    XCTAssertEqual(result?["isEncrypted"] as? Bool, false)
    XCTAssertEqual(result?["isUnlocked"] as? Bool, true)
  }

  func testShouldReportADocumentThatNeedsAPasswordAsLocked() throws {
    let url = try makeEncryptedPdf(
      named: "user.pdf", userPassword: "open-me", ownerPassword: "own-me")

    let result = PdfFileSecurity.inspect(path: url.path)

    XCTAssertEqual(result?["isEncrypted"] as? Bool, true)
    XCTAssertEqual(result?["isUnlocked"] as? Bool, false)
  }

  func testShouldReportARestrictedButReadableDocumentAsAlreadyOpen() throws {
    // Only an owner password: any viewer opens it, and its permissions still
    // apply. This is the case the app used to refuse outright, because the
    // renderer turns down anything encrypted whether it is locked or not.
    let url = try makeEncryptedPdf(
      named: "owner.pdf", userPassword: nil, ownerPassword: "own-me")

    let result = PdfFileSecurity.inspect(path: url.path)

    XCTAssertEqual(result?["isEncrypted"] as? Bool, true)
    XCTAssertEqual(result?["isUnlocked"] as? Bool, true)
  }

  func testShouldGiveNoAnswerForSomethingThatIsNotAPdf() throws {
    // Nothing is a different answer from "not encrypted", and the caller acts
    // on the difference: it goes on and lets the renderer speak.
    let url = directory.appendingPathComponent("not-a.pdf")
    try Data("certainly not a PDF".utf8).write(to: url)

    XCTAssertNil(PdfFileSecurity.inspect(path: url.path))
  }

  func testShouldGiveNoAnswerForAFileThatIsNotThere() {
    XCTAssertNil(
      PdfFileSecurity.inspect(path: directory.appendingPathComponent("gone.pdf").path))
  }
}
