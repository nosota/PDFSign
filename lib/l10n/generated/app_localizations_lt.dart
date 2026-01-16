// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get openPdf => 'Atidaryti PDF';

  @override
  String get selectPdf => 'Pasirinkti PDF';

  @override
  String get recentFiles => 'Naujausi failai';

  @override
  String get removeFromList => 'Pasalinti is saraso';

  @override
  String get openedNow => 'Ka tik atidarytas';

  @override
  String openedMinutesAgo(int count) {
    return 'Atidarytas pries $count min.';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Atidarytas pries $count val.';
  }

  @override
  String get openedYesterday => 'Atidarytas vakar';

  @override
  String openedDaysAgo(int count) {
    return 'Atidarytas pries $count d.';
  }

  @override
  String get fileNotFound => 'Failas nerastas';

  @override
  String get fileAccessDenied => 'Prieiga uzdrausta';

  @override
  String get clearRecentFiles => 'Isvalyti naujausius';

  @override
  String get cancel => 'Atsaukti';

  @override
  String get confirm => 'Patvirtinti';

  @override
  String get error => 'Klaida';

  @override
  String get ok => 'Gerai';

  @override
  String get menuFile => 'Failas';

  @override
  String get menuOpen => 'Atidaryti...';

  @override
  String get menuOpenRecent => 'Atidaryti naujausius';

  @override
  String get menuNoRecentFiles => 'Nera naujausiu failu';

  @override
  String get menuClearMenu => 'Isvalyti meniu';

  @override
  String get menuSave => 'Issaugoti';

  @override
  String get menuSaveAs => 'Issaugoti kaip...';

  @override
  String get menuShare => 'Bendrinti...';

  @override
  String get menuCloseWindow => 'Uzdaryti langa';

  @override
  String get saveChangesTitle => 'Issaugoti pakeitimus?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ar norite issaugoti pakeitimus faile \"$fileName\" pries uzdarant?';
  }

  @override
  String get saveButton => 'Issaugoti';

  @override
  String get discardButton => 'Atmesti';

  @override
  String get documentEdited => 'Redaguota';

  @override
  String get documentSaved => 'Issaugota';

  @override
  String get menuSettings => 'Nustatymai...';

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get settingsLanguage => 'Kalba';

  @override
  String get settingsLanguageSystem => 'Sistemos numatytoji';

  @override
  String get settingsUnits => 'Matavimo vienetai';

  @override
  String get settingsUnitsCentimeters => 'Centimetrai';

  @override
  String get settingsUnitsInches => 'Coliai';

  @override
  String get settingsSearchLanguages => 'Ieškoti kalbų...';
}
