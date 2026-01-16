// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get openPdf => 'Åbn PDF';

  @override
  String get selectPdf => 'Vælg PDF';

  @override
  String get recentFiles => 'Seneste filer';

  @override
  String get removeFromList => 'Fjern fra listen';

  @override
  String get openedNow => 'Lige åbnet';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutter',
      one: 'minut',
    );
    return 'Åbnet for $count $_temp0 siden';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'timer',
      one: 'time',
    );
    return 'Åbnet for $count $_temp0 siden';
  }

  @override
  String get openedYesterday => 'Åbnet i går';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dage',
      one: 'dag',
    );
    return 'Åbnet for $count $_temp0 siden';
  }

  @override
  String get fileNotFound => 'Filen blev ikke fundet';

  @override
  String get fileAccessDenied => 'Adgang nægtet';

  @override
  String get clearRecentFiles => 'Ryd seneste filer';

  @override
  String get cancel => 'Annuller';

  @override
  String get confirm => 'Bekræft';

  @override
  String get error => 'Fejl';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkiv';

  @override
  String get menuOpen => 'Åbn...';

  @override
  String get menuOpenRecent => 'Åbn seneste';

  @override
  String get menuNoRecentFiles => 'Ingen seneste filer';

  @override
  String get menuClearMenu => 'Ryd menu';

  @override
  String get menuSave => 'Gem';

  @override
  String get menuSaveAs => 'Gem som...';

  @override
  String get menuShare => 'Del...';

  @override
  String get menuCloseWindow => 'Luk vindue';

  @override
  String get saveChangesTitle => 'Gem ændringer?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vil du gemme ændringerne i \"$fileName\" før lukning?';
  }

  @override
  String get saveButton => 'Gem';

  @override
  String get discardButton => 'Gem ikke';

  @override
  String get documentEdited => 'Redigeret';

  @override
  String get documentSaved => 'Gemt';

  @override
  String get menuSettings => 'Indstillinger...';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get settingsLanguage => 'Sprog';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Enheder';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Tommer';

  @override
  String get settingsSearchLanguages => 'Søg sprog...';
}
