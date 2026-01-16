// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get openPdf => 'Opna PDF';

  @override
  String get selectPdf => 'Velja PDF';

  @override
  String get recentFiles => 'Nyjar skrar';

  @override
  String get removeFromList => 'Fjarlægja af lista';

  @override
  String get openedNow => 'Nyopnað';

  @override
  String openedMinutesAgo(int count) {
    return 'Opnað fyrir $count min';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Opnað fyrir $count klst';
  }

  @override
  String get openedYesterday => 'Opnað i gær';

  @override
  String openedDaysAgo(int count) {
    return 'Opnað fyrir $count dogum';
  }

  @override
  String get fileNotFound => 'Skra fannst ekki';

  @override
  String get fileAccessDenied => 'Adgangur synjadur';

  @override
  String get clearRecentFiles => 'Hreinsa nyjar skrar';

  @override
  String get cancel => 'Hætta vid';

  @override
  String get confirm => 'Stadsfesta';

  @override
  String get error => 'Villa';

  @override
  String get ok => 'I lagi';

  @override
  String get menuFile => 'Skra';

  @override
  String get menuOpen => 'Opna...';

  @override
  String get menuOpenRecent => 'Opna nyjar';

  @override
  String get menuNoRecentFiles => 'Engar nyjar skrar';

  @override
  String get menuClearMenu => 'Hreinsa valmynd';

  @override
  String get menuSave => 'Vista';

  @override
  String get menuSaveAs => 'Vista sem...';

  @override
  String get menuShare => 'Deila...';

  @override
  String get menuCloseWindow => 'Loka glugga';

  @override
  String get saveChangesTitle => 'Vista breytingar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Viltu vista breytingar a \"$fileName\" adur en lokad er?';
  }

  @override
  String get saveButton => 'Vista';

  @override
  String get discardButton => 'Fleygja';

  @override
  String get documentEdited => 'Breytt';

  @override
  String get documentSaved => 'Vistað';

  @override
  String get menuSettings => 'Stillingar...';

  @override
  String get settingsTitle => 'Stillingar';

  @override
  String get settingsLanguage => 'Tungumál';

  @override
  String get settingsLanguageSystem => 'Sjálfgildi kerfis';

  @override
  String get settingsUnits => 'Einingar';

  @override
  String get settingsUnitsCentimeters => 'Sentimetrar';

  @override
  String get settingsUnitsInches => 'Tommur';

  @override
  String get settingsSearchLanguages => 'Leita að tungumálum...';

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
