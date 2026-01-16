// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get openPdf => 'PDF ashu';

  @override
  String get selectPdf => 'PDF tandau';

  @override
  String get recentFiles => 'Songhy fayldar';

  @override
  String get removeFromList => 'Tizimnen oshiru';

  @override
  String get openedNow => 'Kazir ashyldy';

  @override
  String openedMinutesAgo(int count) {
    return '$count minut buryn ashyldy';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count saghat buryn ashyldy';
  }

  @override
  String get openedYesterday => 'Keshe ashyldy';

  @override
  String openedDaysAgo(int count) {
    return '$count kun buryn ashyldy';
  }

  @override
  String get fileNotFound => 'Fayl tabylmady';

  @override
  String get fileAccessDenied => 'Kiru tyiym salyndy';

  @override
  String get clearRecentFiles => 'Songhy fayldardy tazalau';

  @override
  String get cancel => 'Boldyrmai';

  @override
  String get confirm => 'Rastau';

  @override
  String get error => 'Qate';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Ashu...';

  @override
  String get menuOpenRecent => 'Songhylardy ashu';

  @override
  String get menuNoRecentFiles => 'Songhy fayldar zhoq';

  @override
  String get menuClearMenu => 'Menudi tazalau';

  @override
  String get menuSave => 'Saqtau';

  @override
  String get menuSaveAs => 'Basqasha saqtau...';

  @override
  String get menuShare => 'Bolisu...';

  @override
  String get menuCloseWindow => 'Terezeni zhabu';

  @override
  String get saveChangesTitle => 'Ozgeristerdi saqtau?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Zhabardyn aldynda \"$fileName\" faylyndaghy ozgeristerdi saqtaunu qalaisyz ba?';
  }

  @override
  String get saveButton => 'Saqtau';

  @override
  String get discardButton => 'Saqtamau';

  @override
  String get documentEdited => 'Ozgertildi';

  @override
  String get documentSaved => 'Saqtaldy';

  @override
  String get menuSettings => 'Parametrler...';

  @override
  String get settingsTitle => 'Parametrler';

  @override
  String get settingsLanguage => 'Til';

  @override
  String get settingsLanguageSystem => 'Zhyie adepki';

  @override
  String get settingsUnits => 'Olshem birlkteri';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Diuym';

  @override
  String get settingsSearchLanguages => 'Тілдерді іздеу...';

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
