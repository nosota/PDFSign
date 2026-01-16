// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get openPdf => 'Anoigma PDF';

  @override
  String get selectPdf => 'Epilogi PDF';

  @override
  String get recentFiles => 'Prosfata archeia';

  @override
  String get removeFromList => 'Afairesi apo ti lista';

  @override
  String get openedNow => 'Molis anoixe';

  @override
  String openedMinutesAgo(int count) {
    return 'Anoixe prin apo $count lepta';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Anoixe prin apo $count ores';
  }

  @override
  String get openedYesterday => 'Anoixe chthes';

  @override
  String openedDaysAgo(int count) {
    return 'Anoixe prin apo $count imeres';
  }

  @override
  String get fileNotFound => 'To archeio den vrethike';

  @override
  String get fileAccessDenied => 'Den epitrepetai i prosvasi';

  @override
  String get clearRecentFiles => 'Ekkatharisi prosfaton archeion';

  @override
  String get cancel => 'Akyrosi';

  @override
  String get confirm => 'Epivevaiosi';

  @override
  String get error => 'Sfalma';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Archeio';

  @override
  String get menuOpen => 'Anoigma...';

  @override
  String get menuOpenRecent => 'Anoigma prosfaton';

  @override
  String get menuNoRecentFiles => 'Den yparxoun prosfata archeia';

  @override
  String get menuClearMenu => 'Ekkatharisi menou';

  @override
  String get menuSave => 'Apothikefsi';

  @override
  String get menuSaveAs => 'Apothikefsi os...';

  @override
  String get menuShare => 'Koinopoiisi...';

  @override
  String get menuCloseWindow => 'Kleisimo parathyrou';

  @override
  String get saveChangesTitle => 'Apothikefsi allagon?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Thelete na apothikefthoun oi allages sto \"$fileName\" prin to kleisimo?';
  }

  @override
  String get saveButton => 'Apothikefsi';

  @override
  String get discardButton => 'Aporripsi';

  @override
  String get documentEdited => 'Epexergasmeno';

  @override
  String get documentSaved => 'Apothikeftike';

  @override
  String get menuSettings => 'Rythmiseis...';

  @override
  String get settingsTitle => 'Rythmiseis';

  @override
  String get settingsLanguage => 'Glossa';

  @override
  String get settingsLanguageSystem => 'Proepilogi systimatos';

  @override
  String get settingsUnits => 'Monades';

  @override
  String get settingsUnitsCentimeters => 'Ekatosta';

  @override
  String get settingsUnitsInches => 'Intses';

  @override
  String get settingsSearchLanguages => 'Αναζήτηση γλωσσών...';

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
