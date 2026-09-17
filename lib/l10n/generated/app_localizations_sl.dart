// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get openPdf => 'Odpri PDF';

  @override
  String get selectPdf => 'Izberi PDF';

  @override
  String get recentFiles => 'Nedavne datoteke';

  @override
  String get removeFromList => 'Odstrani s seznama';

  @override
  String get openedNow => 'Pravkar odprto';

  @override
  String openedMinutesAgo(int count) {
    return 'Odprto pred $count minutami';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Odprto pred $count urami';
  }

  @override
  String get openedYesterday => 'Odprto vceraj';

  @override
  String openedDaysAgo(int count) {
    return 'Odprto pred $count dnevi';
  }

  @override
  String get fileNotFound => 'Datoteka ni najdena';

  @override
  String get fileAccessDenied => 'Dostop zavrnjen';

  @override
  String get clearRecentFiles => 'Pocisti nedavne datoteke';

  @override
  String get cancel => 'Preklic';

  @override
  String get confirm => 'Potrdi';

  @override
  String get error => 'Napaka';

  @override
  String get ok => 'V redu';

  @override
  String get menuFile => 'Datoteka';

  @override
  String get menuOpen => 'Odpri...';

  @override
  String get menuOpenRecent => 'Odpri nedavne';

  @override
  String get menuNoRecentFiles => 'Ni nedavnih datotek';

  @override
  String get menuClearMenu => 'Pocisti meni';

  @override
  String get menuSave => 'Shrani';

  @override
  String get menuSaveAs => 'Shrani kot...';

  @override
  String get menuSaveAll => 'Shrani vse';

  @override
  String get menuShare => 'Deli...';

  @override
  String get menuCloseWindow => 'Zapri okno';

  @override
  String get menuCloseAll => 'Zapri vse';

  @override
  String get menuEdit => 'Uredi';

  @override
  String get menuDelete => 'Izbriši';

  @override
  String get menuView => 'Pogled';

  @override
  String goToPagePrompt(int total) {
    return 'Vnesite številko strani (1–$total):';
  }

  @override
  String get goToPageHint => 'Številka strani';

  @override
  String get goToPageInvalid => 'Vnesite veljavno število';

  @override
  String goToPageOutOfRange(int total) {
    return 'Stran mora biti med 1 in $total';
  }

  @override
  String get menuRotateLeft => 'Zavrti v levo';

  @override
  String get menuRotateRight => 'Zavrti v desno';

  @override
  String get menuCut => 'Izreži';

  @override
  String get menuCopy => 'Kopiraj';

  @override
  String get menuPaste => 'Prilepi';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Ni dodanih slik: $count — presegajo $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Ni dodanih slik: $count — presegajo $limit slikovnih pik';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Ni dodanih slik: $count';
  }

  @override
  String get clipboardUnavailable => 'Odložišče ni na voljo';

  @override
  String get pasteImageFailed => 'Te slike ni bilo mogoče dodati';

  @override
  String get menuQuit => 'Zapusti PDFSign';

  @override
  String get closeAllDialogTitle => 'Shrani spremembe?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ali želite shraniti spremembe v $count dokumentih pred zaprtjem?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ali želite shraniti spremembe v 1 dokumentu pred zaprtjem?';

  @override
  String get closeAllDialogSaveAll => 'Shrani vse';

  @override
  String get closeAllDialogDontSave => 'Ne shrani';

  @override
  String get closeAllDialogCancel => 'Preklic';

  @override
  String get saveFailedDialogTitle => 'Shranjevanje ni uspelo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Shranjevanje $count dokumenta(ov) ni uspelo. Vseeno zaprem?';
  }

  @override
  String get saveFailedDialogClose => 'Vseeno zapri';

  @override
  String get saveChangesTitle => 'Shrani spremembe?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ali zelite shraniti spremembe v \"$fileName\" pred zaprtjem?';
  }

  @override
  String get saveButton => 'Shrani';

  @override
  String get discardButton => 'Ne shrani';

  @override
  String get documentEdited => 'Urejeno';

  @override
  String get documentSaved => 'Shranjeno';

  @override
  String get menuSettings => 'Nastavitve...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimiraj';

  @override
  String get menuZoom => 'Povečaj';

  @override
  String get menuBringAllToFront => 'Prinesi vse v ospredje';

  @override
  String get settingsTitle => 'Nastavitve';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Sistemska privzeta';

  @override
  String get settingsUnits => 'Enote';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Palci';

  @override
  String get settingsSearchLanguages => 'Iskanje jezikov...';

  @override
  String get settingsGeneral => 'Splošno';

  @override
  String get addImage => 'Dodaj sliko';

  @override
  String get selectImages => 'Izberi slike';

  @override
  String get zoomFitWidth => 'Prilagodi širini';

  @override
  String get zoomIn => 'Povečaj';

  @override
  String get zoomOut => 'Pomanjšaj';

  @override
  String get selectZoomLevel => 'Izberi stopnjo povečave';

  @override
  String get goToPage => 'Pojdi na stran';

  @override
  String get go => 'Pojdi';

  @override
  String get savePdfAs => 'Shrani PDF kot';

  @override
  String get incorrectPassword => 'Napačno geslo';

  @override
  String get saveFailed => 'Shranjevanje ni uspelo';

  @override
  String savedTo(String path) {
    return 'Shranjeno v: $path';
  }

  @override
  String get noOriginalPdfStored => 'Izvirni PDF ni shranjen';

  @override
  String get waitingForFolderPermission =>
      'Čakanje na dovoljenje za dostop do mape...';

  @override
  String get deleteButtonLabel => 'Izbriši';

  @override
  String get deleteButtonTooltip => 'Izbriši izbrani predmet';

  @override
  String get documentProtectedTitle => 'Ta dokument je zaščiten';

  @override
  String get documentProtectedBody => 'Vnesite geslo, da ga odprete.';

  @override
  String get passwordFieldLabel => 'Geslo';

  @override
  String get openDocumentButton => 'Odpri';

  @override
  String get documentReadOnlyTitle => 'Ta dokument ne dovoljuje sprememb';

  @override
  String get documentReadOnlyBody =>
      'Mogoče ga je brati in tiskati, vendar lastnik ni dovolil sprememb. Vnesite lastnikovo geslo, da ga uredite.';

  @override
  String get enterOwnerPassword => 'Vnesite lastnikovo geslo';

  @override
  String get ownerPasswordFieldLabel => 'Lastnikovo geslo';

  @override
  String get menuPrint => 'Natisni…';

  @override
  String get menuPrintCurrentPage => 'Natisni trenutno stran';

  @override
  String get printingIsTheOwnersTitle =>
      'Ta dokument lahko natisne samo lastnik';

  @override
  String get printingNotAllowed => 'Ta dokument ne dovoljuje tiskanja.';

  @override
  String get printingFailed => 'Dokumenta ni bilo mogoče natisniti.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Zaščito tega dokumenta lahko spremeni samo lastnik';

  @override
  String get continueButton => 'Nadaljuj';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Zaščiten dokument se prikaže iz pomnilnika, ta pa obsega $size. Odpiranje bo porabilo približno toliko pomnilnika.';
  }

  @override
  String get shareProtectedNotice => 'Deljena kopija ohrani geslo dokumenta.';

  @override
  String get unsupportedProtection =>
      'Zaščita tega dokumenta ni podprta. PDFSign odpira dokumente, zaščitene z geslom, ne pa s potrdilom.';

  @override
  String get menuBringToFront => 'Postavi najbolj spredaj';

  @override
  String get menuBringForward => 'Postavi naprej';

  @override
  String get menuSendBackward => 'Postavi nazaj';

  @override
  String get menuSendToBack => 'Postavi najbolj zadaj';

  @override
  String get zOrderGroupLabel => 'Razporedi';

  @override
  String get menuUndo => 'Razveljavi';

  @override
  String get menuRedo => 'Ponovi';

  @override
  String get dragToReorder => 'Povlecite, da spremenite vrstni red';

  @override
  String get protectDocumentTitle => 'Zaščita dokumenta';

  @override
  String get requirePasswordToOpen => 'Zahtevaj geslo za odpiranje dokumenta';

  @override
  String get verifyFieldLabel => 'Potrditev';

  @override
  String get permissionsHeading => 'Dovoljenja';

  @override
  String get permissionsNote =>
      'Dovoli naslednje spremembe brez vnosa lastnikovega gesla.';

  @override
  String get permissionPrinting => 'Tiskanje';

  @override
  String get permissionCopying => 'Kopiranje besedila ali grafike';

  @override
  String get permissionPageAssembly =>
      'Vstavljanje, brisanje in vrtenje strani';

  @override
  String get permissionAnnotations => 'Dodajanje pripomb in podpisov';

  @override
  String get permissionChangingContent => 'Spreminjanje dokumenta';

  @override
  String get permissionFormFilling => 'Izpolnjevanje obstoječih polj obrazcev';

  @override
  String get changingContentIncludes =>
      'Spreminjanje dokumenta vključuje pripombe in izpolnjevanje obrazcev — dovoljena sta skupaj z njim.';

  @override
  String get ownerPasswordHeading => 'Lastnikovo geslo';

  @override
  String get removeProtection => 'Odstrani zaščito';

  @override
  String get applyButton => 'Uporabi';

  @override
  String get passwordsDoNotMatch => 'Gesli se ne ujemata';

  @override
  String get passwordCannotBeEmpty => 'Vnesite geslo';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Omejitve zahtevajo lastnikovo geslo. Brez njega jih lahko odstrani kdor koli.';

  @override
  String get signingNeedsChangingContent =>
      'Brez možnosti „Spreminjanje dokumenta“ te datoteke tu ne bo mogoče znova podpisati brez lastnikovega gesla.';

  @override
  String get menuProtectDocument => 'Zaščiti dokument…';

  @override
  String get protectButtonLabel => 'Zaščiti';

  @override
  String get protectButtonTooltip =>
      'Nastavite gesla in dovoljenja tega dokumenta';
}
