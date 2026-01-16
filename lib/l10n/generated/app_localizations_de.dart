// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get openPdf => 'PDF öffnen';

  @override
  String get selectPdf => 'PDF auswählen';

  @override
  String get recentFiles => 'Zuletzt verwendet';

  @override
  String get removeFromList => 'Aus Liste entfernen';

  @override
  String get openedNow => 'Gerade geöffnet';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Minuten',
      one: 'Minute',
    );
    return 'Vor $count $_temp0 geöffnet';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Stunden',
      one: 'Stunde',
    );
    return 'Vor $count $_temp0 geöffnet';
  }

  @override
  String get openedYesterday => 'Gestern geöffnet';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tagen',
      one: 'Tag',
    );
    return 'Vor $count $_temp0 geöffnet';
  }

  @override
  String get fileNotFound => 'Datei nicht gefunden';

  @override
  String get fileAccessDenied => 'Zugriff verweigert';

  @override
  String get clearRecentFiles => 'Zuletzt verwendet löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get error => 'Fehler';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Ablage';

  @override
  String get menuOpen => 'Öffnen...';

  @override
  String get menuOpenRecent => 'Zuletzt verwendet';

  @override
  String get menuNoRecentFiles => 'Keine zuletzt verwendeten Dateien';

  @override
  String get menuClearMenu => 'Menü löschen';

  @override
  String get menuSave => 'Sichern';

  @override
  String get menuSaveAs => 'Sichern unter...';

  @override
  String get menuShare => 'Teilen...';

  @override
  String get menuCloseWindow => 'Fenster schließen';

  @override
  String get saveChangesTitle => 'Änderungen sichern?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Möchten Sie die Änderungen in \"$fileName\" vor dem Schließen sichern?';
  }

  @override
  String get saveButton => 'Sichern';

  @override
  String get discardButton => 'Nicht sichern';

  @override
  String get documentEdited => 'Bearbeitet';

  @override
  String get documentSaved => 'Gesichert';

  @override
  String get menuSettings => 'Einstellungen...';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Einheiten';

  @override
  String get settingsUnitsCentimeters => 'Zentimeter';

  @override
  String get settingsUnitsInches => 'Zoll';

  @override
  String get settingsSearchLanguages => 'Sprachen suchen...';
}
