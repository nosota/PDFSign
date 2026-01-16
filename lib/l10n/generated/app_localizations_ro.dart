// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get openPdf => 'Deschide PDF';

  @override
  String get selectPdf => 'Selecteaza PDF';

  @override
  String get recentFiles => 'Fisiere recente';

  @override
  String get removeFromList => 'Elimina din lista';

  @override
  String get openedNow => 'Deschis acum';

  @override
  String openedMinutesAgo(int count) {
    return 'Deschis acum $count minute';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Deschis acum $count ore';
  }

  @override
  String get openedYesterday => 'Deschis ieri';

  @override
  String openedDaysAgo(int count) {
    return 'Deschis acum $count zile';
  }

  @override
  String get fileNotFound => 'Fisierul nu a fost gasit';

  @override
  String get fileAccessDenied => 'Acces refuzat';

  @override
  String get clearRecentFiles => 'Sterge fisierele recente';

  @override
  String get cancel => 'Anulare';

  @override
  String get confirm => 'Confirmare';

  @override
  String get error => 'Eroare';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fisier';

  @override
  String get menuOpen => 'Deschide...';

  @override
  String get menuOpenRecent => 'Deschide recente';

  @override
  String get menuNoRecentFiles => 'Nu exista fisiere recente';

  @override
  String get menuClearMenu => 'Sterge meniu';

  @override
  String get menuSave => 'Salvare';

  @override
  String get menuSaveAs => 'Salvare ca...';

  @override
  String get menuShare => 'Partajare...';

  @override
  String get menuCloseWindow => 'Inchide fereastra';

  @override
  String get saveChangesTitle => 'Salvati modificarile?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Doriti sa salvati modificarile din \"$fileName\" inainte de inchidere?';
  }

  @override
  String get saveButton => 'Salvare';

  @override
  String get discardButton => 'Renuntare';

  @override
  String get documentEdited => 'Editat';

  @override
  String get documentSaved => 'Salvat';

  @override
  String get menuSettings => 'Setari...';

  @override
  String get settingsTitle => 'Setari';

  @override
  String get settingsLanguage => 'Limba';

  @override
  String get settingsLanguageSystem => 'Implicit sistem';

  @override
  String get settingsUnits => 'Unitati';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Toli';

  @override
  String get settingsSearchLanguages => 'Căutare limbi...';

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
