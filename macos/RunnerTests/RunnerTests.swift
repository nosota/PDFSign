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

    // setupToolbar drops an inherited Delete item; assert the fixture really is
    // clean so a leak between tests cannot be mistaken for a passing case.
    XCTAssertEqual(deleteItemCount(), 0, "fixture must start without a Delete item")
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

  // MARK: - Drift that used to abort the process

  /// The real-world trigger. NSToolbar shares its item set between instances
  /// created with the same identifier, so a window could come up with a Delete
  /// button inherited from an earlier window while its own helper believed the
  /// button was absent. The first selection then inserted a second copy and
  /// NSToolbar aborted the process.
  func testShouldNotDuplicateWhenTheToolbarAlreadyCarriesTheItem() {
    guard let toolbar = window.toolbar else {
      return XCTFail("setupToolbar did not install a toolbar")
    }
    // Stand in for AppKit handing over a pre-populated toolbar.
    toolbar.insertItem(
      withItemIdentifier: NSToolbarItem.Identifier(Self.deleteIdentifier),
      at: max(0, toolbar.items.count - 1)
    )
    XCTAssertEqual(deleteItemCount(), 1)

    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)

    XCTAssertEqual(deleteItemCount(), 1, "the inherited item must be reused, not duplicated")
  }

  /// A window opens with nothing selected, so an inherited button must go.
  func testShouldStartWithoutAnInheritedDeleteItem() {
    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItemCount(), 1)

    // A second window of the same app, built the same way.
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

    let inherited = (second.toolbar?.items ?? [])
      .filter { $0.itemIdentifier.rawValue == Self.deleteIdentifier }
    XCTAssertTrue(inherited.isEmpty, "a fresh window must not show Delete before a selection")

    toolbarHelpers.removeValue(forKey: ObjectIdentifier(second))
  }

  /// A hide that cannot reach the toolbar used to leave the cached flag saying
  /// "hidden" while the item was still installed. The next show then inserted a
  /// second copy, and NSToolbar raised NSInternalInconsistencyException, which
  /// Swift cannot catch — the whole app died.
  func testShouldNotDuplicateWhenAHideCouldNotReachTheToolbar() {
    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItemCount(), 1)

    let detached = window.toolbar
    window.toolbar = nil
    helper.setDeleteButtonVisible(false, label: nil, tooltip: nil)
    window.toolbar = detached

    XCTAssertEqual(deleteItemCount(), 1, "the detached toolbar still holds the item")

    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)

    XCTAssertEqual(deleteItemCount(), 1, "showing again must not insert a duplicate")
  }

  // MARK: - Idempotence

  func testShouldInsertTheItemWhenSelectionAppears() {
    XCTAssertEqual(deleteItemCount(), 0)
    helper.setDeleteButtonVisible(true, label: "Delete", tooltip: "Delete selected object")
    XCTAssertEqual(deleteItemCount(), 1)
  }

  func testShouldRemoveTheItemWhenSelectionClears() {
    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
    helper.setDeleteButtonVisible(false, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItemCount(), 0)
  }

  func testShouldKeepOneItemWhenShownRepeatedly() {
    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItemCount(), 1)
  }

  func testShouldStayEmptyWhenHiddenRepeatedly() {
    helper.setDeleteButtonVisible(false, label: nil, tooltip: nil)
    helper.setDeleteButtonVisible(false, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItemCount(), 0)
  }

  func testShouldSurviveAlternatingSelection() {
    for _ in 0..<10 {
      helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
      helper.setDeleteButtonVisible(false, label: nil, tooltip: nil)
    }
    XCTAssertEqual(deleteItemCount(), 0)
    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItemCount(), 1)
  }

  // MARK: - Texts and bounds

  func testShouldUpdateTextsOnAnAlreadyVisibleItem() {
    helper.setDeleteButtonVisible(true, label: "Удалить", tooltip: "Удалить объект")
    helper.setDeleteButtonVisible(true, label: "Delete", tooltip: "Delete selected object")

    XCTAssertEqual(deleteItem()?.label, "Delete")
    XCTAssertEqual(deleteItem()?.toolTip, "Delete selected object")
  }

  func testShouldInsertIntoAnEmptyToolbarWithoutLeavingBounds() {
    // A throwaway identifier: emptying the shared one would leak that
    // configuration into every later toolbar built with the same identifier.
    let isolated = NSToolbar(identifier: "PDFSignToolbarTest.\(UUID().uuidString)")
    isolated.delegate = helper
    window.toolbar = isolated
    while !isolated.items.isEmpty {
      isolated.removeItem(at: 0)
    }
    XCTAssertEqual(isolated.items.count, 0)

    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)

    XCTAssertEqual(deleteItemCount(), 1)
  }

  func testShouldPlaceDeleteBeforeShare() {
    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
    let identifiers = (window.toolbar?.items ?? []).map { $0.itemIdentifier.rawValue }

    guard let delete = identifiers.firstIndex(of: Self.deleteIdentifier),
          let share = identifiers.firstIndex(of: "ShareItem")
    else {
      return XCTFail("expected both items, got \(identifiers)")
    }
    XCTAssertLessThan(delete, share, "order was \(identifiers)")
  }

  // MARK: - Independence between windows

  /// NSToolbar shares its item set *live* between instances built with the same
  /// identifier: removing an item from one window's toolbar removed it from
  /// every other window's too. Each helper now uses its own identifier.
  func testShouldNotDisturbAnotherWindowsToolbar() {
    helper.setDeleteButtonVisible(true, label: nil, tooltip: nil)
    XCTAssertEqual(deleteItemCount(), 1)

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

    let secondItems = (second.toolbar?.items ?? [])
      .filter { $0.itemIdentifier.rawValue == Self.deleteIdentifier }
    XCTAssertTrue(secondItems.isEmpty, "a new window starts without Delete")

    XCTAssertEqual(
      deleteItemCount(),
      1,
      "opening another window must not strip the first window's Delete button"
    )

    toolbarHelpers.removeValue(forKey: ObjectIdentifier(second))
  }

  /// The Dart listener is edge-triggered, so a request that arrives before the
  /// toolbar exists is never repeated and has to be replayed on setup.
  func testShouldApplyAVisibilityRequestMadeBeforeSetup() {
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
    pendingHelper.setDeleteButtonVisible(true, label: "Delete", tooltip: "tip")

    pendingHelper.setupToolbar()

    let items = (pending.toolbar?.items ?? [])
      .filter { $0.itemIdentifier.rawValue == Self.deleteIdentifier }
    XCTAssertEqual(items.count, 1, "the pending request must be applied on setup")

    toolbarHelpers.removeValue(forKey: ObjectIdentifier(pending))
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
}
