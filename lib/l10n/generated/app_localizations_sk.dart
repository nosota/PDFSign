// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get openPdf => 'Otvoriť PDF';

  @override
  String get selectPdf => 'Vybrať PDF';

  @override
  String get recentFiles => 'Nedávne súbory';

  @override
  String get removeFromList => 'Odstrániť zo zoznamu';

  @override
  String get openedNow => 'Práve otvorené';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minútami',
      few: 'minútami',
      one: 'minútou',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hodinami',
      few: 'hodinami',
      one: 'hodinou',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String get openedYesterday => 'Otvorené včera';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dňami',
      few: 'dňami',
      one: 'dňom',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String get fileNotFound => 'Súbor sa nenašiel';

  @override
  String get fileAccessDenied => 'Prístup zamietnutý';

  @override
  String get clearRecentFiles => 'Vymazať nedávne súbory';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get confirm => 'Potvrdiť';

  @override
  String get error => 'Chyba';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Súbor';

  @override
  String get menuOpen => 'Otvoriť...';

  @override
  String get menuOpenRecent => 'Otvoriť nedávne';

  @override
  String get menuNoRecentFiles => 'Žiadne nedávne súbory';

  @override
  String get menuClearMenu => 'Vymazať ponuku';

  @override
  String get menuSave => 'Uložiť';

  @override
  String get menuSaveAs => 'Uložiť ako...';

  @override
  String get menuShare => 'Zdieľať...';

  @override
  String get menuCloseWindow => 'Zavrieť okno';

  @override
  String get saveChangesTitle => 'Uložiť zmeny?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Chcete uložiť zmeny v \"$fileName\" pred zatvorením?';
  }

  @override
  String get saveButton => 'Uložiť';

  @override
  String get discardButton => 'Neuložiť';

  @override
  String get documentEdited => 'Upravené';

  @override
  String get documentSaved => 'Uložené';

  @override
  String get menuSettings => 'Nastavenia...';

  @override
  String get settingsTitle => 'Nastavenia';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLanguageSystem => 'Predvolený systémový';

  @override
  String get settingsUnits => 'Jednotky';

  @override
  String get settingsUnitsCentimeters => 'Centimetre';

  @override
  String get settingsUnitsInches => 'Palce';

  @override
  String get settingsSearchLanguages => 'Hľadať jazyky...';

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
