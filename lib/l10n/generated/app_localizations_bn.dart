// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get openPdf => 'PDF khulun';

  @override
  String get selectPdf => 'PDF bachun';

  @override
  String get recentFiles => 'Sompratik file';

  @override
  String get removeFromList => 'Taliqa theke mochun';

  @override
  String get openedNow => 'Ekhonoi khola hoyeche';

  @override
  String openedMinutesAgo(int count) {
    return '$count minute age khola hoyeche';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count ghonta age khola hoyeche';
  }

  @override
  String get openedYesterday => 'Gatokal khola hoyeche';

  @override
  String openedDaysAgo(int count) {
    return '$count din age khola hoyeche';
  }

  @override
  String get fileNotFound => 'File paoa jayni';

  @override
  String get fileAccessDenied => 'Probesh nishiddho';

  @override
  String get clearRecentFiles => 'Sompratik file mochun';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Nischit';

  @override
  String get error => 'Truti';

  @override
  String get ok => 'Thik ache';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Khulun...';

  @override
  String get menuOpenRecent => 'Sompratik khulun';

  @override
  String get menuNoRecentFiles => 'Kono sompratik file nei';

  @override
  String get menuClearMenu => 'Menu mochun';

  @override
  String get menuSave => 'Sanchhoy korun';

  @override
  String get menuSaveAs => 'Erup sanchhoy korun...';

  @override
  String get menuShare => 'Share korun...';

  @override
  String get menuCloseWindow => 'Janala bondho korun';

  @override
  String get saveChangesTitle => 'Paribartan sanchhoy korben?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Bondho korar age \"$fileName\" file-e paribartan sanchhoy korte chan?';
  }

  @override
  String get saveButton => 'Sanchhoy korun';

  @override
  String get discardButton => 'Bajay din';

  @override
  String get documentEdited => 'Sompadito';

  @override
  String get documentSaved => 'Sanchhoy hoyeche';

  @override
  String get menuSettings => 'Settingsh...';

  @override
  String get settingsTitle => 'Settingsh';

  @override
  String get settingsLanguage => 'Bhasha';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsUnits => 'Ekai';

  @override
  String get settingsUnitsCentimeters => 'Sentimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'ভাষা অনুসন্ধান...';
}
