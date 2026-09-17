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
  String get menuView => 'Nézet';

  @override
  String goToPagePrompt(int total) {
    return 'Adja meg az oldalszámot (1–$total):';
  }

  @override
  String get goToPageHint => 'Oldalszám';

  @override
  String get goToPageInvalid => 'Adjon meg érvényes számot';

  @override
  String goToPageOutOfRange(int total) {
    return 'Az oldalnak 1 és $total között kell lennie';
  }

  @override
  String get menuRotateLeft => 'Forgatás balra';

  @override
  String get menuRotateRight => 'Forgatás jobbra';

  @override
  String get menuCut => 'Kivágás';

  @override
  String get menuCopy => 'Másolás';

  @override
  String get menuPaste => 'Beillesztés';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Nem lett hozzáadva $count kép — nagyobbak, mint $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Nem lett hozzáadva $count kép — nagyobbak, mint $limit képpont';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Nem lett hozzáadva $count kép';
  }

  @override
  String get clipboardUnavailable => 'A vágólap nem érhető el';

  @override
  String get pasteImageFailed => 'Ezt a képet nem sikerült hozzáadni';

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
  String get documentProtectedTitle => 'Ez a dokumentum védett';

  @override
  String get documentProtectedBody => 'Adja meg a jelszavát a megnyitáshoz.';

  @override
  String get passwordFieldLabel => 'Jelszó';

  @override
  String get openDocumentButton => 'Megnyitás';

  @override
  String get documentReadOnlyTitle =>
      'Ez a dokumentum nem engedélyez módosítást';

  @override
  String get documentReadOnlyBody =>
      'Olvasható és nyomtatható, de a tulajdonosa nem engedélyezte a módosítását. A szerkesztéshez adja meg a tulajdonosi jelszót.';

  @override
  String get enterOwnerPassword => 'Tulajdonosi jelszó megadása';

  @override
  String get ownerPasswordFieldLabel => 'Tulajdonosi jelszó';

  @override
  String get menuPrint => 'Nyomtatás…';

  @override
  String get menuPrintCurrentPage => 'Az aktuális oldal nyomtatása';

  @override
  String get printingIsTheOwnersTitle =>
      'Ezt a dokumentumot csak a tulajdonos nyomtathatja';

  @override
  String get printingNotAllowed =>
      'Ez a dokumentum nem engedélyezi a nyomtatást.';

  @override
  String get printingFailed => 'A dokumentumot nem sikerült kinyomtatni.';

  @override
  String get protectionIsTheOwnersTitle =>
      'A dokumentum védelmét csak a tulajdonos módosíthatja';

  @override
  String get continueButton => 'Folytatás';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'A védett dokumentum a memóriából jelenik meg, ez pedig $size méretű. A megnyitása körülbelül ennyi memóriát használ.';
  }

  @override
  String get shareProtectedNotice =>
      'A megosztott másolat megőrzi a dokumentum jelszavát.';

  @override
  String get unsupportedProtection =>
      'Ennek a dokumentumnak a védelme nem támogatott. A PDFSign a jelszóval védett dokumentumokat nyitja meg, a tanúsítvánnyal védetteket nem.';

  @override
  String get menuBringToFront => 'Előre hozás';

  @override
  String get menuBringForward => 'Egy réteggel előre';

  @override
  String get menuSendBackward => 'Egy réteggel hátra';

  @override
  String get menuSendToBack => 'Hátra küldés';

  @override
  String get zOrderGroupLabel => 'Elrendezés';

  @override
  String get menuUndo => 'Visszavonás';

  @override
  String get menuRedo => 'Újra';

  @override
  String get dragToReorder => 'Húzza a sorrend módosításához';

  @override
  String get protectDocumentTitle => 'Dokumentum védelme';

  @override
  String get requirePasswordToOpen =>
      'Jelszó kérése a dokumentum megnyitásához';

  @override
  String get verifyFieldLabel => 'Megerősítés';

  @override
  String get permissionsHeading => 'Engedélyek';

  @override
  String get permissionsNote =>
      'A következő módosítások engedélyezése a tulajdonosi jelszó megadása nélkül.';

  @override
  String get permissionPrinting => 'Nyomtatás';

  @override
  String get permissionCopying => 'Szöveg vagy grafika másolása';

  @override
  String get permissionPageAssembly =>
      'Oldalak beszúrása, törlése és forgatása';

  @override
  String get permissionAnnotations => 'Jegyzetek és aláírások hozzáadása';

  @override
  String get permissionChangingContent => 'A dokumentum módosítása';

  @override
  String get permissionFormFilling => 'Meglévő űrlapmezők kitöltése';

  @override
  String get changingContentIncludes =>
      'A dokumentum módosítása magában foglalja a jegyzetelést és az űrlapok kitöltését — ezek vele együtt engedélyezettek.';

  @override
  String get ownerPasswordHeading => 'Tulajdonosi jelszó';

  @override
  String get removeProtection => 'Védelem eltávolítása';

  @override
  String get applyButton => 'Alkalmaz';

  @override
  String get passwordsDoNotMatch => 'A jelszavak nem egyeznek';

  @override
  String get passwordCannotBeEmpty => 'Adjon meg egy jelszót';

  @override
  String get restrictionsNeedOwnerPassword =>
      'A korlátozásokhoz tulajdonosi jelszó szükséges. Enélkül bárki feloldhatja őket.';

  @override
  String get signingNeedsChangingContent =>
      '„A dokumentum módosítása” nélkül ez a fájl itt nem írható alá újra a tulajdonosi jelszó megadása nélkül.';

  @override
  String get menuProtectDocument => 'Dokumentum védelme…';

  @override
  String get protectButtonLabel => 'Védelem';

  @override
  String get protectButtonTooltip =>
      'A dokumentum jelszavainak és engedélyeinek beállítása';
}
