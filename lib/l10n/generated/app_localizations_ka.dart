// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get openPdf => 'PDF-is gakhsna';

  @override
  String get selectPdf => 'PDF-is archeeva';

  @override
  String get recentFiles => 'bolodroindfeli failebi';

  @override
  String get removeFromList => 'siidan amoshla';

  @override
  String get openedNow => 'akhla gakhsnili';

  @override
  String openedMinutesAgo(int count) {
    return 'gakhsnili $count tsutis tsin';
  }

  @override
  String openedHoursAgo(int count) {
    return 'gakhsnili $count saatis tsin';
  }

  @override
  String get openedYesterday => 'gakhsnili gushin';

  @override
  String openedDaysAgo(int count) {
    return 'gakhsnili $count dghis tsin';
  }

  @override
  String get fileNotFound => 'faili ver moidzebna';

  @override
  String get fileAccessDenied => 'tsvrda akridzalulia';

  @override
  String get clearRecentFiles => 'bolodroindfeli failebis gasuptaveba';

  @override
  String get cancel => 'gaukmeba';

  @override
  String get confirm => 'dadastureba';

  @override
  String get error => 'shecdoma';

  @override
  String get ok => 'karghi';

  @override
  String get menuFile => 'Faili';

  @override
  String get menuOpen => 'Gakhsna...';

  @override
  String get menuOpenRecent => 'Bolodroindfeli';

  @override
  String get menuNoRecentFiles => 'Ar aris bolodroindfeli failebi';

  @override
  String get menuClearMenu => 'Meniuis gasuptaveba';

  @override
  String get menuSave => 'Shenakhva';

  @override
  String get menuSaveAs => 'Shenakhva rogorc...';

  @override
  String get menuShare => 'Gaziareba...';

  @override
  String get menuCloseWindow => 'Panjeris dakhetva';

  @override
  String get saveChangesTitle => 'Cvlilebebis shenakhva?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Gindakht shenakhat cvlilebebi \"$fileName\"-shi dakhetvamdfe?';
  }

  @override
  String get saveButton => 'Shenakhva';

  @override
  String get discardButton => 'Gaukmeba';

  @override
  String get documentEdited => 'Redaktrebuli';

  @override
  String get documentSaved => 'Shenakhuli';

  @override
  String get menuSettings => 'Parametrebi...';

  @override
  String get settingsTitle => 'Parametrebi';

  @override
  String get settingsLanguage => 'Ena';

  @override
  String get settingsLanguageSystem => 'Sistemis nagulistseti';

  @override
  String get settingsUnits => 'Erteuelebi';

  @override
  String get settingsUnitsCentimeters => 'Santimetrebi';

  @override
  String get settingsUnitsInches => 'Diumebi';

  @override
  String get settingsSearchLanguages => 'ენების ძიება...';
}
