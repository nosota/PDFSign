// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class AppLocalizationsHy extends AppLocalizations {
  AppLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get openPdf => 'Batsvel PDF';

  @override
  String get selectPdf => 'Yntrel PDF';

  @override
  String get recentFiles => 'Verdjin faylery';

  @override
  String get removeFromList => 'Heratsel tsankits';

  @override
  String get openedNow => 'Nor batsvetso';

  @override
  String openedMinutesAgo(int count) {
    return 'Batsvetso $count rope araj';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Batsvetso $count zham araj';
  }

  @override
  String get openedYesterday => 'Batsvetso yerek';

  @override
  String openedDaysAgo(int count) {
    return 'Batsvetso $count or araj';
  }

  @override
  String get fileNotFound => 'Fayli chi gtanyel';

  @override
  String get fileAccessDenied => 'Mtky merjvatso e';

  @override
  String get clearRecentFiles => 'Maqrel verdjin faylery';

  @override
  String get cancel => 'Chygarkvel';

  @override
  String get confirm => 'Hastatel';

  @override
  String get error => 'Skhalk';

  @override
  String get ok => 'Lav';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Batsvel...';

  @override
  String get menuOpenRecent => 'Batsvel verdjiny';

  @override
  String get menuNoRecentFiles => 'Verdjin faylyr chkan';

  @override
  String get menuClearMenu => 'Maqrel tsanky';

  @override
  String get menuSave => 'Pakhpanel';

  @override
  String get menuSaveAs => 'Pakhpanel orpes...';

  @override
  String get menuShare => 'Kisel...';

  @override
  String get menuCloseWindow => 'Pakers patuhan';

  @override
  String get saveChangesTitle => 'Pakhpanel pokhutyyunnery?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Uzum eq pakhpanel \"$fileName\" faylum katrvatso pokhutyyunnery pokhelu araj?';
  }

  @override
  String get saveButton => 'Pakhpanel';

  @override
  String get discardButton => 'Chpakhpanel';

  @override
  String get documentEdited => 'Khmbagrets';

  @override
  String get documentSaved => 'Pakhpanvatso e';

  @override
  String get menuSettings => 'Kargavorumner...';

  @override
  String get settingsTitle => 'Kargavorumner';

  @override
  String get settingsLanguage => 'Lezu';

  @override
  String get settingsLanguageSystem => 'Hamakargayin lrutso';

  @override
  String get settingsUnits => 'Chapaqi miavorner';

  @override
  String get settingsUnitsCentimeters => 'Santimetrer';

  @override
  String get settingsUnitsInches => 'Duymer';

  @override
  String get settingsSearchLanguages => 'Որոdelays լdelays...';

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
