// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get openPdf => 'Berk PDF';

  @override
  String get selectPdf => 'Chreuh PDF';

  @override
  String get recentFiles => 'Aeksaa tmey';

  @override
  String get removeFromList => 'Loub chenh pi banchhi';

  @override
  String get openedNow => 'Trov ban berk';

  @override
  String openedMinutesAgo(int count) {
    return 'Berk $count neatii muon';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Berk $count maong muon';
  }

  @override
  String get openedYesterday => 'Berk mselminhh';

  @override
  String openedDaysAgo(int count) {
    return 'Berk $count thngai muon';
  }

  @override
  String get fileNotFound => 'Rork min kheunh aeksaa';

  @override
  String get fileAccessDenied => 'Kar choul dak min trov ban anunhhat';

  @override
  String get clearRecentFiles => 'Somat aeksaa tmey';

  @override
  String get cancel => 'Loeuk leng';

  @override
  String get confirm => 'Banghanh';

  @override
  String get error => 'Khoh';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Aeksaa';

  @override
  String get menuOpen => 'Berk...';

  @override
  String get menuOpenRecent => 'Berk tmey';

  @override
  String get menuNoRecentFiles => 'Kmean aeksaa tmey';

  @override
  String get menuClearMenu => 'Somat menu';

  @override
  String get menuSave => 'Tuktuk';

  @override
  String get menuSaveAs => 'Tuktuk chea...';

  @override
  String get menuShare => 'Chek ruum...';

  @override
  String get menuCloseWindow => 'But baong aas';

  @override
  String get saveChangesTitle => 'Tuktuk kar phlash phder?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Tae anak chong tuktuk kar phlash phder knong \"$fileName\" muon pel but?';
  }

  @override
  String get saveButton => 'Tuktuk';

  @override
  String get discardButton => 'Kum tuktuk';

  @override
  String get documentEdited => 'Kae samruel';

  @override
  String get documentSaved => 'Trov ban tuktuk';

  @override
  String get menuSettings => 'Kar kat tong...';

  @override
  String get settingsTitle => 'Kar kat tong';

  @override
  String get settingsLanguage => 'Pheasaa';

  @override
  String get settingsLanguageSystem => 'Propanh robos brapon';

  @override
  String get settingsUnits => 'Akhphmaan';

  @override
  String get settingsUnitsCentimeters => 'Saangtimaet';

  @override
  String get settingsUnitsInches => 'Aengh';

  @override
  String get settingsSearchLanguages => 'ស្វែងរកភាសា...';
}
