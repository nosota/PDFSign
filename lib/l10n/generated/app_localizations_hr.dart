// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get openPdf => 'Otvori PDF';

  @override
  String get selectPdf => 'Odaberi PDF';

  @override
  String get recentFiles => 'Nedavne datoteke';

  @override
  String get removeFromList => 'Ukloni s popisa';

  @override
  String get openedNow => 'Upravo otvoreno';

  @override
  String openedMinutesAgo(int count) {
    return 'Otvoreno prije $count minuta';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Otvoreno prije $count sati';
  }

  @override
  String get openedYesterday => 'Otvoreno jucer';

  @override
  String openedDaysAgo(int count) {
    return 'Otvoreno prije $count dana';
  }

  @override
  String get fileNotFound => 'Datoteka nije pronadena';

  @override
  String get fileAccessDenied => 'Pristup odbijen';

  @override
  String get clearRecentFiles => 'Ocisti nedavne datoteke';

  @override
  String get cancel => 'Odustani';

  @override
  String get confirm => 'Potvrdi';

  @override
  String get error => 'Greska';

  @override
  String get ok => 'U redu';

  @override
  String get menuFile => 'Datoteka';

  @override
  String get menuOpen => 'Otvori...';

  @override
  String get menuOpenRecent => 'Otvori nedavne';

  @override
  String get menuNoRecentFiles => 'Nema nedavnih datoteka';

  @override
  String get menuClearMenu => 'Ocisti izbornik';

  @override
  String get menuSave => 'Spremi';

  @override
  String get menuSaveAs => 'Spremi kao...';

  @override
  String get menuShare => 'Podijeli...';

  @override
  String get menuCloseWindow => 'Zatvori prozor';

  @override
  String get saveChangesTitle => 'Spremi promjene?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Zelite li spremiti promjene u \"$fileName\" prije zatvaranja?';
  }

  @override
  String get saveButton => 'Spremi';

  @override
  String get discardButton => 'Ne spremi';

  @override
  String get documentEdited => 'Uredeno';

  @override
  String get documentSaved => 'Spremljeno';

  @override
  String get menuSettings => 'Postavke...';

  @override
  String get settingsTitle => 'Postavke';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Zadano sustava';

  @override
  String get settingsUnits => 'Jedinice';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Inci';

  @override
  String get settingsSearchLanguages => 'Pretraži jezike...';

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
