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
  String get menuSaveAll => 'Alle speichern';

  @override
  String get menuShare => 'Teilen...';

  @override
  String get menuCloseWindow => 'Fenster schließen';

  @override
  String get menuCloseAll => 'Alle schließen';

  @override
  String get menuEdit => 'Bearbeiten';

  @override
  String get menuDelete => 'Löschen';

  @override
  String get menuView => 'Darstellung';

  @override
  String goToPagePrompt(int total) {
    return 'Seitenzahl eingeben (1–$total):';
  }

  @override
  String get goToPageHint => 'Seitenzahl';

  @override
  String get goToPageInvalid => 'Bitte geben Sie eine gültige Zahl ein';

  @override
  String goToPageOutOfRange(int total) {
    return 'Die Seite muss zwischen 1 und $total liegen';
  }

  @override
  String get menuRotateLeft => 'Nach links drehen';

  @override
  String get menuRotateRight => 'Nach rechts drehen';

  @override
  String get menuCut => 'Ausschneiden';

  @override
  String get menuCopy => 'Kopieren';

  @override
  String get menuPaste => 'Einsetzen';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bilder',
      one: 'Bild',
    );
    return 'Nicht hinzugefügt: $count $_temp0 größer als $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bilder',
      one: 'Bild',
    );
    return 'Nicht hinzugefügt: $count $_temp0 größer als $limit Pixel';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bilder',
      one: 'Bild',
    );
    return 'Nicht hinzugefügt: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'Die Zwischenablage ist nicht verfügbar';

  @override
  String get pasteImageFailed => 'Dieses Bild konnte nicht hinzugefügt werden';

  @override
  String get menuQuit => 'PDFSign beenden';

  @override
  String get closeAllDialogTitle => 'Änderungen speichern?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Möchten Sie die Änderungen in $count Dokumenten vor dem Schließen speichern?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Möchten Sie die Änderungen in 1 Dokument vor dem Schließen speichern?';

  @override
  String get closeAllDialogSaveAll => 'Alle speichern';

  @override
  String get closeAllDialogDontSave => 'Nicht speichern';

  @override
  String get closeAllDialogCancel => 'Abbrechen';

  @override
  String get saveFailedDialogTitle => 'Speichern fehlgeschlagen';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count Dokument(e) konnten nicht gespeichert werden. Trotzdem schließen?';
  }

  @override
  String get saveFailedDialogClose => 'Trotzdem schließen';

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
  String get menuWindow => 'Fenster';

  @override
  String get menuMinimize => 'Minimieren';

  @override
  String get menuZoom => 'Zoomen';

  @override
  String get menuBringAllToFront => 'Alle nach vorne bringen';

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

  @override
  String get settingsGeneral => 'Allgemein';

  @override
  String get addImage => 'Bild hinzufügen';

  @override
  String get selectImages => 'Bilder auswählen';

  @override
  String get zoomFitWidth => 'Breite anpassen';

  @override
  String get zoomIn => 'Vergrößern';

  @override
  String get zoomOut => 'Verkleinern';

  @override
  String get selectZoomLevel => 'Zoomstufe auswählen';

  @override
  String get goToPage => 'Gehe zu Seite';

  @override
  String get go => 'Los';

  @override
  String get savePdfAs => 'PDF speichern unter';

  @override
  String get incorrectPassword => 'Falsches Passwort';

  @override
  String get saveFailed => 'Speichern fehlgeschlagen';

  @override
  String savedTo(String path) {
    return 'Gespeichert unter: $path';
  }

  @override
  String get noOriginalPdfStored => 'Kein Original-PDF gespeichert';

  @override
  String get waitingForFolderPermission =>
      'Warten auf Ordnerzugriffsberechtigung...';

  @override
  String get deleteButtonLabel => 'Löschen';

  @override
  String get deleteButtonTooltip => 'Ausgewähltes Objekt löschen';

  @override
  String get documentProtectedTitle => 'Dieses Dokument ist geschützt';

  @override
  String get documentProtectedBody =>
      'Geben Sie das Passwort ein, um es zu öffnen.';

  @override
  String get passwordFieldLabel => 'Passwort';

  @override
  String get openDocumentButton => 'Öffnen';

  @override
  String get documentReadOnlyTitle =>
      'Dieses Dokument erlaubt keine Änderungen';

  @override
  String get documentReadOnlyBody =>
      'Es kann gelesen und gedruckt werden, doch sein Eigentümer hat Änderungen nicht erlaubt. Geben Sie das Eigentümerpasswort ein, um es zu bearbeiten.';

  @override
  String get enterOwnerPassword => 'Eigentümerpasswort eingeben';

  @override
  String get ownerPasswordFieldLabel => 'Eigentümerpasswort';

  @override
  String get menuPrint => 'Drucken…';

  @override
  String get menuPrintCurrentPage => 'Aktuelle Seite drucken';

  @override
  String get printingIsTheOwnersTitle =>
      'Nur der Eigentümer darf dieses Dokument drucken';

  @override
  String get printingNotAllowed => 'Dieses Dokument erlaubt kein Drucken.';

  @override
  String get printingFailed => 'Das Dokument konnte nicht gedruckt werden.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Nur der Eigentümer darf den Schutz dieses Dokuments ändern';

  @override
  String get continueButton => 'Fortfahren';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Ein geschütztes Dokument wird aus dem Arbeitsspeicher angezeigt, und dieses ist $size groß. Das Öffnen benötigt etwa ebenso viel Speicher.';
  }

  @override
  String get shareProtectedNotice =>
      'Die geteilte Kopie behält das Passwort des Dokuments.';

  @override
  String get unsupportedProtection =>
      'Der Schutz dieses Dokuments wird nicht unterstützt. PDFSign öffnet mit einem Passwort geschützte Dokumente, nicht solche mit einem Zertifikat.';

  @override
  String get menuBringToFront => 'Ganz nach vorne';

  @override
  String get menuBringForward => 'Nach vorne';

  @override
  String get menuSendBackward => 'Nach hinten';

  @override
  String get menuSendToBack => 'Ganz nach hinten';

  @override
  String get zOrderGroupLabel => 'Anordnen';

  @override
  String get menuUndo => 'Widerrufen';

  @override
  String get menuRedo => 'Wiederholen';

  @override
  String get dragToReorder => 'Ziehen, um die Reihenfolge zu ändern';

  @override
  String get protectDocumentTitle => 'Dokument schützen';

  @override
  String get requirePasswordToOpen =>
      'Passwort zum Öffnen des Dokuments verlangen';

  @override
  String get verifyFieldLabel => 'Bestätigen';

  @override
  String get permissionsHeading => 'Berechtigungen';

  @override
  String get permissionsNote =>
      'Folgende Änderungen ohne Eingabe des Eigentümerpassworts erlauben.';

  @override
  String get permissionPrinting => 'Drucken';

  @override
  String get permissionCopying => 'Kopieren von Text oder Grafiken';

  @override
  String get permissionPageAssembly =>
      'Einfügen, Löschen oder Drehen von Seiten';

  @override
  String get permissionAnnotations =>
      'Hinzufügen von Anmerkungen oder Unterschriften';

  @override
  String get permissionChangingContent => 'Ändern des Dokuments';

  @override
  String get permissionFormFilling => 'Ausfüllen vorhandener Formularfelder';

  @override
  String get changingContentIncludes =>
      'Das Ändern des Dokuments schließt Anmerkungen und das Ausfüllen von Formularen ein; beides wird damit erlaubt.';

  @override
  String get ownerPasswordHeading => 'Eigentümerpasswort';

  @override
  String get removeProtection => 'Schutz entfernen';

  @override
  String get applyButton => 'Anwenden';

  @override
  String get passwordsDoNotMatch => 'Die Passwörter stimmen nicht überein';

  @override
  String get passwordCannotBeEmpty => 'Geben Sie ein Passwort ein';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Einschränkungen benötigen ein Eigentümerpasswort. Ohne dieses kann sie jeder aufheben.';

  @override
  String get signingNeedsChangingContent =>
      'Ohne „Ändern des Dokuments“ kann diese Datei hier nicht erneut unterschrieben werden, solange das Eigentümerpasswort fehlt.';

  @override
  String get menuProtectDocument => 'Dokument schützen…';

  @override
  String get protectButtonLabel => 'Schützen';

  @override
  String get protectButtonTooltip =>
      'Passwörter und Berechtigungen dieses Dokuments festlegen';
}
