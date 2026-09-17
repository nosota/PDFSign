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
  String get menuView => 'View';

  @override
  String goToPagePrompt(int total) {
    return 'Enter page number (1-$total):';
  }

  @override
  String get goToPageHint => 'Page number';

  @override
  String get goToPageInvalid => 'Please enter a valid number';

  @override
  String goToPageOutOfRange(int total) {
    return 'Page must be between 1 and $total';
  }

  @override
  String get menuRotateLeft => 'Rotate Left';

  @override
  String get menuRotateRight => 'Rotate Right';

  @override
  String get menuCut => 'Cut';

  @override
  String get menuCopy => 'Copy';

  @override
  String get menuPaste => 'Paste';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Not added: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'The clipboard is unavailable';

  @override
  String get pasteImageFailed => 'That image could not be added';

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
  String get documentProtectedTitle => 'This document is protected';

  @override
  String get documentProtectedBody => 'Enter its password to open it.';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get openDocumentButton => 'Open';

  @override
  String get documentReadOnlyTitle => 'This document does not allow changes';

  @override
  String get documentReadOnlyBody =>
      'It can be read and printed, but its owner has not allowed it to be changed. Enter the owner password to edit it.';

  @override
  String get enterOwnerPassword => 'Enter owner password';

  @override
  String get ownerPasswordFieldLabel => 'Owner password';

  @override
  String get menuPrint => 'Print…';

  @override
  String get menuPrintCurrentPage => 'Print Current Page';

  @override
  String get printingIsTheOwnersTitle =>
      'Only the owner may print this document';

  @override
  String get printingNotAllowed => 'This document does not allow printing.';

  @override
  String get printingFailed => 'The document could not be printed.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Only the owner may change this document\'s protection';

  @override
  String get continueButton => 'Continue';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'A protected document has to be held in memory to be shown, and this one is $size. Opening it will use about that much.';
  }

  @override
  String get shareProtectedNotice =>
      'The shared copy keeps the document\'s password.';

  @override
  String get unsupportedProtection =>
      'This document\'s protection is not supported. PDFSign opens password-protected documents, not those protected by a certificate.';

  @override
  String get menuBringToFront => 'Bring to Front';

  @override
  String get menuBringForward => 'Bring Forward';

  @override
  String get menuSendBackward => 'Send Backward';

  @override
  String get menuSendToBack => 'Send to Back';

  @override
  String get zOrderGroupLabel => 'Arrange';

  @override
  String get menuUndo => 'Undo';

  @override
  String get menuRedo => 'Redo';

  @override
  String get dragToReorder => 'Drag to reorder';

  @override
  String get protectDocumentTitle => 'Protect Document';

  @override
  String get requirePasswordToOpen => 'Require Password To Open Document';

  @override
  String get verifyFieldLabel => 'Verify';

  @override
  String get permissionsHeading => 'Permissions';

  @override
  String get permissionsNote =>
      'Allow the following changes to be made without entering the owner password.';

  @override
  String get permissionPrinting => 'Printing';

  @override
  String get permissionCopying => 'Copying Text or Graphics';

  @override
  String get permissionPageAssembly => 'Inserting, Deleting, or Rotating Pages';

  @override
  String get permissionAnnotations => 'Adding Annotations or Signatures';

  @override
  String get permissionChangingContent => 'Changing the Document';

  @override
  String get permissionFormFilling => 'Filling Existing Form Fields';

  @override
  String get changingContentIncludes =>
      'Changing the document includes annotating and filling in forms, so those are granted with it.';

  @override
  String get ownerPasswordHeading => 'Owner Password';

  @override
  String get removeProtection => 'Remove Protection';

  @override
  String get applyButton => 'Apply';

  @override
  String get passwordsDoNotMatch => 'The passwords do not match';

  @override
  String get passwordCannotBeEmpty => 'Enter a password';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Restrictions need an owner password. Without one, anyone can lift them.';

  @override
  String get signingNeedsChangingContent =>
      'Without “Changing the Document”, this file cannot be signed here again unless the owner password is given.';

  @override
  String get menuProtectDocument => 'Protect Document…';

  @override
  String get protectButtonLabel => 'Protect';

  @override
  String get protectButtonTooltip =>
      'Set this document\'s passwords and permissions';
}
