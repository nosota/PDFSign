import Cocoa
import FlutterMacOS
import XCTest

@testable import PDFSign

/// Minimal messenger so a helper can be built without a Flutter engine.
private final class StubBinaryMessenger: NSObject, FlutterBinaryMessenger {
  func send(onChannel channel: String, message: Data?) {}

  func send(onChannel channel: String, message: Data?, binaryReply callback: FlutterBinaryReply?) {}

  func setMessageHandlerOnChannel(
    _ channel: String,
    binaryMessageHandler handler: FlutterBinaryMessageHandler?
  ) -> FlutterBinaryMessengerConnection {
    return 0
  }

  func cleanUpConnection(_ connection: FlutterBinaryMessengerConnection) {}
}

final class PDFSignToolbarHelperTests: XCTestCase {
  private var window: NSWindow!
  private var helper: PDFSignToolbarHelper!

  private static let deleteIdentifier = "DeleteItem"

  override func setUp() {
    super.setUp()
    window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
      styleMask: [.titled],
      backing: .buffered,
      defer: false
    )
    // NSWindow releases itself on close by default, which would over-release
    // the reference this test holds.
    window.isReleasedWhenClosed = false
    helper = PDFSignToolbarHelper(window: window, binaryMessenger: StubBinaryMessenger())
    helper.setupToolbar()

