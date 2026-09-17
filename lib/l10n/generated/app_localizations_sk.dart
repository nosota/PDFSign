// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get openPdf => 'Otvoriť PDF';

  @override
  String get selectPdf => 'Vybrať PDF';

  @override
  String get recentFiles => 'Nedávne súbory';

  @override
  String get removeFromList => 'Odstrániť zo zoznamu';

  @override
  String get openedNow => 'Práve otvorené';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minútami',
      few: 'minútami',
      one: 'minútou',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hodinami',
      few: 'hodinami',
      one: 'hodinou',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String get openedYesterday => 'Otvorené včera';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dňami',
      few: 'dňami',
      one: 'dňom',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String get fileNotFound => 'Súbor sa nenašiel';

  @override
  String get fileAccessDenied => 'Prístup zamietnutý';

  @override
  String get clearRecentFiles => 'Vymazať nedávne súbory';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get confirm => 'Potvrdiť';

  @override
  String get error => 'Chyba';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Súbor';

  @override
  String get menuOpen => 'Otvoriť...';

  @override
  String get menuOpenRecent => 'Otvoriť nedávne';

  @override
  String get menuNoRecentFiles => 'Žiadne nedávne súbory';

  @override
  String get menuClearMenu => 'Vymazať ponuku';

  @override
  String get menuSave => 'Uložiť';

  @override
  String get menuSaveAs => 'Uložiť ako...';

  @override
  String get menuSaveAll => 'Uložiť všetko';

  @override
  String get menuShare => 'Zdieľať...';

  @override
  String get menuCloseWindow => 'Zavrieť okno';

  @override
  String get menuCloseAll => 'Zavrieť všetko';

  @override
  String get menuEdit => 'Upraviť';

  @override
  String get menuDelete => 'Odstrániť';

  @override
  String get menuView => 'Zobrazenie';

  @override
  String goToPagePrompt(int total) {
    return 'Zadajte číslo strany (1–$total):';
  }

  @override
  String get goToPageHint => 'Číslo strany';

  @override
  String get goToPageInvalid => 'Zadajte platné číslo';

  @override
  String goToPageOutOfRange(int total) {
    return 'Strana musí byť medzi 1 a $total';
  }

  @override
  String get menuRotateLeft => 'Otočiť doľava';

  @override
  String get menuRotateRight => 'Otočiť doprava';

  @override
  String get menuCut => 'Vystrihnúť';

  @override
  String get menuCopy => 'Kopírovať';

  @override
  String get menuPaste => 'Vložiť';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Nepridané obrázky: $count — presahujú $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Nepridané obrázky: $count — presahujú $limit pixelov';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Nepridané obrázky: $count';
  }

  @override
  String get clipboardUnavailable => 'Schránka nie je k dispozícii';

  @override
  String get pasteImageFailed => 'Tento obrázok sa nepodarilo pridať';

  @override
  String get menuQuit => 'Ukončiť PDFSign';

  @override
  String get closeAllDialogTitle => 'Uložiť zmeny?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Chcete uložiť zmeny v $count dokumentoch pred zatvorením?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Chcete uložiť zmeny v 1 dokumente pred zatvorením?';

  @override
  String get closeAllDialogSaveAll => 'Uložiť všetko';

  @override
  String get closeAllDialogDontSave => 'Neuložiť';

  @override
  String get closeAllDialogCancel => 'Zrušiť';

  @override
  String get saveFailedDialogTitle => 'Uloženie zlyhalo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nepodarilo sa uložiť $count dokument(ov). Napriek tomu zavrieť?';
  }

  @override
  String get saveFailedDialogClose => 'Napriek tomu zavrieť';

  @override
  String get saveChangesTitle => 'Uložiť zmeny?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Chcete uložiť zmeny v \"$fileName\" pred zatvorením?';
  }

  @override
  String get saveButton => 'Uložiť';

  @override
  String get discardButton => 'Neuložiť';

  @override
  String get documentEdited => 'Upravené';

  @override
  String get documentSaved => 'Uložené';

  @override
  String get menuSettings => 'Nastavenia...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimalizovať';

  @override
  String get menuZoom => 'Zväčšiť';

  @override
  String get menuBringAllToFront => 'Preniesť všetko dopredu';

  @override
  String get settingsTitle => 'Nastavenia';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLanguageSystem => 'Predvolený systémový';

  @override
  String get settingsUnits => 'Jednotky';

  @override
  String get settingsUnitsCentimeters => 'Centimetre';

  @override
  String get settingsUnitsInches => 'Palce';

  @override
  String get settingsSearchLanguages => 'Hľadať jazyky...';

  @override
  String get settingsGeneral => 'Všeobecné';

  @override
  String get addImage => 'Pridať obrázok';

  @override
  String get selectImages => 'Vybrať obrázky';

  @override
  String get zoomFitWidth => 'Prispôsobiť šírke';

  @override
  String get zoomIn => 'Priblížiť';

  @override
  String get zoomOut => 'Oddialiť';

  @override
  String get selectZoomLevel => 'Vybrať úroveň priblíženia';

  @override
  String get goToPage => 'Prejsť na stranu';

  @override
  String get go => 'Prejsť';

  @override
  String get savePdfAs => 'Uložiť PDF ako';

  @override
  String get incorrectPassword => 'Nesprávne heslo';

  @override
  String get saveFailed => 'Uloženie zlyhalo';

  @override
  String savedTo(String path) {
    return 'Uložené do: $path';
  }

  @override
  String get noOriginalPdfStored => 'Žiadne pôvodné PDF nie je uložené';

  @override
  String get waitingForFolderPermission =>
      'Čakanie na povolenie prístupu k priečinku...';

  @override
  String get deleteButtonLabel => 'Odstrániť';

  @override
  String get deleteButtonTooltip => 'Odstrániť vybraný objekt';

  @override
  String get documentProtectedTitle => 'Tento dokument je chránený';

  @override
  String get documentProtectedBody => 'Zadajte heslo, aby ste ho otvorili.';

  @override
  String get passwordFieldLabel => 'Heslo';

  @override
  String get openDocumentButton => 'Otvoriť';

  @override
  String get documentReadOnlyTitle => 'Tento dokument nedovoľuje zmeny';

  @override
  String get documentReadOnlyBody =>
      'Dá sa čítať a tlačiť, ale vlastník nepovolil zmeny. Zadajte heslo vlastníka, aby ste ho mohli upravovať.';

  @override
  String get enterOwnerPassword => 'Zadať heslo vlastníka';

  @override
  String get ownerPasswordFieldLabel => 'Heslo vlastníka';

  @override
  String get menuPrint => 'Tlač…';

  @override
  String get menuPrintCurrentPage => 'Tlač aktuálnej strany';

  @override
  String get printingIsTheOwnersTitle =>
      'Tento dokument smie tlačiť iba vlastník';

  @override
  String get printingNotAllowed => 'Tento dokument nedovoľuje tlač.';

  @override
  String get printingFailed => 'Dokument sa nepodarilo vytlačiť.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Ochranu tohto dokumentu smie zmeniť iba vlastník';

  @override
  String get continueButton => 'Pokračovať';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Chránený dokument sa zobrazuje z pamäte a tento má $size. Otvorenie spotrebuje približne toľko pamäte.';
  }

  @override
  String get shareProtectedNotice =>
      'Zdieľaná kópia si ponecháva heslo dokumentu.';

  @override
  String get unsupportedProtection =>
      'Ochrana tohto dokumentu nie je podporovaná. PDFSign otvára dokumenty chránené heslom, nie certifikátom.';

  @override
  String get menuBringToFront => 'Presunúť celkom dopredu';

  @override
  String get menuBringForward => 'Presunúť dopredu';

  @override
  String get menuSendBackward => 'Presunúť dozadu';

  @override
  String get menuSendToBack => 'Presunúť celkom dozadu';

  @override
  String get zOrderGroupLabel => 'Usporiadať';

  @override
  String get menuUndo => 'Späť';

  @override
  String get menuRedo => 'Znova';

  @override
  String get dragToReorder => 'Potiahnutím zmeníte poradie';

  @override
  String get protectDocumentTitle => 'Ochrana dokumentu';

  @override
  String get requirePasswordToOpen => 'Vyžadovať heslo na otvorenie dokumentu';

  @override
  String get verifyFieldLabel => 'Potvrdenie';

  @override
  String get permissionsHeading => 'Oprávnenia';

  @override
  String get permissionsNote =>
      'Povoliť nasledujúce zmeny bez zadania hesla vlastníka.';

  @override
  String get permissionPrinting => 'Tlač';

  @override
  String get permissionCopying => 'Kopírovanie textu a grafiky';

  @override
  String get permissionPageAssembly => 'Vkladanie, mazanie a otáčanie strán';

  @override
  String get permissionAnnotations => 'Pridávanie poznámok a podpisov';

  @override
  String get permissionChangingContent => 'Zmeny dokumentu';

  @override
  String get permissionFormFilling => 'Vypĺňanie existujúcich polí formulárov';

  @override
  String get changingContentIncludes =>
      'Zmeny dokumentu zahŕňajú poznámky a vypĺňanie formulárov — povoľujú sa spolu s nimi.';

  @override
  String get ownerPasswordHeading => 'Heslo vlastníka';

  @override
  String get removeProtection => 'Odstrániť ochranu';

  @override
  String get applyButton => 'Použiť';

  @override
  String get passwordsDoNotMatch => 'Heslá sa nezhodujú';

  @override
  String get passwordCannotBeEmpty => 'Zadajte heslo';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Obmedzenia vyžadujú heslo vlastníka. Bez neho ich môže zrušiť ktokoľvek.';

  @override
  String get signingNeedsChangingContent =>
      'Bez položky „Zmeny dokumentu“ nebude možné tento súbor tu znova podpísať bez hesla vlastníka.';

  @override
  String get menuProtectDocument => 'Chrániť dokument…';

  @override
  String get protectButtonLabel => 'Ochrana';

  @override
  String get protectButtonTooltip =>
      'Nastaviť heslá a oprávnenia tohto dokumentu';
}
