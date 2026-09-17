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
  String get menuSaveAll => 'Spremi sve';

  @override
  String get menuShare => 'Podijeli...';

  @override
  String get menuCloseWindow => 'Zatvori prozor';

  @override
  String get menuCloseAll => 'Zatvori sve';

  @override
  String get menuEdit => 'Uređivanje';

  @override
  String get menuDelete => 'Obriši';

  @override
  String get menuView => 'Prikaz';

  @override
  String goToPagePrompt(int total) {
    return 'Unesite broj stranice (1–$total):';
  }

  @override
  String get goToPageHint => 'Broj stranice';

  @override
  String get goToPageInvalid => 'Unesite valjani broj';

  @override
  String goToPageOutOfRange(int total) {
    return 'Stranica mora biti između 1 i $total';
  }

  @override
  String get menuRotateLeft => 'Zakreni ulijevo';

  @override
  String get menuRotateRight => 'Zakreni udesno';

  @override
  String get menuCut => 'Izreži';

  @override
  String get menuCopy => 'Kopiraj';

  @override
  String get menuPaste => 'Zalijepi';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Nije dodano slika: $count — prelaze $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Nije dodano slika: $count — prelaze $limit piksela';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Nije dodano slika: $count';
  }

  @override
  String get clipboardUnavailable => 'Međuspremnik nije dostupan';

  @override
  String get pasteImageFailed => 'Tu sliku nije bilo moguće dodati';

  @override
  String get menuQuit => 'Zatvori PDFSign';

  @override
  String get closeAllDialogTitle => 'Spremi promjene?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Želite li spremiti promjene u $count dokumenata prije zatvaranja?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Želite li spremiti promjene u 1 dokumentu prije zatvaranja?';

  @override
  String get closeAllDialogSaveAll => 'Spremi sve';

  @override
  String get closeAllDialogDontSave => 'Ne spremi';

  @override
  String get closeAllDialogCancel => 'Odustani';

  @override
  String get saveFailedDialogTitle => 'Spremanje nije uspjelo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Spremanje $count dokumenta nije uspjelo. Svejedno zatvoriti?';
  }

  @override
  String get saveFailedDialogClose => 'Svejedno zatvori';

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
  String get menuWindow => 'Prozor';

  @override
  String get menuMinimize => 'Minimiziraj';

  @override
  String get menuZoom => 'Zumiraj';

  @override
  String get menuBringAllToFront => 'Dovedi sve naprijed';

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
  String get settingsGeneral => 'Opće';

  @override
  String get addImage => 'Dodaj sliku';

  @override
  String get selectImages => 'Odaberi slike';

  @override
  String get zoomFitWidth => 'Prilagodi širini';

  @override
  String get zoomIn => 'Povećaj';

  @override
  String get zoomOut => 'Smanji';

  @override
  String get selectZoomLevel => 'Odaberi razinu zumiranja';

  @override
  String get goToPage => 'Idi na stranicu';

  @override
  String get go => 'Idi';

  @override
  String get savePdfAs => 'Spremi PDF kao';

  @override
  String get incorrectPassword => 'Pogrešna lozinka';

  @override
  String get saveFailed => 'Spremanje nije uspjelo';

  @override
  String savedTo(String path) {
    return 'Spremljeno u: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nema pohranjenog izvornog PDF-a';

  @override
  String get waitingForFolderPermission => 'Čekanje dozvole za pristup mapi...';

  @override
  String get deleteButtonLabel => 'Obriši';

  @override
  String get deleteButtonTooltip => 'Obriši odabrani objekt';

  @override
  String get documentProtectedTitle => 'Ovaj je dokument zaštićen';

  @override
  String get documentProtectedBody => 'Unesite lozinku da biste ga otvorili.';

  @override
  String get passwordFieldLabel => 'Lozinka';

  @override
  String get openDocumentButton => 'Otvori';

  @override
  String get documentReadOnlyTitle => 'Ovaj dokument ne dopušta promjene';

  @override
  String get documentReadOnlyBody =>
      'Može se čitati i ispisivati, ali vlasnik nije dopustio promjene. Unesite vlasnikovu lozinku da biste ga uredili.';

  @override
  String get enterOwnerPassword => 'Unesite vlasnikovu lozinku';

  @override
  String get ownerPasswordFieldLabel => 'Vlasnikova lozinka';

  @override
  String get menuPrint => 'Ispis…';

  @override
  String get menuPrintCurrentPage => 'Ispis trenutne stranice';

  @override
  String get printingIsTheOwnersTitle =>
      'Ovaj dokument može ispisati samo vlasnik';

  @override
  String get printingNotAllowed => 'Ovaj dokument ne dopušta ispis.';

  @override
  String get printingFailed => 'Dokument nije bilo moguće ispisati.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Zaštitu ovog dokumenta može promijeniti samo vlasnik';

  @override
  String get continueButton => 'Nastavi';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Zaštićeni dokument prikazuje se iz memorije, a ovaj zauzima $size. Otvaranje će potrošiti otprilike toliko memorije.';
  }

  @override
  String get shareProtectedNotice =>
      'Podijeljena kopija zadržava lozinku dokumenta.';

  @override
  String get unsupportedProtection =>
      'Zaštita ovog dokumenta nije podržana. PDFSign otvara dokumente zaštićene lozinkom, ali ne i one zaštićene certifikatom.';

  @override
  String get menuBringToFront => 'Postavi skroz naprijed';

  @override
  String get menuBringForward => 'Pomakni naprijed';

  @override
  String get menuSendBackward => 'Pomakni natrag';

  @override
  String get menuSendToBack => 'Postavi skroz natrag';

  @override
  String get zOrderGroupLabel => 'Razmjesti';

  @override
  String get menuUndo => 'Poništi';

  @override
  String get menuRedo => 'Ponovi';

  @override
  String get dragToReorder => 'Povucite da promijenite redoslijed';

  @override
  String get protectDocumentTitle => 'Zaštita dokumenta';

  @override
  String get requirePasswordToOpen => 'Zatraži lozinku za otvaranje dokumenta';

  @override
  String get verifyFieldLabel => 'Potvrda';

  @override
  String get permissionsHeading => 'Dopuštenja';

  @override
  String get permissionsNote =>
      'Dopusti sljedeće promjene bez unosa vlasnikove lozinke.';

  @override
  String get permissionPrinting => 'Ispis';

  @override
  String get permissionCopying => 'Kopiranje teksta ili grafike';

  @override
  String get permissionPageAssembly =>
      'Umetanje, brisanje i zakretanje stranica';

  @override
  String get permissionAnnotations => 'Dodavanje bilježaka i potpisa';

  @override
  String get permissionChangingContent => 'Promjena dokumenta';

  @override
  String get permissionFormFilling => 'Ispunjavanje postojećih polja obrazaca';

  @override
  String get changingContentIncludes =>
      'Promjena dokumenta obuhvaća bilješke i ispunjavanje obrazaca — dopušteni su zajedno s njom.';

  @override
  String get ownerPasswordHeading => 'Vlasnikova lozinka';

  @override
  String get removeProtection => 'Ukloni zaštitu';

  @override
  String get applyButton => 'Primijeni';

  @override
  String get passwordsDoNotMatch => 'Lozinke se ne podudaraju';

  @override
  String get passwordCannotBeEmpty => 'Unesite lozinku';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Ograničenja zahtijevaju vlasnikovu lozinku. Bez nje ih svatko može ukloniti.';

  @override
  String get signingNeedsChangingContent =>
      'Bez stavke „Promjena dokumenta” ovu datoteku ovdje neće biti moguće ponovno potpisati bez vlasnikove lozinke.';

  @override
  String get menuProtectDocument => 'Zaštiti dokument…';

  @override
  String get protectButtonLabel => 'Zaštiti';

  @override
  String get protectButtonTooltip =>
      'Postavite lozinke i dopuštenja ovog dokumenta';
}
