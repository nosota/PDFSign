// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get openPdf => 'Öppna PDF';

  @override
  String get selectPdf => 'Välj PDF';

  @override
  String get recentFiles => 'Senaste filer';

  @override
  String get removeFromList => 'Ta bort från listan';

  @override
  String get openedNow => 'Nyss öppnad';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuter',
      one: 'minut',
    );
    return 'Öppnad för $count $_temp0 sedan';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'timmar',
      one: 'timme',
    );
    return 'Öppnad för $count $_temp0 sedan';
  }

  @override
  String get openedYesterday => 'Öppnad igår';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dagar',
      one: 'dag',
    );
    return 'Öppnad för $count $_temp0 sedan';
  }

  @override
  String get fileNotFound => 'Filen hittades inte';

  @override
  String get fileAccessDenied => 'Åtkomst nekad';

  @override
  String get clearRecentFiles => 'Rensa senaste filer';

  @override
  String get cancel => 'Avbryt';

  @override
  String get confirm => 'Bekräfta';

  @override
  String get error => 'Fel';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkiv';

  @override
  String get menuOpen => 'Öppna...';

  @override
  String get menuOpenRecent => 'Öppna senaste';

  @override
  String get menuNoRecentFiles => 'Inga senaste filer';

  @override
  String get menuClearMenu => 'Rensa menyn';

  @override
  String get menuSave => 'Spara';

  @override
  String get menuSaveAs => 'Spara som...';

  @override
  String get menuShare => 'Dela...';

  @override
  String get menuCloseWindow => 'Stäng fönster';

  @override
  String get saveChangesTitle => 'Spara ändringar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vill du spara ändringarna i \"$fileName\" innan du stänger?';
  }

  @override
  String get saveButton => 'Spara';

  @override
  String get discardButton => 'Spara inte';

  @override
  String get documentEdited => 'Redigerad';

  @override
  String get documentSaved => 'Sparad';

  @override
  String get menuSettings => 'Inställningar...';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Enheter';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Tum';

  @override
  String get settingsSearchLanguages => 'Sök språk...';

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
