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
  String get menuView => 'תצוגה';

  @override
  String goToPagePrompt(int total) {
    return 'הזינו מספר עמוד (1–$total):';
  }

  @override
  String get goToPageHint => 'מספר עמוד';

  @override
  String get goToPageInvalid => 'הזינו מספר תקין';

  @override
  String goToPageOutOfRange(int total) {
    return 'העמוד חייב להיות בין 1 ל־$total';
  }

  @override
  String get menuRotateLeft => 'סובב שמאלה';

  @override
  String get menuRotateRight => 'סובב ימינה';

  @override
  String get menuCut => 'גזור';

  @override
  String get menuCopy => 'העתק';

  @override
  String get menuPaste => 'הדבק';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'לא נוספו תמונות: $count — גדולות מ־$limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'לא נוספו תמונות: $count — גדולות מ־$limit פיקסלים';
  }

  @override
  String imagesNotAdded(int count) {
    return 'לא נוספו תמונות: $count';
  }

  @override
  String get clipboardUnavailable => 'הלוח אינו זמין';

  @override
  String get pasteImageFailed => 'לא ניתן היה להוסיף את התמונה';

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
  String get documentProtectedTitle => 'מסמך זה מוגן';

  @override
  String get documentProtectedBody => 'הזינו את הסיסמה כדי לפתוח אותו.';

  @override
  String get passwordFieldLabel => 'סיסמה';

  @override
  String get openDocumentButton => 'פתח';

  @override
  String get documentReadOnlyTitle => 'מסמך זה אינו מאפשר שינויים';

  @override
  String get documentReadOnlyBody =>
      'אפשר לקרוא ולהדפיס אותו, אך הבעלים לא התיר שינויים. הזינו את סיסמת הבעלים כדי לערוך אותו.';

  @override
  String get enterOwnerPassword => 'הזינו את סיסמת הבעלים';

  @override
  String get ownerPasswordFieldLabel => 'סיסמת הבעלים';

  @override
  String get menuPrint => 'הדפס…';

  @override
  String get menuPrintCurrentPage => 'הדפס את העמוד הנוכחי';

  @override
  String get printingIsTheOwnersTitle => 'רק הבעלים רשאי להדפיס מסמך זה';

  @override
  String get printingNotAllowed => 'מסמך זה אינו מאפשר הדפסה.';

  @override
  String get printingFailed => 'לא ניתן היה להדפיס את המסמך.';

  @override
  String get protectionIsTheOwnersTitle =>
      'רק הבעלים רשאי לשנות את ההגנה על מסמך זה';

  @override
  String get continueButton => 'המשך';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'מסמך מוגן מוצג מתוך הזיכרון, וגודלו של זה הוא $size. פתיחתו תשתמש בכמות דומה של זיכרון.';
  }

  @override
  String get shareProtectedNotice => 'העותק המשותף שומר על סיסמת המסמך.';

  @override
  String get unsupportedProtection =>
      'ההגנה על מסמך זה אינה נתמכת. PDFSign פותח מסמכים המוגנים בסיסמה, ולא מסמכים המוגנים בתעודה.';

  @override
  String get menuBringToFront => 'הבא לחזית';

  @override
  String get menuBringForward => 'הזז קדימה';

  @override
  String get menuSendBackward => 'הזז אחורה';

  @override
  String get menuSendToBack => 'שלח לאחור';

  @override
  String get zOrderGroupLabel => 'סידור';

  @override
  String get menuUndo => 'בטל';

  @override
  String get menuRedo => 'בצע שוב';

  @override
  String get dragToReorder => 'גררו כדי לשנות את הסדר';

  @override
  String get protectDocumentTitle => 'הגנה על המסמך';

  @override
  String get requirePasswordToOpen => 'דרוש סיסמה לפתיחת המסמך';

  @override
  String get verifyFieldLabel => 'אימות';

  @override
  String get permissionsHeading => 'הרשאות';

  @override
  String get permissionsNote => 'אפשר את השינויים הבאים ללא הזנת סיסמת הבעלים.';

  @override
  String get permissionPrinting => 'הדפסה';

  @override
  String get permissionCopying => 'העתקת טקסט או גרפיקה';

  @override
  String get permissionPageAssembly => 'הוספה, מחיקה וסיבוב של עמודים';

  @override
  String get permissionAnnotations => 'הוספת הערות וחתימות';

  @override
  String get permissionChangingContent => 'שינוי המסמך';

  @override
  String get permissionFormFilling => 'מילוי שדות טופס קיימים';

  @override
  String get changingContentIncludes =>
      'שינוי המסמך כולל הוספת הערות ומילוי טפסים — הם מותרים יחד עמו.';

  @override
  String get ownerPasswordHeading => 'סיסמת הבעלים';

  @override
  String get removeProtection => 'הסר הגנה';

  @override
  String get applyButton => 'החל';

  @override
  String get passwordsDoNotMatch => 'הסיסמאות אינן תואמות';

  @override
  String get passwordCannotBeEmpty => 'הזינו סיסמה';

  @override
  String get restrictionsNeedOwnerPassword =>
      'הגבלות מחייבות סיסמת בעלים. בלעדיה כל אחד יכול להסיר אותן.';

  @override
  String get signingNeedsChangingContent =>
      'בלי „שינוי המסמך“ לא ניתן יהיה לחתום כאן על הקובץ הזה שוב ללא סיסמת הבעלים.';

  @override
  String get menuProtectDocument => 'הגן על המסמך…';

  @override
  String get protectButtonLabel => 'הגן';

  @override
  String get protectButtonTooltip => 'הגדירו את הסיסמאות וההרשאות של מסמך זה';
}
