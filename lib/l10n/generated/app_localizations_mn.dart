// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Mongolian (`mn`).
class AppLocalizationsMn extends AppLocalizations {
  AppLocalizationsMn([String locale = 'mn']) : super(locale);

  @override
  String get openPdf => 'PDF neekh';

  @override
  String get selectPdf => 'PDF songokh';

  @override
  String get recentFiles => 'Suuliin failuud';

  @override
  String get removeFromList => 'Jisneesee ustgakh';

  @override
  String get openedNow => 'Doorond neegdsen';

  @override
  String openedMinutesAgo(int count) {
    return '$count minut umnuh neegdsen';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count tsag umnuh neegdsen';
  }

  @override
  String get openedYesterday => 'Uchidar neegdsen';

  @override
  String openedDaysAgo(int count) {
    return '$count udur umnuh neegdsen';
  }

  @override
  String get fileNotFound => 'Fail oldsongui';

  @override
  String get fileAccessDenied => 'Nevtrekh khorigdson';

  @override
  String get clearRecentFiles => 'Suuliin failuudig tsooglokh';

  @override
  String get cancel => 'Tsooglokh';

  @override
  String get confirm => 'Batalgaajulakh';

  @override
  String get error => 'Aldaa';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fail';

  @override
  String get menuOpen => 'Neekh...';

  @override
  String get menuOpenRecent => 'Suuliiniig neekh';

  @override
  String get menuNoRecentFiles => 'Suuliin failuud baihgui';

  @override
  String get menuClearMenu => 'Tsesiig tsooglokh';

  @override
  String get menuSave => 'Khadgalakh';

  @override
  String get menuSaveAs => 'Uur nereeer khadgalakh...';

  @override
  String get menuShare => 'Khuvaaltsakh...';

  @override
  String get menuCloseWindow => 'Tsonkhig khakh';

  @override
  String get saveChangesTitle => 'Uurchlultiig khadgalakh uu?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ta \"$fileName\" failliin uurchlultiig khakhaskhan umnuh khadgalakh uu?';
  }

  @override
  String get saveButton => 'Khadgalakh';

  @override
  String get discardButton => 'Ustgakh';

  @override
  String get documentEdited => 'Uurchilsen';

  @override
  String get documentSaved => 'Khadgalagdsan';

  @override
  String get menuSettings => 'Tohirgoo...';

  @override
  String get settingsTitle => 'Tohirgoo';

  @override
  String get settingsLanguage => 'Khel';

  @override
  String get settingsLanguageSystem => 'Sistemiin suuri';

  @override
  String get settingsUnits => 'Khemjeekh neghj';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'Хэл хайх...';
}
