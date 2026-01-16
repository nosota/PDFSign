// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get openPdf => 'Odpri PDF';

  @override
  String get selectPdf => 'Izberi PDF';

  @override
  String get recentFiles => 'Nedavne datoteke';

  @override
  String get removeFromList => 'Odstrani s seznama';

  @override
  String get openedNow => 'Pravkar odprto';

  @override
  String openedMinutesAgo(int count) {
    return 'Odprto pred $count minutami';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Odprto pred $count urami';
  }

  @override
  String get openedYesterday => 'Odprto vceraj';

  @override
  String openedDaysAgo(int count) {
    return 'Odprto pred $count dnevi';
  }

  @override
  String get fileNotFound => 'Datoteka ni najdena';

  @override
  String get fileAccessDenied => 'Dostop zavrnjen';

  @override
  String get clearRecentFiles => 'Pocisti nedavne datoteke';

  @override
  String get cancel => 'Preklic';

  @override
  String get confirm => 'Potrdi';

  @override
  String get error => 'Napaka';

  @override
  String get ok => 'V redu';

  @override
  String get menuFile => 'Datoteka';

  @override
  String get menuOpen => 'Odpri...';

  @override
  String get menuOpenRecent => 'Odpri nedavne';

  @override
  String get menuNoRecentFiles => 'Ni nedavnih datotek';

  @override
  String get menuClearMenu => 'Pocisti meni';

  @override
  String get menuSave => 'Shrani';

  @override
  String get menuSaveAs => 'Shrani kot...';

  @override
  String get menuShare => 'Deli...';

  @override
  String get menuCloseWindow => 'Zapri okno';

  @override
  String get saveChangesTitle => 'Shrani spremembe?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ali zelite shraniti spremembe v \"$fileName\" pred zaprtjem?';
  }

  @override
  String get saveButton => 'Shrani';

  @override
  String get discardButton => 'Ne shrani';

  @override
  String get documentEdited => 'Urejeno';

  @override
  String get documentSaved => 'Shranjeno';

  @override
  String get menuSettings => 'Nastavitve...';

  @override
  String get settingsTitle => 'Nastavitve';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Sistemska privzeta';

  @override
  String get settingsUnits => 'Enote';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Palci';

  @override
  String get settingsSearchLanguages => 'Iskanje jezikov...';
}
