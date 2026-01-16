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
}
