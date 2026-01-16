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
  String get menuShare => 'שתף...';

  @override
  String get menuCloseWindow => 'סגור חלון';

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
}
