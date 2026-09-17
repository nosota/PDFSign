// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get openPdf => 'פתח PDF';

  @override
  String get selectPdf => 'בחר PDF';

  @override
  String get recentFiles => 'קבצים אחרונים';

  @override
  String get removeFromList => 'הסר מהרשימה';

  @override
  String get openedNow => 'נפתח זה עתה';

  @override
  String openedMinutesAgo(int count) {
    return 'נפתח לפני $count דקות';
  }

  @override
  String openedHoursAgo(int count) {
    return 'נפתח לפני $count שעות';
  }

  @override
  String get openedYesterday => 'נפתח אתמול';

  @override
  String openedDaysAgo(int count) {
    return 'נפתח לפני $count ימים';
  }

  @override
  String get fileNotFound => 'הקובץ לא נמצא';

  @override
  String get fileAccessDenied => 'הגישה נדחתה';

  @override
  String get clearRecentFiles => 'נקה קבצים אחרונים';

  @override
  String get cancel => 'ביטול';

  @override
  String get confirm => 'אישור';

  @override
  String get error => 'שגיאה';

  @override
  String get ok => 'אישור';

  @override
  String get menuFile => 'קובץ';

  @override
  String get menuOpen => 'פתח...';

  @override
  String get menuOpenRecent => 'פתח אחרונים';

  @override
  String get menuNoRecentFiles => 'אין קבצים אחרונים';

  @override
  String get menuClearMenu => 'נקה תפריט';

  @override
  String get menuSave => 'שמור';

  @override
  String get menuSaveAs => 'שמור בשם...';

  @override
  String get menuSaveAll => 'שמור הכל';

  @override
  String get menuShare => 'שתף...';

  @override
  String get menuCloseWindow => 'סגור חלון';

  @override
  String get menuCloseAll => 'סגור הכל';

  @override
  String get menuEdit => 'עריכה';

  @override
  String get menuDelete => 'מחק';

  @override
  String get menuView => 'View';

  @override
  String goToPagePrompt(int total) {
    return 'Enter page number (1-$total):';
  }

  @override
  String get goToPageHint => 'Page number';

  @override
  String get goToPageInvalid => 'Please enter a valid number';

  @override
  String goToPageOutOfRange(int total) {
    return 'Page must be between 1 and $total';
  }

  @override
  String get menuRotateLeft => 'Rotate Left';

  @override
  String get menuRotateRight => 'Rotate Right';

  @override
  String get menuCut => 'Cut';

  @override
  String get menuCopy => 'Copy';

  @override
  String get menuPaste => 'Paste';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Not added: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'The clipboard is unavailable';

  @override
  String get pasteImageFailed => 'That image could not be added';

  @override
  String get menuQuit => 'צא מ-PDFSign';

  @override
  String get closeAllDialogTitle => 'לשמור שינויים?';

  @override
  String closeAllDialogMessage(int count) {
    return 'האם ברצונך לשמור את השינויים ב-$count מסמכים לפני הסגירה?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'האם ברצונך לשמור את השינויים במסמך אחד לפני הסגירה?';

  @override
  String get closeAllDialogSaveAll => 'שמור הכל';

  @override
  String get closeAllDialogDontSave => 'אל תשמור';

  @override
  String get closeAllDialogCancel => 'ביטול';

  @override
  String get saveFailedDialogTitle => 'השמירה נכשלה';

  @override
  String saveFailedDialogMessage(int count) {
    return 'השמירה של $count מסמכים נכשלה. לסגור בכל זאת?';
  }

  @override
  String get saveFailedDialogClose => 'סגור בכל זאת';

  @override
  String get saveChangesTitle => 'לשמור שינויים?';

  @override
  String saveChangesMessage(String fileName) {
    return 'האם ברצונך לשמור את השינויים ב-\"$fileName\" לפני הסגירה?';
  }

  @override
  String get saveButton => 'שמור';

  @override
  String get discardButton => 'אל תשמור';

  @override
  String get documentEdited => 'נערך';

  @override
  String get documentSaved => 'נשמר';

  @override
  String get menuSettings => 'הגדרות...';

  @override
  String get menuWindow => 'חלון';

  @override
  String get menuMinimize => 'מזער';

  @override
  String get menuZoom => 'הגדל/הקטן';

  @override
  String get menuBringAllToFront => 'הבא הכל לחזית';

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get settingsLanguage => 'שפה';

  @override
  String get settingsLanguageSystem => 'ברירת מחדל מערכת';

  @override
  String get settingsUnits => 'יחידות';

  @override
  String get settingsUnitsCentimeters => 'סנטימטרים';

  @override
  String get settingsUnitsInches => 'אינצים';

  @override
  String get settingsSearchLanguages => 'חיפוש שפות...';

  @override
  String get settingsGeneral => 'כללי';

  @override
  String get addImage => 'הוסף תמונה';

  @override
  String get selectImages => 'בחר תמונות';

  @override
  String get zoomFitWidth => 'התאם לרוחב';

  @override
  String get zoomIn => 'הגדל';

  @override
  String get zoomOut => 'הקטן';

  @override
  String get selectZoomLevel => 'בחר רמת זום';

  @override
  String get goToPage => 'עבור לעמוד';

  @override
  String get go => 'עבור';

  @override
  String get savePdfAs => 'שמור PDF בשם';

  @override
  String get incorrectPassword => 'סיסמה שגויה';

  @override
  String get saveFailed => 'השמירה נכשלה';

  @override
  String savedTo(String path) {
    return 'נשמר ב: $path';
  }

  @override
  String get noOriginalPdfStored => 'לא נשמר PDF מקורי';

  @override
  String get waitingForFolderPermission => 'ממתין להרשאת גישה לתיקייה...';

  @override
  String get deleteButtonLabel => 'מחק';

  @override
  String get deleteButtonTooltip => 'מחק אובייקט נבחר';

  @override
  String get documentProtectedTitle => 'This document is protected';

  @override
  String get documentProtectedBody => 'Enter its password to open it.';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get openDocumentButton => 'Open';

  @override
  String get documentReadOnlyTitle => 'This document does not allow changes';

  @override
  String get documentReadOnlyBody =>
      'It can be read and printed, but its owner has not allowed it to be changed. Enter the owner password to edit it.';

  @override
  String get enterOwnerPassword => 'Enter owner password';

  @override
  String get ownerPasswordFieldLabel => 'Owner password';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'A protected document has to be held in memory to be shown, and this one is $size. Opening it will use about that much.';
  }

  @override
  String get shareProtectedNotice =>
      'The shared copy keeps the document\'s password.';

  @override
  String get unsupportedProtection =>
      'This document\'s protection is not supported. PDFSign opens password-protected documents, not those protected by a certificate.';

  @override
  String get menuBringToFront => 'Bring to Front';

  @override
  String get menuBringForward => 'Bring Forward';

  @override
  String get menuSendBackward => 'Send Backward';

  @override
  String get menuSendToBack => 'Send to Back';

  @override
  String get zOrderGroupLabel => 'Arrange';

  @override
  String get menuUndo => 'Undo';

  @override
  String get menuRedo => 'Redo';

  @override
  String get dragToReorder => 'Drag to reorder';

  @override
  String get protectDocumentTitle => 'Protect Document';

  @override
  String get requirePasswordToOpen => 'Require Password To Open Document';

  @override
  String get verifyFieldLabel => 'Verify';

  @override
  String get permissionsHeading => 'Permissions';

  @override
  String get permissionsNote =>
      'Allow the following changes to be made without entering the owner password.';

  @override
  String get permissionPrinting => 'Printing';

  @override
  String get permissionCopying => 'Copying Text or Graphics';

  @override
  String get permissionPageAssembly => 'Inserting, Deleting, or Rotating Pages';

  @override
  String get permissionAnnotations => 'Adding Annotations or Signatures';

  @override
  String get permissionChangingContent => 'Changing the Document';

  @override
  String get permissionFormFilling => 'Filling Existing Form Fields';

  @override
  String get changingContentIncludes =>
      'Changing the document includes annotating and filling in forms, so those are granted with it.';

  @override
  String get ownerPasswordHeading => 'Owner Password';

  @override
  String get removeProtection => 'Remove Protection';

  @override
  String get applyButton => 'Apply';

  @override
  String get passwordsDoNotMatch => 'The passwords do not match';

  @override
  String get passwordCannotBeEmpty => 'Enter a password';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Restrictions need an owner password. Without one, anyone can lift them.';

  @override
  String get signingNeedsChangingContent =>
      'Without “Changing the Document”, this file cannot be signed here again unless the owner password is given.';

  @override
  String get menuProtectDocument => 'Protect Document…';

  @override
  String get protectButtonLabel => 'Protect';

  @override
  String get protectButtonTooltip =>
      'Set this document\'s passwords and permissions';
}
