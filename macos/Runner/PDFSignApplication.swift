import Cocoa

/// The application object, present for one reason: the About panel's version.
///
/// `NSApplication`'s standard panel prints
/// `Version <CFBundleShortVersionString> (<CFBundleVersion>)` whenever both
/// keys are set, so a release reads as "Version 1.2.0 (1)". The build number
/// is meaningful to the build system and to nobody reading an About box.
/// Passing an empty version option drops the parenthetical and leaves
/// "Version 1.2.0", while `CFBundleVersion` stays in place for macOS itself.
@objc(PDFSignApplication)
class PDFSignApplication: NSApplication {
  /// Shows the standard panel without the build number.
  ///
  /// The menu item created by Flutter's `PlatformProvidedMenuItemType.about`
  /// sends `orderFrontStandardAboutPanel:` up the responder chain, where
  /// `NSApplication` — this class — answers it. The options variant is a
  /// separate selector, so calling it here does not recurse.
  override func orderFrontStandardAboutPanel(_ sender: Any?) {
    orderFrontStandardAboutPanel(options: [.version: ""])
  }
}
