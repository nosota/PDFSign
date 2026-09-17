// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class AppLocalizationsHu extends AppLocalizations {
  AppLocalizationsHu([String locale = 'hu']) : super(locale);

  @override
  String get openPdf => 'PDF megnyitása';

  @override
  String get selectPdf => 'PDF kiválasztása';

  @override
  String get recentFiles => 'Legutóbbi fájlok';

  @override
  String get removeFromList => 'Eltávolítás a listáról';

  @override
  String get openedNow => 'Most megnyitva';

  @override
  String openedMinutesAgo(int count) {
    return '$count perccel ezelőtt megnyitva';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count órával ezelőtt megnyitva';
  }

  @override
  String get openedYesterday => 'Tegnap megnyitva';

  @override
  String openedDaysAgo(int count) {
    return '$count nappal ezelőtt megnyitva';
  }

  @override
  String get fileNotFound => 'A fájl nem található';

  @override
  String get fileAccessDenied => 'Hozzáférés megtagadva';

  @override
  String get clearRecentFiles => 'Legutóbbi fájlok törlése';

  @override
  String get cancel => 'Mégse';

  @override
  String get confirm => 'Megerősítés';

  @override
  String get error => 'Hiba';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fájl';

  @override
  String get menuOpen => 'Megnyitás...';

  @override
  String get menuOpenRecent => 'Legutóbbiak megnyitása';

  @override
  String get menuNoRecentFiles => 'Nincsenek legutóbbi fájlok';

  @override
  String get menuClearMenu => 'Menü törlése';

  @override
  String get menuSave => 'Mentés';

  @override
  String get menuSaveAs => 'Mentés másként...';

  @override
  String get menuSaveAll => 'Összes mentése';

  @override
  String get menuShare => 'Megosztás...';

  @override
  String get menuCloseWindow => 'Ablak bezárása';

  @override
  String get menuCloseAll => 'Összes bezárása';

  @override
  String get menuEdit => 'Szerkesztés';

  @override
  String get menuDelete => 'Törlés';

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
  String get menuQuit => 'PDFSign bezárása';

  @override
  String get closeAllDialogTitle => 'Változások mentése?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Szeretné menteni a változtatásokat $count dokumentumban bezárás előtt?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Szeretné menteni a változtatásokat 1 dokumentumban bezárás előtt?';

  @override
  String get closeAllDialogSaveAll => 'Összes mentése';

  @override
  String get closeAllDialogDontSave => 'Ne mentse';

  @override
  String get closeAllDialogCancel => 'Mégse';

  @override
  String get saveFailedDialogTitle => 'Mentés sikertelen';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count dokumentum mentése sikertelen. Mégis bezárja?';
  }

  @override
  String get saveFailedDialogClose => 'Mégis bezár';

  @override
  String get saveChangesTitle => 'Változások mentése?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Szeretné menteni a \"$fileName\" fájlban végzett változtatásokat bezárás előtt?';
  }

  @override
  String get saveButton => 'Mentés';

  @override
  String get discardButton => 'Elvetés';

  @override
  String get documentEdited => 'Szerkesztve';

  @override
  String get documentSaved => 'Mentve';

  @override
  String get menuSettings => 'Beállítások...';

  @override
  String get menuWindow => 'Ablak';

  @override
  String get menuMinimize => 'Kis méret';

  @override
  String get menuZoom => 'Nagyítás';

  @override
  String get menuBringAllToFront => 'Összes előtérbe hozása';

  @override
  String get settingsTitle => 'Beállítások';

  @override
  String get settingsLanguage => 'Nyelv';

  @override
  String get settingsLanguageSystem => 'Rendszer alapértelmezett';

  @override
  String get settingsUnits => 'Mértékegységek';

  @override
  String get settingsUnitsCentimeters => 'Centiméter';

  @override
  String get settingsUnitsInches => 'Hüvelyk';

  @override
  String get settingsSearchLanguages => 'Nyelvek keresése...';

  @override
  String get settingsGeneral => 'Általános';

  @override
  String get addImage => 'Kép hozzáadása';

  @override
  String get selectImages => 'Képek kiválasztása';

  @override
  String get zoomFitWidth => 'Szélesség illesztése';

  @override
  String get zoomIn => 'Nagyítás';

  @override
  String get zoomOut => 'Kicsinyítés';

  @override
  String get selectZoomLevel => 'Nagyítási szint kiválasztása';

  @override
  String get goToPage => 'Ugrás oldalra';

  @override
  String get go => 'Ugrás';

  @override
  String get savePdfAs => 'PDF mentése másként';

  @override
  String get incorrectPassword => 'Helytelen jelszó';

  @override
  String get saveFailed => 'Mentés sikertelen';

  @override
  String savedTo(String path) {
    return 'Mentve ide: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nincs eredeti PDF tárolva';

  @override
  String get waitingForFolderPermission =>
      'Várakozás a mappa hozzáférési engedélyére...';

  @override
  String get deleteButtonLabel => 'Törlés';

  @override
  String get deleteButtonTooltip => 'Kijelölt objektum törlése';

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
}
