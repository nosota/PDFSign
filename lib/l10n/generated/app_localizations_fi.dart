// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get openPdf => 'Avaa PDF';

  @override
  String get selectPdf => 'Valitse PDF';

  @override
  String get recentFiles => 'Viimeisimmät tiedostot';

  @override
  String get removeFromList => 'Poista luettelosta';

  @override
  String get openedNow => 'Juuri avattu';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuuttia',
      one: 'minuutti',
    );
    return 'Avattu $count $_temp0 sitten';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tuntia',
      one: 'tunti',
    );
    return 'Avattu $count $_temp0 sitten';
  }

  @override
  String get openedYesterday => 'Avattu eilen';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'päivää',
      one: 'päivä',
    );
    return 'Avattu $count $_temp0 sitten';
  }

  @override
  String get fileNotFound => 'Tiedostoa ei löytynyt';

  @override
  String get fileAccessDenied => 'Pääsy estetty';

  @override
  String get clearRecentFiles => 'Tyhjennä viimeisimmät tiedostot';

  @override
  String get cancel => 'Kumoa';

  @override
  String get confirm => 'Vahvista';

  @override
  String get error => 'Virhe';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkisto';

  @override
  String get menuOpen => 'Avaa...';

  @override
  String get menuOpenRecent => 'Avaa viimeisimmät';

  @override
  String get menuNoRecentFiles => 'Ei viimeisimpiä tiedostoja';

  @override
  String get menuClearMenu => 'Tyhjennä valikko';

  @override
  String get menuSave => 'Tallenna';

  @override
  String get menuSaveAs => 'Tallenna nimellä...';

  @override
  String get menuShare => 'Jaa...';

  @override
  String get menuCloseWindow => 'Sulje ikkuna';

  @override
  String get saveChangesTitle => 'Tallenna muutokset?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Haluatko tallentaa muutokset tiedostoon \"$fileName\" ennen sulkemista?';
  }

  @override
  String get saveButton => 'Tallenna';

  @override
  String get discardButton => 'Älä tallenna';

  @override
  String get documentEdited => 'Muokattu';

  @override
  String get documentSaved => 'Tallennettu';

  @override
  String get menuSettings => 'Asetukset...';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get settingsLanguage => 'Kieli';

  @override
  String get settingsLanguageSystem => 'Järjestelmän oletus';

  @override
  String get settingsUnits => 'Yksiköt';

  @override
  String get settingsUnitsCentimeters => 'Senttimetrit';

  @override
  String get settingsUnitsInches => 'Tuumat';

  @override
  String get settingsSearchLanguages => 'Etsi kieliä...';

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