    // The item set is fixed, so every test starts from the same toolbar.
    XCTAssertEqual(deleteItemCount(), 1, "Delete is always in the toolbar")
  }

  override func tearDown() {
    if let window = window {
      toolbarHelpers.removeValue(forKey: ObjectIdentifier(window))
    }
    helper = nil
    window = nil
    super.tearDown()
  }

  private func deleteItemCount() -> Int {
    let items = window.toolbar?.items ?? []
    return items.filter { $0.itemIdentifier.rawValue == Self.deleteIdentifier }.count
  }

  private func deleteItem() -> NSToolbarItem? {
    return window.toolbar?.items.first { $0.itemIdentifier.rawValue == Self.deleteIdentifier }
  }

  private func identifiers() -> [String] {
    return (window.toolbar?.items ?? []).map { $0.itemIdentifier.rawValue }
  }

  // MARK: - A toolbar that never rearranges

  /// The whole point of the design. An item set that never changes cannot move
  /// the controls beside it, cannot duplicate an item, and cannot put NSToolbar
  /// into the inconsistent state that twice aborted the process.
  func testShouldKeepTheSameItemsWhateverTheSelectionDoes() {
    let before = identifiers()

    helper.setDeleteButtonEnabled(true, label: nil, tooltip: nil)
    XCTAssertEqual(identifiers(), before)

    helper.setDeleteButtonEnabled(false, label: nil, tooltip: nil)
    XCTAssertEqual(identifiers(), before)

    for _ in 0..<10 {
      helper.setDeleteButtonEnabled(true, label: nil, tooltip: nil)
      helper.setDeleteButtonEnabled(false, label: nil, tooltip: nil)
    }
    XCTAssertEqual(identifiers(), before, "alternating selection must not rearrange anything")
    XCTAssertEqual(deleteItemCount(), 1)
  }

  func testShouldLayOutRotationDeleteAndShareInThatOrder() {
    XCTAssertEqual(
      identifiers(),
      [
        "RotateGroup",
        "NSToolbarFlexibleSpaceItem",
        "DeleteItem",
        "NSToolbarSpaceItem",
        "ShareItem",
      ],
      "rotation leads; Delete stands on its own, apart from Share"
    )
  }

  /// Deleting the selected object and sharing the document are unrelated, and
  /// two icons side by side read as one control.
  func testShouldSeparateDeleteFromShare() {
    let items = identifiers()
    let delete = items.firstIndex(of: "DeleteItem")
    let share = items.firstIndex(of: "ShareItem")

    XCTAssertNotNil(delete)
    XCTAssertNotNil(share)
    XCTAssertEqual(
      items[delete! + 1],
      "NSToolbarSpaceItem",
      "a gap must stand between them"
    )
    XCTAssertEqual(share, delete! + 2)
  }

  // MARK: - Delete follows the selection

  func testShouldStartDisabledBecauseNothingIsSelected() {
    XCTAssertEqual(deleteItem()?.isEnabled, false)
  }

  func testShouldEnableWhenSomethingIsSelected() {
    helper.setDeleteButtonEnabled(true, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItem()?.isEnabled, true)
  }

  func testShouldDisableAgainWhenTheSelectionClears() {
    helper.setDeleteButtonEnabled(true, label: nil, tooltip: nil)
    helper.setDeleteButtonEnabled(false, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItem()?.isEnabled, false)
  }

  func testShouldBeIdempotent() {
    helper.setDeleteButtonEnabled(true, label: nil, tooltip: nil)
    helper.setDeleteButtonEnabled(true, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItem()?.isEnabled, true)
    XCTAssertEqual(deleteItemCount(), 1)
  }

  func testShouldTakeLocalizedTexts() {
    helper.setDeleteButtonEnabled(true, label: "Löschen", tooltip: "Objekt löschen")

    XCTAssertEqual(deleteItem()?.label, "Löschen")
    XCTAssertEqual(deleteItem()?.paletteLabel, "Löschen")
    XCTAssertEqual(deleteItem()?.toolTip, "Objekt löschen")
  }

  func testShouldKeepTextsWhenNoneAreGiven() {
    helper.setDeleteButtonEnabled(true, label: "Löschen", tooltip: "Objekt löschen")
    helper.setDeleteButtonEnabled(false, label: nil, tooltip: nil)

    XCTAssertEqual(deleteItem()?.label, "Löschen", "a state change must not undo the translation")
  }

  /// The Dart listener is edge-triggered, so a request that arrives before the
  /// toolbar exists is never repeated and has to be replayed on setup.
  func testShouldApplyARequestMadeBeforeSetup() {
    let pending = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
      styleMask: [.titled],
      backing: .buffered,
      defer: false
    )
    pending.isReleasedWhenClosed = false
    let pendingHelper = PDFSignToolbarHelper(
      window: pending,
      binaryMessenger: StubBinaryMessenger()
    )

    // No toolbar yet — this would otherwise be dropped on the floor.
    XCTAssertNil(pending.toolbar)
    pendingHelper.setDeleteButtonEnabled(true, label: "Delete", tooltip: "tip")

    pendingHelper.setupToolbar()

    let item = pending.toolbar?.items.first {
      $0.itemIdentifier.rawValue == Self.deleteIdentifier
    }
    XCTAssertEqual(item?.isEnabled, true, "the pending request must be applied on setup")

    toolbarHelpers.removeValue(forKey: ObjectIdentifier(pending))
  }

  func testShouldSurviveAToolbarThatCannotBeReached() {
    // A window torn down between the selection changing and the call arriving.
    let detached = window.toolbar
    window.toolbar = nil

    helper.setDeleteButtonEnabled(true, label: nil, tooltip: nil)

    window.toolbar = detached
    XCTAssertEqual(deleteItemCount(), 1)
  }

  // MARK: - Windows are independent

  /// NSToolbar shares its item set between instances created with the same
  /// identifier, which is what made one window strip another window's button.
  /// Each helper therefore uses an identifier of its own.
  func testShouldNotDisturbAnotherWindowsToolbar() {
    helper.setDeleteButtonEnabled(true, label: "First", tooltip: nil)

    let second = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
      styleMask: [.titled],
      backing: .buffered,
      defer: false
    )
    second.isReleasedWhenClosed = false
    let secondHelper = PDFSignToolbarHelper(
      window: second,
      binaryMessenger: StubBinaryMessenger()
    )
    secondHelper.setupToolbar()

    let secondItem = second.toolbar?.items.first {
      $0.itemIdentifier.rawValue == Self.deleteIdentifier
    }
    XCTAssertEqual(secondItem?.isEnabled, false, "a new window starts with nothing selected")
    XCTAssertEqual(deleteItem()?.isEnabled, true, "and must not reach into the first window")
    XCTAssertEqual(deleteItem()?.label, "First")

    toolbarHelpers.removeValue(forKey: ObjectIdentifier(second))
  }

  // MARK: - Helper registry

  func testShouldNotClaimAWindowItDoesNotOwn() {
    let other = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 100, height: 100),
      styleMask: [.titled],
      backing: .buffered,
      defer: false
    )
    XCTAssertTrue(helper.owns(window))
    XCTAssertFalse(helper.owns(other), "a recycled address must not pass for the same window")
  }

  func testShouldEvictItselfFromTheRegistryWhenTheWindowCloses() {
    let key = ObjectIdentifier(window!)
    toolbarHelpers[key] = helper
    XCTAssertNotNil(toolbarHelpers[key])

    window.close()

    let drained = expectation(description: "registry eviction runs on the main queue")
    DispatchQueue.main.async { drained.fulfill() }
    wait(for: [drained], timeout: 2)

    XCTAssertNil(
      toolbarHelpers[key],
      "a closed window must not leave its helper behind for the next window at that address"
    )
  }

  // MARK: - The rotate control

  func testShouldBuildRotationAsATwoSegmentGroup() {
    let group = (window.toolbar?.items ?? []).first {
      $0.itemIdentifier.rawValue == "RotateGroup"
    } as? NSToolbarItemGroup

    XCTAssertNotNil(group, "the rotate control must be a group")
    XCTAssertEqual(group?.subitems.count, 2)
    XCTAssertEqual(group?.subitems.first?.itemIdentifier.rawValue, "RotateLeftItem")
    XCTAssertEqual(group?.subitems.last?.itemIdentifier.rawValue, "RotateRightItem")
  }

  /// The toolbar is built before Flutter has resolved a locale, so it starts
  /// in English and is corrected afterwards.
  func testShouldTakeLocalizedRotationTexts() {
    helper.setRotateLabels(left: "Nach links drehen", right: "Nach rechts drehen")

    let group = (window.toolbar?.items ?? []).first {
      $0.itemIdentifier.rawValue == "RotateGroup"
    } as? NSToolbarItemGroup

    XCTAssertEqual(group?.subitems.first?.label, "Nach links drehen")
    XCTAssertEqual(group?.subitems.last?.label, "Nach rechts drehen")
    XCTAssertEqual(group?.subitems.first?.toolTip, "Nach links drehen")
  }
}
