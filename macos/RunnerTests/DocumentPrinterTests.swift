import Cocoa
import Quartz
import XCTest

@testable import PDFSign

final class DocumentPrinterTests: XCTestCase {
  /// A one-page PDF, encrypted as [options] asks.
  ///
  /// Written by CoreGraphics rather than by the app's own writer: what matters
  /// is that the printer reads a document's permissions the way the rest of
  /// the system does, so the fixture has to come from somewhere else.
  private func pdf(options: [CFString: Any] = [:]) -> Data {
    let data = NSMutableData()
    guard let consumer = CGDataConsumer(data: data as CFMutableData) else {
      XCTFail("no consumer")
      return Data()
    }
    var box = CGRect(x: 0, y: 0, width: 595, height: 842)
    var info = options
    info[kCGPDFContextMediaBox] = NSValue(rect: box)
    guard let context = CGContext(consumer: consumer, mediaBox: &box, info as CFDictionary)
    else {
      XCTFail("no context")
      return Data()
    }
    context.beginPDFPage(nil)
    context.setFillColor(CGColor(gray: 0.5, alpha: 1))
    context.fill(CGRect(x: 100, y: 100, width: 200, height: 100))
    context.endPDFPage()
    context.closePDF()
    return data as Data
  }

  /// A document nobody may print without the owner password.
  private func unprintable() -> Data {
    return pdf(options: [
      kCGPDFContextOwnerPassword: "own-me",
      kCGPDFContextUserPassword: "",
      kCGPDFContextAllowsPrinting: false,
    ])
  }

  // MARK: - What can be printed

  func testShouldPrepareAnOrdinaryDocument() {
    switch DocumentPrinter.prepare(data: pdf(), jobName: "Throwaway.pdf") {
    case .ready(let operation):
      XCTAssertEqual(operation.jobTitle, "Throwaway.pdf")
      XCTAssertTrue(operation.showsPrintPanel, "the system panel is the point")
    default:
      XCTFail("an ordinary document should be printable")
    }
  }

  func testShouldRefuseADocumentThatWithholdsPrinting() {
    // The permission is read from the document rather than taken on trust from
    // the caller: this is the last place that can honour it.
    switch DocumentPrinter.prepare(data: unprintable(), jobName: "No.pdf") {
    case .notAllowed:
      break
    default:
      XCTFail("a document that forbids printing must not be prepared")
    }
  }

  func testShouldPrintForWhoeverHoldsTheOwnerPassword() {
    // The owner password grants full access whatever the flags say, here as
    // everywhere else in the app.
    switch DocumentPrinter.prepare(
      data: unprintable(), jobName: "Owned.pdf", password: "own-me")
    {
    case .ready:
      break
    default:
      XCTFail("the owner may print their own document")
    }
  }

  func testShouldRefuseWhatItCannotRead() {
    switch DocumentPrinter.prepare(
      data: Data([0x01, 0x02, 0x03]), jobName: "Rubbish")
    {
    case .unreadable:
      break
    default:
      XCTFail("three bytes are not a document")
    }
  }

  func testShouldRefuseALockedDocumentWithoutItsPassword() {
    let locked = pdf(options: [
      kCGPDFContextOwnerPassword: "own-me",
      kCGPDFContextUserPassword: "open-me",
    ])

    switch DocumentPrinter.prepare(data: locked, jobName: "Locked.pdf") {
    case .unreadable:
      break
    default:
      XCTFail("a document that will not open cannot be printed")
    }
  }

  // MARK: - What the panel opens with

  func testShouldOpenOnEveryPageByDefault() {
    switch DocumentPrinter.prepare(data: pdf(), jobName: "All.pdf") {
    case .ready(let operation):
      let attributes = operation.printInfo.dictionary()
      XCTAssertNotEqual(
        attributes[NSPrintInfo.AttributeKey.allPages] as? Bool, false,
        "printing one page when the reader asked for the document is worse than a click"
      )
    default:
      XCTFail("an ordinary document should be printable")
    }
  }

  func testShouldOpenOnTheRangeItWasGiven() {
    switch DocumentPrinter.prepare(
      data: pdf(), jobName: "One.pdf", firstPage: 3, lastPage: 3)
    {
    case .ready(let operation):
      let attributes = operation.printInfo.dictionary()
      XCTAssertEqual(attributes[NSPrintInfo.AttributeKey.allPages] as? Bool, false)
      XCTAssertEqual(attributes[NSPrintInfo.AttributeKey.firstPage] as? Int, 3)
      XCTAssertEqual(attributes[NSPrintInfo.AttributeKey.lastPage] as? Int, 3)
    default:
      XCTFail("an ordinary document should be printable")
    }
  }

  func testShouldLeaveTheSharedPrintInfoAlone() {
    // The panel is opened with a copy; a range asked for one job must not
    // become the default for the next one, or for another window.
    let before = NSPrintInfo.shared.dictionary()[NSPrintInfo.AttributeKey.firstPage] as? Int

    _ = DocumentPrinter.prepare(
      data: pdf(), jobName: "One.pdf", firstPage: 2, lastPage: 2)

    XCTAssertEqual(
      NSPrintInfo.shared.dictionary()[NSPrintInfo.AttributeKey.firstPage] as? Int, before)
  }
}
