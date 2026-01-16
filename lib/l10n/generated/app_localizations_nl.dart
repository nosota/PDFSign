// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get openPdf => 'PDF openen';

  @override
  String get selectPdf => 'PDF selecteren';

  @override
  String get recentFiles => 'Recente bestanden';

  @override
  String get removeFromList => 'Verwijderen uit lijst';

  @override
  String get openedNow => 'Zojuist geopend';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuten',
      one: 'minuut',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'uur',
      one: 'uur',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String get openedYesterday => 'Gisteren geopend';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dagen',
      one: 'dag',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String get fileNotFound => 'Bestand niet gevonden';

  @override
  String get fileAccessDenied => 'Toegang geweigerd';

  @override
  String get clearRecentFiles => 'Recente bestanden wissen';

  @override
  String get cancel => 'Annuleer';

  @override
  String get confirm => 'Bevestig';

  @override
  String get error => 'Fout';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Archief';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open recente';

  @override
  String get menuNoRecentFiles => 'Geen recente bestanden';

  @override
  String get menuClearMenu => 'Wis menu';

  @override
  String get menuSave => 'Bewaar';

  @override
  String get menuSaveAs => 'Bewaar als...';

  @override
  String get menuShare => 'Deel...';

  @override
  String get menuCloseWindow => 'Sluit venster';

  @override
  String get saveChangesTitle => 'Wijzigingen bewaren?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Wilt u de wijzigingen in \"$fileName\" bewaren voordat u sluit?';
  }

  @override
  String get saveButton => 'Bewaar';

  @override
  String get discardButton => 'Niet bewaren';

  @override
  String get documentEdited => 'Bewerkt';

  @override
  String get documentSaved => 'Bewaard';

  @override
  String get menuSettings => 'Instellingen...';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get settingsLanguage => 'Taal';

  @override
  String get settingsLanguageSystem => 'Systeemstandaard';

  @override
  String get settingsUnits => 'Eenheden';

  @override
  String get settingsUnitsCentimeters => 'Centimeters';

  @override
  String get settingsUnitsInches => 'Inches';

  @override
  String get settingsSearchLanguages => 'Talen zoeken...';

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
