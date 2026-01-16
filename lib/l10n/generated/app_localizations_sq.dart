// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get openPdf => 'Hap PDF';

  @override
  String get selectPdf => 'Zgjidh PDF';

  @override
  String get recentFiles => 'Skedaret e fundit';

  @override
  String get removeFromList => 'Hiq nga lista';

  @override
  String get openedNow => 'Sapo u hap';

  @override
  String openedMinutesAgo(int count) {
    return 'U hap $count minuta me pare';
  }

  @override
  String openedHoursAgo(int count) {
    return 'U hap $count ore me pare';
  }

  @override
  String get openedYesterday => 'U hap dje';

  @override
  String openedDaysAgo(int count) {
    return 'U hap $count dite me pare';
  }

  @override
  String get fileNotFound => 'Skedari nuk u gjet';

  @override
  String get fileAccessDenied => 'Qasja e refuzuar';

  @override
  String get clearRecentFiles => 'Pastro skedaret e fundit';

  @override
  String get cancel => 'Anullo';

  @override
  String get confirm => 'Konfirmo';

  @override
  String get error => 'Gabim';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Skedar';

  @override
  String get menuOpen => 'Hap...';

  @override
  String get menuOpenRecent => 'Hap te fundit';

  @override
  String get menuNoRecentFiles => 'Nuk ka skedare te fundit';

  @override
  String get menuClearMenu => 'Pastro menune';

  @override
  String get menuSave => 'Ruaj';

  @override
  String get menuSaveAs => 'Ruaj si...';

  @override
  String get menuShare => 'Ndaj...';

  @override
  String get menuCloseWindow => 'Mbyll dritaren';

  @override
  String get saveChangesTitle => 'Ruaj ndryshimet?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deshironi te ruani ndryshimet ne \"$fileName\" para se te mbyllni?';
  }

  @override
  String get saveButton => 'Ruaj';

  @override
  String get discardButton => 'Mos ruaj';

  @override
  String get documentEdited => 'I redaktuar';

  @override
  String get documentSaved => 'U ruajt';

  @override
  String get menuSettings => 'Cilesimet...';

  @override
  String get settingsTitle => 'Cilesimet';

  @override
  String get settingsLanguage => 'Gjuha';

  @override
  String get settingsLanguageSystem => 'Parazgjedhja e sistemit';

  @override
  String get settingsUnits => 'Njesite';

  @override
  String get settingsUnitsCentimeters => 'Centimetra';

  @override
  String get settingsUnitsInches => 'Inca';

  @override
  String get settingsSearchLanguages => 'Kërko gjuhët...';

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
