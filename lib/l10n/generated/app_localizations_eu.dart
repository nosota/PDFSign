// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class AppLocalizationsEu extends AppLocalizations {
  AppLocalizationsEu([String locale = 'eu']) : super(locale);

  @override
  String get openPdf => 'Ireki PDF';

  @override
  String get selectPdf => 'Hautatu PDF';

  @override
  String get recentFiles => 'Azken fitxategiak';

  @override
  String get removeFromList => 'Kendu zerrendatik';

  @override
  String get openedNow => 'Orain irekita';

  @override
  String openedMinutesAgo(int count) {
    return 'Duela $count minutu irekita';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Duela $count ordu irekita';
  }

  @override
  String get openedYesterday => 'Atzo irekita';

  @override
  String openedDaysAgo(int count) {
    return 'Duela $count egun irekita';
  }

  @override
  String get fileNotFound => 'Ez da fitxategia aurkitu';

  @override
  String get fileAccessDenied => 'Sarbidea ukatua';

  @override
  String get clearRecentFiles => 'Garbitu azken fitxategiak';

  @override
  String get cancel => 'Utzi';

  @override
  String get confirm => 'Berretsi';

  @override
  String get error => 'Errorea';

  @override
  String get ok => 'Ados';

  @override
  String get menuFile => 'Fitxategia';

  @override
  String get menuOpen => 'Ireki...';

  @override
  String get menuOpenRecent => 'Ireki azkenak';

  @override
  String get menuNoRecentFiles => 'Ez dago azken fitxategirik';

  @override
  String get menuClearMenu => 'Garbitu menua';

  @override
  String get menuSave => 'Gorde';

  @override
  String get menuSaveAs => 'Gorde honela...';

  @override
  String get menuShare => 'Partekatu...';

  @override
  String get menuCloseWindow => 'Itxi leihoa';

  @override
  String get saveChangesTitle => 'Aldaketak gorde?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Itxi baino lehen \"$fileName\" fitxategiko aldaketak gorde nahi dituzu?';
  }

  @override
  String get saveButton => 'Gorde';

  @override
  String get discardButton => 'Ez gorde';

  @override
  String get documentEdited => 'Editatua';

  @override
  String get documentSaved => 'Gordeta';

  @override
  String get menuSettings => 'Ezarpenak...';

  @override
  String get settingsTitle => 'Ezarpenak';

  @override
  String get settingsLanguage => 'Hizkuntza';

  @override
  String get settingsLanguageSystem => 'Sistemaren lehenetsia';

  @override
  String get settingsUnits => 'Unitateak';

  @override
  String get settingsUnitsCentimeters => 'Zentimetroak';

  @override
  String get settingsUnitsInches => 'Hazbeteak';

  @override
  String get settingsSearchLanguages => 'Bilatu hizkuntzak...';

  @override
  String get settingsGeneral => 'Orokorra';

  @override
  String get addImage => 'Gehitu irudia';

  @override
  String get selectImages => 'Hautatu irudiak';

  @override
  String get zoomFitWidth => 'Egokitu zabaleran';

  @override
  String get zoomIn => 'Handitu';

  @override
  String get zoomOut => 'Txikitu';

  @override
  String get selectZoomLevel => 'Hautatu zoom maila';

  @override
  String get goToPage => 'Joan orrialdera';

  @override
  String get go => 'Joan';

  @override
  String get savePdfAs => 'Gorde PDF honela';

  @override
  String get incorrectPassword => 'Pasahitz okerra';

  @override
  String get saveFailed => 'Gordetzeak huts egin du';

  @override
  String savedTo(String path) {
    return 'Gordeta: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ez dago jatorrizko PDF-ik gordetuta';
}
