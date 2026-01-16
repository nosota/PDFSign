// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get openPdf => 'Buksan ang PDF';

  @override
  String get selectPdf => 'Pumili ng PDF';

  @override
  String get recentFiles => 'Kamakailang mga file';

  @override
  String get removeFromList => 'Alisin sa listahan';

  @override
  String get openedNow => 'Kabukas lang';

  @override
  String openedMinutesAgo(int count) {
    return 'Binuksan $count minuto na ang nakalipas';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Binuksan $count oras na ang nakalipas';
  }

  @override
  String get openedYesterday => 'Binuksan kahapon';

  @override
  String openedDaysAgo(int count) {
    return 'Binuksan $count araw na ang nakalipas';
  }

  @override
  String get fileNotFound => 'Hindi nahanap ang file';

  @override
  String get fileAccessDenied => 'Tinanggihan ang access';

  @override
  String get clearRecentFiles => 'I-clear ang mga kamakailang file';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get confirm => 'Kumpirmahin';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Buksan...';

  @override
  String get menuOpenRecent => 'Buksan ang Kamakailang';

  @override
  String get menuNoRecentFiles => 'Walang kamakailang mga file';

  @override
  String get menuClearMenu => 'I-clear ang Menu';

  @override
  String get menuSave => 'I-save';

  @override
  String get menuSaveAs => 'I-save Bilang...';

  @override
  String get menuShare => 'Ibahagi...';

  @override
  String get menuCloseWindow => 'Isara ang Window';

  @override
  String get saveChangesTitle => 'I-save ang mga pagbabago?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Gusto mo bang i-save ang mga pagbabago sa \"$fileName\" bago isara?';
  }

  @override
  String get saveButton => 'I-save';

  @override
  String get discardButton => 'Huwag i-save';

  @override
  String get documentEdited => 'Na-edit';

  @override
  String get documentSaved => 'Na-save';

  @override
  String get menuSettings => 'Mga Setting...';

  @override
  String get settingsTitle => 'Mga Setting';

  @override
  String get settingsLanguage => 'Wika';

  @override
  String get settingsLanguageSystem => 'Default ng System';

  @override
  String get settingsUnits => 'Mga Unit';

  @override
  String get settingsUnitsCentimeters => 'Sentimetro';

  @override
  String get settingsUnitsInches => 'Pulgada';

  @override
  String get settingsSearchLanguages => 'Maghanap ng wika...';
}
