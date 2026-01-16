// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get openPdf => 'Åpne PDF';

  @override
  String get selectPdf => 'Velg PDF';

  @override
  String get recentFiles => 'Nylige filer';

  @override
  String get removeFromList => 'Fjern fra listen';

  @override
  String get openedNow => 'Nettopp åpnet';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutter',
      one: 'minutt',
    );
    return 'Åpnet for $count $_temp0 siden';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'timer',
      one: 'time',
    );
    return 'Åpnet for $count $_temp0 siden';
  }

  @override
  String get openedYesterday => 'Åpnet i går';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dager',
      one: 'dag',
    );
    return 'Åpnet for $count $_temp0 siden';
  }

  @override
  String get fileNotFound => 'Filen ble ikke funnet';

  @override
  String get fileAccessDenied => 'Tilgang nektet';

  @override
  String get clearRecentFiles => 'Tøm nylige filer';

  @override
  String get cancel => 'Avbryt';

  @override
  String get confirm => 'Bekreft';

  @override
  String get error => 'Feil';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkiv';

  @override
  String get menuOpen => 'Åpne...';

  @override
  String get menuOpenRecent => 'Åpne nylige';

  @override
  String get menuNoRecentFiles => 'Ingen nylige filer';

  @override
  String get menuClearMenu => 'Tøm meny';

  @override
  String get menuSave => 'Lagre';

  @override
  String get menuSaveAs => 'Lagre som...';

  @override
  String get menuShare => 'Del...';

  @override
  String get menuCloseWindow => 'Lukk vindu';

  @override
  String get saveChangesTitle => 'Lagre endringer?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vil du lagre endringene i \"$fileName\" før lukking?';
  }

  @override
  String get saveButton => 'Lagre';

  @override
  String get discardButton => 'Ikke lagre';

  @override
  String get documentEdited => 'Redigert';

  @override
  String get documentSaved => 'Lagret';

  @override
  String get menuSettings => 'Innstillinger...';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Enheter';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Tommer';

  @override
  String get settingsSearchLanguages => 'Søk etter språk...';

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
