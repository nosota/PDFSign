import Cocoa
import XCTest

@testable import PDFSign

/// Covers the placement of document windows.
///
/// These build real `NSWindow`s: the behaviour under test is AppKit's own
/// cascade, and a stand-in would only prove the stand-in works.
final class WindowCascadeTests: XCTestCase {
  private var windows: [NSWindow] = []

  override func tearDown() {
    for window in windows {
      window.close()
    }
    windows.removeAll()
    super.tearDown()
  }

  /// A window the size the plugin creates its own with.
  private func makeWindow() -> NSWindow {
    let window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 800, height: 600),
      styleMask: [.titled, .closable, .resizable],
      backing: .buffered,
      defer: false)
    // A test that closes a window must not leave a dangling reference.
    window.isReleasedWhenClosed = false
    windows.append(window)
    return window
  }

  private func topLeft(of window: NSWindow) -> NSPoint {
    NSPoint(x: window.frame.minX, y: window.frame.maxY)
  }

  func testShouldCentreTheFirstWindow() {
    let expected = makeWindow()
    expected.center()

    let window = makeWindow()
    WindowCascade().place(window)

    XCTAssertEqual(window.frame.origin.x, expected.frame.origin.x, accuracy: 1)
    XCTAssertEqual(window.frame.origin.y, expected.frame.origin.y, accuracy: 1)
  }

  func testShouldStepTheSecondWindowDownAndToTheRight() {
    let cascade = WindowCascade()
    let first = makeWindow()
    let second = makeWindow()

    cascade.place(first)
    cascade.place(second)

    XCTAssertGreaterThan(topLeft(of: second).x, topLeft(of: first).x)
    XCTAssertLessThan(topLeft(of: second).y, topLeft(of: first).y)
  }

  func testShouldNotPutTwoWindowsInARowInTheSameSpot() {
    // The defect this guards: every window in one corner, all but the last
    // invisible. Enough windows to run off the bottom and the right edge,
    // where AppKit restarts the diagonal.
    let cascade = WindowCascade()
    var previous: NSPoint?
    let visible = NSScreen.main?.visibleFrame ?? .zero

    for _ in 0..<24 {
      let window = makeWindow()
      cascade.place(window)
      let placed = topLeft(of: window)

      if let previous = previous {
        XCTAssertNotEqual(placed, previous, "a window landed on the one before it")
      }
      XCTAssertTrue(
        visible.intersects(window.frame), "a window was placed off the screen")
      previous = placed
    }
  }

  func testShouldLeaveAWindowItHasAlreadyPlacedWhereItIs() {
    // Placement happens once, when the window is created; wherever the person
    // using it drags it afterwards is their business.
    let cascade = WindowCascade()
    let window = makeWindow()
    cascade.place(window)

    let moved = NSPoint(x: window.frame.minX + 200, y: window.frame.minY - 100)
    window.setFrameOrigin(moved)
    cascade.place(window)

    XCTAssertEqual(window.frame.origin.x, moved.x, accuracy: 1)
    XCTAssertEqual(window.frame.origin.y, moved.y, accuracy: 1)
  }

  func testShouldStartTheDiagonalOverWhenTheLastWindowCloses() {
    // Otherwise the diagonal keeps marching across a long session, and a
    // document opened on its own lands wherever the last batch stopped.
    let cascade = WindowCascade()
    let first = makeWindow()
    cascade.place(first)
    let centred = first.frame.origin

    let second = makeWindow()
    cascade.place(second)
    XCTAssertEqual(cascade.placedWindowCount, 2)

    first.close()
    second.close()
    XCTAssertEqual(cascade.placedWindowCount, 0, "closed windows are forgotten")

    let afterwards = makeWindow()
    cascade.place(afterwards)

    XCTAssertEqual(afterwards.frame.origin.x, centred.x, accuracy: 1)
    XCTAssertEqual(afterwards.frame.origin.y, centred.y, accuracy: 1)
  }
}
