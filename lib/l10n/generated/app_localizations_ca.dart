// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get openPdf => 'Obre PDF';

  @override
  String get selectPdf => 'Selecciona PDF';

  @override
  String get recentFiles => 'Fitxers recents';

  @override
  String get removeFromList => 'Elimina de la llista';

  @override
  String get openedNow => 'Obert ara mateix';

  @override
  String openedMinutesAgo(int count) {
    return 'Obert fa $count minuts';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Obert fa $count hores';
  }

  @override
  String get openedYesterday => 'Obert ahir';

  @override
  String openedDaysAgo(int count) {
    return 'Obert fa $count dies';
  }

  @override
  String get fileNotFound => 'Fitxer no trobat';

  @override
  String get fileAccessDenied => 'Acces denegat';

  @override
  String get clearRecentFiles => 'Neteja fitxers recents';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get confirm => 'Confirma';

  @override
  String get error => 'Error';

  @override
  String get ok => 'D\'acord';

  @override
  String get menuFile => 'Fitxer';

  @override
  String get menuOpen => 'Obre...';

  @override
  String get menuOpenRecent => 'Obre recents';

  @override
  String get menuNoRecentFiles => 'Cap fitxer recent';

  @override
  String get menuClearMenu => 'Neteja el menu';

  @override
  String get menuSave => 'Desa';

  @override
  String get menuSaveAs => 'Anomena i desa...';

  @override
  String get menuShare => 'Comparteix...';

  @override
  String get menuCloseWindow => 'Tanca la finestra';

  @override
  String get saveChangesTitle => 'Desar els canvis?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vols desar els canvis a \"$fileName\" abans de tancar?';
  }

  @override
  String get saveButton => 'Desa';

  @override
  String get discardButton => 'No desis';

  @override
  String get documentEdited => 'Editat';

  @override
  String get documentSaved => 'Desat';

  @override
  String get menuSettings => 'Configuracio...';

  @override
  String get settingsTitle => 'Configuracio';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Per defecte del sistema';

  @override
  String get settingsUnits => 'Unitats';

  @override
  String get settingsUnitsCentimeters => 'Centimetres';

  @override
  String get settingsUnitsInches => 'Polzades';

  @override
  String get settingsSearchLanguages => 'Cercar idiomes...';

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
