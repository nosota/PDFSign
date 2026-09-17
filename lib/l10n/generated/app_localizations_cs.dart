// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class AppLocalizationsCs extends AppLocalizations {
  AppLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String get openPdf => 'Otevřít PDF';

  @override
  String get selectPdf => 'Vybrat PDF';

  @override
  String get recentFiles => 'Nedávné soubory';

  @override
  String get removeFromList => 'Odebrat ze seznamu';

  @override
  String get openedNow => 'Právě otevřeno';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutami',
      few: 'minutami',
      one: 'minutou',
    );
    return 'Otevřeno před $count $_temp0';
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
    return 'Otevřeno před $count $_temp0';
  }

  @override
  String get openedYesterday => 'Otevřeno včera';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dny',
      few: 'dny',
      one: 'dnem',
    );
    return 'Otevřeno před $count $_temp0';
  }

  @override
  String get fileNotFound => 'Soubor nenalezen';

  @override
  String get fileAccessDenied => 'Přístup odepřen';

  @override
  String get clearRecentFiles => 'Vymazat nedávné soubory';

  @override
  String get cancel => 'Zrušit';

  @override
  String get confirm => 'Potvrdit';

  @override
  String get error => 'Chyba';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Soubor';

  @override
  String get menuOpen => 'Otevřít...';

  @override
  String get menuOpenRecent => 'Otevřít nedávné';

  @override
  String get menuNoRecentFiles => 'Žádné nedávné soubory';

  @override
  String get menuClearMenu => 'Vymazat nabídku';

  @override
  String get menuSave => 'Uložit';

  @override
  String get menuSaveAs => 'Uložit jako...';

  @override
  String get menuSaveAll => 'Uložit vše';

  @override
  String get menuShare => 'Sdílet...';

  @override
  String get menuCloseWindow => 'Zavřít okno';

  @override
  String get menuCloseAll => 'Zavřít vše';

  @override
  String get menuEdit => 'Úpravy';

  @override
  String get menuDelete => 'Smazat';

  @override
  String get menuView => 'Zobrazení';

  @override
  String goToPagePrompt(int total) {
    return 'Zadejte číslo stránky (1–$total):';
  }

  @override
  String get goToPageHint => 'Číslo stránky';

  @override
  String get goToPageInvalid => 'Zadejte platné číslo';

  @override
  String goToPageOutOfRange(int total) {
    return 'Stránka musí být mezi 1 a $total';
  }

  @override
  String get menuRotateLeft => 'Otočit doleva';

  @override
  String get menuRotateRight => 'Otočit doprava';

  @override
  String get menuCut => 'Vyjmout';

  @override
  String get menuCopy => 'Kopírovat';

  @override
  String get menuPaste => 'Vložit';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Nepřidané obrázky: $count — přesahují $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Nepřidané obrázky: $count — přesahují $limit pixelů';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Nepřidané obrázky: $count';
  }

  @override
  String get clipboardUnavailable => 'Schránka není k dispozici';

  @override
  String get pasteImageFailed => 'Tento obrázek se nepodařilo přidat';

  @override
  String get menuQuit => 'Ukončit PDFSign';

  @override
  String get closeAllDialogTitle => 'Uložit změny?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Chcete uložit změny v $count dokumentech před zavřením?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Chcete uložit změny v 1 dokumentu před zavřením?';

  @override
  String get closeAllDialogSaveAll => 'Uložit vše';

  @override
  String get closeAllDialogDontSave => 'Neukládat';

  @override
  String get closeAllDialogCancel => 'Zrušit';

  @override
  String get saveFailedDialogTitle => 'Uložení se nezdařilo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nepodařilo se uložit $count dokument(ů). Přesto zavřít?';
  }

  @override
  String get saveFailedDialogClose => 'Přesto zavřít';

  @override
  String get saveChangesTitle => 'Uložit změny?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Chcete uložit změny v \"$fileName\" před zavřením?';
  }

  @override
  String get saveButton => 'Uložit';

  @override
  String get discardButton => 'Neukládat';

  @override
  String get documentEdited => 'Upraveno';

  @override
  String get documentSaved => 'Uloženo';

  @override
  String get menuSettings => 'Nastavení...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimalizovat';

  @override
  String get menuZoom => 'Zvětšit';

  @override
  String get menuBringAllToFront => 'Přenést vše dopředu';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLanguageSystem => 'Výchozí systémový';

  @override
  String get settingsUnits => 'Jednotky';

  @override
  String get settingsUnitsCentimeters => 'Centimetry';

  @override
  String get settingsUnitsInches => 'Palce';

  @override
  String get settingsSearchLanguages => 'Hledat jazyky...';

  @override
  String get settingsGeneral => 'Obecné';

  @override
  String get addImage => 'Přidat obrázek';

  @override
  String get selectImages => 'Vybrat obrázky';

  @override
  String get zoomFitWidth => 'Přizpůsobit šířce';

  @override
  String get zoomIn => 'Přiblížit';

  @override
  String get zoomOut => 'Oddálit';

  @override
  String get selectZoomLevel => 'Vybrat úroveň přiblížení';

  @override
  String get goToPage => 'Přejít na stránku';

  @override
  String get go => 'Přejít';

  @override
  String get savePdfAs => 'Uložit PDF jako';

  @override
  String get incorrectPassword => 'Nesprávné heslo';

  @override
  String get saveFailed => 'Uložení selhalo';

  @override
  String savedTo(String path) {
    return 'Uloženo do: $path';
  }

  @override
  String get noOriginalPdfStored => 'Žádné původní PDF není uloženo';

  @override
  String get waitingForFolderPermission =>
      'Čekání na povolení přístupu ke složce...';

  @override
  String get deleteButtonLabel => 'Smazat';

  @override
  String get deleteButtonTooltip => 'Smazat vybraný objekt';

  @override
  String get documentProtectedTitle => 'Tento dokument je chráněný';

  @override
  String get documentProtectedBody => 'Zadejte heslo, abyste jej otevřeli.';

  @override
  String get passwordFieldLabel => 'Heslo';

  @override
  String get openDocumentButton => 'Otevřít';

  @override
  String get documentReadOnlyTitle => 'Tento dokument nedovoluje změny';

  @override
  String get documentReadOnlyBody =>
      'Lze jej číst a tisknout, ale vlastník nepovolil změny. Zadejte heslo vlastníka, abyste jej mohli upravovat.';

  @override
  String get enterOwnerPassword => 'Zadat heslo vlastníka';

  @override
  String get ownerPasswordFieldLabel => 'Heslo vlastníka';

  @override
  String get menuPrint => 'Tisk…';

  @override
  String get menuPrintCurrentPage => 'Tisk aktuální stránky';

  @override
  String get printingIsTheOwnersTitle =>
      'Tento dokument smí tisknout pouze vlastník';

  @override
  String get printingNotAllowed => 'Tento dokument nedovoluje tisk.';

  @override
  String get printingFailed => 'Dokument se nepodařilo vytisknout.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Ochranu tohoto dokumentu smí změnit pouze vlastník';

  @override
  String get continueButton => 'Pokračovat';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Chráněný dokument se zobrazuje z paměti a tento má $size. Otevření spotřebuje přibližně tolik paměti.';
  }

  @override
  String get shareProtectedNotice =>
      'Sdílená kopie si ponechává heslo dokumentu.';

  @override
  String get unsupportedProtection =>
      'Ochrana tohoto dokumentu není podporována. PDFSign otevírá dokumenty chráněné heslem, nikoli certifikátem.';

  @override
  String get menuBringToFront => 'Přenést zcela dopředu';

  @override
  String get menuBringForward => 'Přenést dopředu';

  @override
  String get menuSendBackward => 'Posunout dozadu';

  @override
  String get menuSendToBack => 'Posunout zcela dozadu';

  @override
  String get zOrderGroupLabel => 'Uspořádat';

  @override
  String get menuUndo => 'Zpět';

  @override
  String get menuRedo => 'Znovu';

  @override
  String get dragToReorder => 'Přetažením změníte pořadí';

  @override
  String get protectDocumentTitle => 'Ochrana dokumentu';

  @override
  String get requirePasswordToOpen => 'Vyžadovat heslo pro otevření dokumentu';

  @override
  String get verifyFieldLabel => 'Potvrzení';

  @override
  String get permissionsHeading => 'Oprávnění';

  @override
  String get permissionsNote =>
      'Povolit následující změny bez zadání hesla vlastníka.';

  @override
  String get permissionPrinting => 'Tisk';

  @override
  String get permissionCopying => 'Kopírování textu a grafiky';

  @override
  String get permissionPageAssembly => 'Vkládání, mazání a otáčení stránek';

  @override
  String get permissionAnnotations => 'Přidávání poznámek a podpisů';

  @override
  String get permissionChangingContent => 'Změny dokumentu';

  @override
  String get permissionFormFilling => 'Vyplňování stávajících polí formulářů';

  @override
  String get changingContentIncludes =>
      'Změny dokumentu zahrnují poznámky a vyplňování formulářů — povolují se spolu s nimi.';

  @override
  String get ownerPasswordHeading => 'Heslo vlastníka';

  @override
  String get removeProtection => 'Odebrat ochranu';

  @override
  String get applyButton => 'Použít';

  @override
  String get passwordsDoNotMatch => 'Hesla se neshodují';

  @override
  String get passwordCannotBeEmpty => 'Zadejte heslo';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Omezení vyžadují heslo vlastníka. Bez něj je může kdokoli zrušit.';

  @override
  String get signingNeedsChangingContent =>
      'Bez položky „Změny dokumentu“ nebude možné tento soubor zde znovu podepsat bez hesla vlastníka.';

  @override
  String get menuProtectDocument => 'Chránit dokument…';

  @override
  String get protectButtonLabel => 'Ochrana';

  @override
  String get protectButtonTooltip =>
      'Nastavit hesla a oprávnění tohoto dokumentu';
}
