import Cocoa

/// Places document windows along a diagonal so that several opened at once do
/// not land on top of one another.
///
/// `desktop_multi_window` gives every window it creates the same frame —
/// `NSRect(x: 0, y: 0, width: 800, height: 600)` — so opening five files from
/// Finder produced five windows in the bottom-left corner, four of them
/// hidden behind the fifth. Where the next window goes has to be decided once
/// for the whole application, and each window runs its own Dart isolate with
/// its own memory (ADR-0006), so the decision lives here rather than in Dart.
final class WindowCascade {
  /// The instance the application places its windows with.
  static let shared = WindowCascade()

  /// Top-left corner, in screen coordinates, reserved for the next window.
  private var nextTopLeft: NSPoint?

  /// Windows placed and still open, keyed so a window is never placed twice.
  ///
  /// The value is the close observer, which is also what ends the window's
  /// entry: when the last one goes, the diagonal starts over instead of
  /// carrying on from wherever a long-closed window left it.
  private var closeObservers: [ObjectIdentifier: NSObjectProtocol] = [:]

  deinit {
    for observer in closeObservers.values {
      NotificationCenter.default.removeObserver(observer)
    }
  }

  /// Number of placed windows still open. Exposed for tests.
  var placedWindowCount: Int { closeObservers.count }

  /// Positions [window] and reserves the next place on the diagonal.
  ///
  /// The first window of a run is centred; each one after it is stepped down
  /// and to the right by `cascadeTopLeft(from:)`, the same call Preview and
  /// TextEdit position their documents with. Measured on macOS 26: the step is
  /// 29 points, and AppKit returns the diagonal to the top of the screen when
  /// it reaches the bottom edge and to the left when it reaches the right one,
  /// so no window is pushed off the screen however many are opened.
  ///
  /// Placing a window that is already placed does nothing: it is positioned
  /// when it is created, and moved by the person using it thereafter.
  func place(_ window: NSWindow) {
    let key = ObjectIdentifier(window)
    guard closeObservers[key] == nil else { return }

    let topLeft: NSPoint
    if let reserved = nextTopLeft {
      topLeft = reserved
    } else {
      window.center()
      topLeft = NSPoint(x: window.frame.minX, y: window.frame.maxY)
    }
    nextTopLeft = window.cascadeTopLeft(from: topLeft)

    // No queue: a window closes on the main thread, and delivering the
    // notification through an operation queue instead would leave the count
    // briefly wrong — long enough for the next window to be placed against it.
    closeObservers[key] = NotificationCenter.default.addObserver(
      forName: NSWindow.willCloseNotification, object: window, queue: nil
    ) { [weak self] _ in
      self?.forget(key)
    }
  }

  /// Drops a closed window, and restarts the diagonal once none are left.
  private func forget(_ key: ObjectIdentifier) {
    guard let observer = closeObservers.removeValue(forKey: key) else { return }
    NotificationCenter.default.removeObserver(observer)
    if closeObservers.isEmpty {
      nextTopLeft = nil
    }
  }
}
