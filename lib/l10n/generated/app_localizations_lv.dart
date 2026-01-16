// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get openPdf => 'Avert PDF';

  @override
  String get selectPdf => 'Izvelieties PDF';

  @override
  String get recentFiles => 'Nesenie faili';

  @override
  String get removeFromList => 'Nonemt no saraksta';

  @override
  String get openedNow => 'Tikko atverts';

  @override
  String openedMinutesAgo(int count) {
    return 'Atverts pirms $count minutem';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Atverts pirms $count stundam';
  }

  @override
  String get openedYesterday => 'Atverts vakar';

  @override
  String openedDaysAgo(int count) {
    return 'Atverts pirms $count dienam';
  }

  @override
  String get fileNotFound => 'Fails nav atrasts';

  @override
  String get fileAccessDenied => 'Pieklave liegta';

  @override
  String get clearRecentFiles => 'Notiret nesenos failus';

  @override
  String get cancel => 'Atcelt';

  @override
  String get confirm => 'Apstiprinat';

  @override
  String get error => 'Kluda';

  @override
  String get ok => 'Labi';

  @override
  String get menuFile => 'Fails';

  @override
  String get menuOpen => 'Avert...';

  @override
  String get menuOpenRecent => 'Avert nesenos';

  @override
  String get menuNoRecentFiles => 'Nav neseno failu';

  @override
  String get menuClearMenu => 'Notiret izvēlni';

  @override
  String get menuSave => 'Saglabat';

  @override
  String get menuSaveAs => 'Saglabat ka...';

  @override
  String get menuShare => 'Dalieties...';

  @override
  String get menuCloseWindow => 'Aizvert logu';

  @override
  String get saveChangesTitle => 'Saglabat izmainas?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vai velaties saglabat izmainas faila \"$fileName\" pirms aizvershanas?';
  }

  @override
  String get saveButton => 'Saglabat';

  @override
  String get discardButton => 'Nesaglabat';

  @override
  String get documentEdited => 'Redigets';

  @override
  String get documentSaved => 'Saglabats';

  @override
  String get menuSettings => 'Iestatijumi...';

  @override
  String get settingsTitle => 'Iestatijumi';

  @override
  String get settingsLanguage => 'Valoda';

  @override
  String get settingsLanguageSystem => 'Sistemas noklusejums';

  @override
  String get settingsUnits => 'Mervienibas';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Collas';

  @override
  String get settingsSearchLanguages => 'Meklēt valodas...';

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
