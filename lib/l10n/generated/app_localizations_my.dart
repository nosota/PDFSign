// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get openPdf => 'PDF phwint';

  @override
  String get selectPdf => 'PDF rwe';

  @override
  String get recentFiles => 'Makhawkamhar file myar';

  @override
  String get removeFromList => 'Saryin hma hpyout';

  @override
  String get openedNow => 'Achu phwint lite';

  @override
  String openedMinutesAgo(int count) {
    return 'Minit $count u gar phwint';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Nari $count u gar phwint';
  }

  @override
  String get openedYesterday => 'Mahnekaun phwint';

  @override
  String openedDaysAgo(int count) {
    return 'Rout $count u gar phwint';
  }

  @override
  String get fileNotFound => 'File mar shi';

  @override
  String get fileAccessDenied => 'Win khwint mar rhi';

  @override
  String get clearRecentFiles => 'Makhawkamhar file myar ko shot';

  @override
  String get cancel => 'Pyet';

  @override
  String get confirm => 'Atint pyuu';

  @override
  String get error => 'Arhar';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Phwint...';

  @override
  String get menuOpenRecent => 'Makhawkamhar phwint';

  @override
  String get menuNoRecentFiles => 'Makhawkamhar file myar mar rhi';

  @override
  String get menuClearMenu => 'Menu ko shot';

  @override
  String get menuSave => 'Thein';

  @override
  String get menuSaveAs => 'Aloat thein...';

  @override
  String get menuShare => 'Mhway vway...';

  @override
  String get menuCloseWindow => 'Window peit';

  @override
  String get saveChangesTitle => 'Pyaunglevmhuu thein malar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Mapeitmhin \"$fileName\" hta pyaunglevmhuu thein larmalar?';
  }

  @override
  String get saveButton => 'Thein';

  @override
  String get discardButton => 'Ma thein';

  @override
  String get documentEdited => 'Pyifjyifpyi';

  @override
  String get documentSaved => 'Thein pyi';

  @override
  String get menuSettings => 'Setting myar...';

  @override
  String get settingsTitle => 'Setting myar';

  @override
  String get settingsLanguage => 'Bhashar zagar';

  @override
  String get settingsLanguageSystem => 'System mhuu run';

  @override
  String get settingsUnits => 'Tinetunit myar';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'ဘာသာစကား ရှာရန်...';
}
