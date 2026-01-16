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
