// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'PDFSign';

  @override
  String get welcomeTitle => 'Welcome to PDFSign';

  @override
  String get openPdf => 'Open PDF';

  @override
  String get recentFiles => 'Recent Files';

  @override
  String get noRecentFiles => 'No recent files';

  @override
  String get selectPdf => 'Select PDF';

  @override
  String get file => 'File';

  @override
  String get edit => 'Edit';

  @override
  String get view => 'View';

  @override
  String get help => 'Help';

  @override
  String get save => 'Save';

  @override
  String get saveAs => 'Save As...';

  @override
  String get close => 'Close';

  @override
  String get quit => 'Quit';

  @override
  String get undo => 'Undo';

  @override
  String get redo => 'Redo';

  @override
  String get delete => 'Delete';

  @override
  String get deleteSelected => 'Delete Selected';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get actualSize => 'Actual Size';

  @override
  String get fitToScreen => 'Fit to Screen';

  @override
  String get fullScreen => 'Full Screen';

  @override
  String get signatures => 'Signatures';

  @override
  String get stamps => 'Stamps';

  @override
  String get addSignature => 'Add Signature';

  @override
  String get addStamp => 'Add Stamp';

  @override
  String get add => 'Add';

  @override
  String get editLabel => 'Edit Label';

  @override
  String get deleteItem => 'Delete Item';

  @override
  String get rotate5Left => 'Rotate 5° Left';

  @override
  String get rotate5Right => 'Rotate 5° Right';

  @override
  String get rotate90 => 'Rotate 90°';

  @override
  String get scaleUp => 'Scale +5%';

  @override
  String get scaleDown => 'Scale -5%';

  @override
  String get bringToFront => 'Bring to Front';

  @override
  String get bringForward => 'Bring Forward';

  @override
  String get sendBackward => 'Send Backward';

  @override
  String get sendToBack => 'Send to Back';

  @override
  String pageIndicator(int current, int total) {
    return 'Page $current of $total';
  }

  @override
  String get passwordRequired => 'Password Required';

  @override
  String get enterPassword => 'Enter password to open this PDF';

  @override
  String get password => 'Password';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get retry => 'Retry';

  @override
  String attemptsRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attempts remaining',
      one: '1 attempt remaining',
    );
    return '$_temp0';
  }

  @override
  String get errorFileNotFound => 'The selected file could not be found.';

  @override
  String get errorAccessDenied =>
      'Permission denied. Please check file permissions.';

  @override
  String get errorInvalidFormat => 'This file is not a valid PDF document.';

  @override
  String get errorFileTooLarge => 'Image size exceeds 100MB limit.';

  @override
  String get errorResolutionTooHigh =>
      'Image resolution exceeds 4096x4096 pixels.';

  @override
  String get errorCorruptedPdf => 'This PDF appears to be corrupted.';

  @override
  String get errorIncorrectPassword => 'Incorrect password.';

  @override
  String get errorWriteProtected =>
      'This PDF is protected and cannot be modified.';

  @override
  String get errorSaveFailed => 'Failed to save PDF.';

  @override
  String get errorInsufficientSpace => 'Not enough disk space to save file.';

  @override
  String get errorReadOnlyLocation => 'Cannot save to a read-only location.';

  @override
  String get errorOutOfMemory => 'Insufficient memory. Try closing other apps.';

  @override
  String get errorDatabaseError => 'Failed to access signature library.';

  @override
  String get errorUnknown => 'An unknown error occurred.';

  @override
  String get confirmDelete => 'Are you sure you want to delete this item?';

  @override
  String get confirmDeleteTitle => 'Confirm Delete';

  @override
  String get unsavedChanges =>
      'You have unsaved changes. Do you want to save before closing?';

  @override
  String get unsavedChangesTitle => 'Unsaved Changes';

  @override
  String get dontSave => 'Don\'t Save';

  @override
  String get loading => 'Loading...';

  @override
  String get saving => 'Saving...';

  @override
  String get processing => 'Processing...';

  @override
  String openedAgo(String time) {
    return 'Opened $time ago';
  }

  @override
  String get aboutApp => 'About PDFSign';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get poweredBy => 'Powered by Syncfusion Community License';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get signatureAdded => 'Signature added to library';

  @override
  String get stampAdded => 'Stamp added to library';

  @override
  String get itemDeleted => 'Item deleted from library';

  @override
  String get pdfSaved => 'PDF saved successfully';

  @override
  String get copyToClipboard => 'Copy to Clipboard';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get clipboardEmpty => 'Clipboard is empty';

  @override
  String get unsupportedImageFormat => 'Unsupported image format';

  @override
  String get pasteImageTitle => 'Paste Image';

  @override
  String get pasteImagePreview => 'Preview';

  @override
  String get pasteImageName => 'Name';

  @override
  String get pasteImageNameHint => 'Enter name for this image';

  @override
  String get addToSignatures => 'Add to Signatures';

  @override
  String get addToStamps => 'Add to Stamps';

  @override
  String get dontAddToLibrary => 'Don\'t add to library';

  @override
  String get dontAskAgain => 'Don\'t ask again';

  @override
  String get paste => 'Paste';

  @override
  String get clipboardBehavior => 'Clipboard Behavior';

  @override
  String get resetPastePreference => 'Reset \"Don\'t ask again\" preference';

  @override
  String get defaultPasteTarget => 'Default paste target';
}
