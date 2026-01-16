// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get openPdf => 'PDF kholein';

  @override
  String get selectPdf => 'PDF chunein';

  @override
  String get recentFiles => 'Haal ki failein';

  @override
  String get removeFromList => 'Suchi se hataein';

  @override
  String get openedNow => 'Abhi khola gaya';

  @override
  String openedMinutesAgo(int count) {
    return '$count minute pehle khola gaya';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count ghante pehle khola gaya';
  }

  @override
  String get openedYesterday => 'Kal khola gaya';

  @override
  String openedDaysAgo(int count) {
    return '$count din pehle khola gaya';
  }

  @override
  String get fileNotFound => 'File nahi mili';

  @override
  String get fileAccessDenied => 'Pahunch asvikriti';

  @override
  String get clearRecentFiles => 'Haal ki failein saaf karein';

  @override
  String get cancel => 'Radd karein';

  @override
  String get confirm => 'Pushti karein';

  @override
  String get error => 'Truti';

  @override
  String get ok => 'Theek hai';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Kholein...';

  @override
  String get menuOpenRecent => 'Haal ke kholein';

  @override
  String get menuNoRecentFiles => 'Koi haal ki file nahi';

  @override
  String get menuClearMenu => 'Menu saaf karein';

  @override
  String get menuSave => 'Sahejein';

  @override
  String get menuSaveAs => 'Is roop mein sahejein...';

  @override
  String get menuShare => 'Sajha karein...';

  @override
  String get menuCloseWindow => 'Window band karein';

  @override
  String get saveChangesTitle => 'Parivartan sahejein?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Kya aap band karne se pehle \"$fileName\" mein parivartan sahejana chahte hain?';
  }

  @override
  String get saveButton => 'Sahejein';

  @override
  String get discardButton => 'Na sahejein';

  @override
  String get documentEdited => 'Sampadit';

  @override
  String get documentSaved => 'Saheja gaya';

  @override
  String get menuSettings => 'Settings...';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Bhasha';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsUnits => 'Ikaiyaan';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'भाषाएं खोजें...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Add Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get zoomFitWidth => 'Fit Width';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get selectZoomLevel => 'Select zoom level';

  @override
  String get goToPage => 'Go to Page';

  @override
  String get go => 'Go';

  @override
  String get savePdfAs => 'Save PDF As';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get saveFailed => 'Save failed';

  @override
  String savedTo(String path) {
    return 'Saved to: $path';
  }

  @override
  String get noOriginalPdfStored => 'No original PDF stored';
}
