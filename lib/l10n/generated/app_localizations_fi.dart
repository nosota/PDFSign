// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get openPdf => 'Avaa PDF';

  @override
  String get selectPdf => 'Valitse PDF';

  @override
  String get recentFiles => 'Viimeisimmät tiedostot';

  @override
  String get removeFromList => 'Poista luettelosta';

  @override
  String get openedNow => 'Juuri avattu';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuuttia',
      one: 'minuutti',
    );
    return 'Avattu $count $_temp0 sitten';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'tuntia',
      one: 'tunti',
    );
    return 'Avattu $count $_temp0 sitten';
  }

  @override
  String get openedYesterday => 'Avattu eilen';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'päivää',
      one: 'päivä',
    );
    return 'Avattu $count $_temp0 sitten';
  }

  @override
  String get fileNotFound => 'Tiedostoa ei löytynyt';

  @override
  String get fileAccessDenied => 'Pääsy estetty';

  @override
  String get clearRecentFiles => 'Tyhjennä viimeisimmät tiedostot';

  @override
  String get cancel => 'Kumoa';

  @override
  String get confirm => 'Vahvista';

  @override
  String get error => 'Virhe';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkisto';

  @override
  String get menuOpen => 'Avaa...';

  @override
  String get menuOpenRecent => 'Avaa viimeisimmät';

  @override
  String get menuNoRecentFiles => 'Ei viimeisimpiä tiedostoja';

  @override
  String get menuClearMenu => 'Tyhjennä valikko';

  @override
  String get menuSave => 'Tallenna';

  @override
  String get menuSaveAs => 'Tallenna nimellä...';

  @override
  String get menuSaveAll => 'Tallenna kaikki';

  @override
  String get menuShare => 'Jaa...';

  @override
  String get menuCloseWindow => 'Sulje ikkuna';

  @override
  String get menuCloseAll => 'Sulje kaikki';

  @override
  String get menuEdit => 'Muokkaa';

  @override
  String get menuDelete => 'Poista';

  @override
  String get menuView => 'Näytä';

  @override
  String goToPagePrompt(int total) {
    return 'Anna sivunumero (1–$total):';
  }

  @override
  String get goToPageHint => 'Sivunumero';

  @override
  String get goToPageInvalid => 'Anna kelvollinen luku';

  @override
  String goToPageOutOfRange(int total) {
    return 'Sivun on oltava välillä 1–$total';
  }

  @override
  String get menuRotateLeft => 'Käännä vasemmalle';

  @override
  String get menuRotateRight => 'Käännä oikealle';

  @override
  String get menuCut => 'Leikkaa';

  @override
  String get menuCopy => 'Kopioi';

  @override
  String get menuPaste => 'Sijoita';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'kuvaa on',
      one: 'kuva on',
    );
    return 'Ei lisätty: $count $_temp0 suurempi kuin $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'kuvaa on',
      one: 'kuva on',
    );
    return 'Ei lisätty: $count $_temp0 suurempi kuin $limit kuvapistettä';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'kuvaa',
      one: 'kuva',
    );
    return 'Ei lisätty: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'Leikepöytä ei ole käytettävissä';

  @override
  String get pasteImageFailed => 'Kuvaa ei voitu lisätä';

  @override
  String get menuQuit => 'Lopeta PDFSign';

  @override
  String get closeAllDialogTitle => 'Tallenna muutokset?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Haluatko tallentaa muutokset $count asiakirjaan ennen sulkemista?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Haluatko tallentaa muutokset 1 asiakirjaan ennen sulkemista?';

  @override
  String get closeAllDialogSaveAll => 'Tallenna kaikki';

  @override
  String get closeAllDialogDontSave => 'Älä tallenna';

  @override
  String get closeAllDialogCancel => 'Kumoa';

  @override
  String get saveFailedDialogTitle => 'Tallennus epäonnistui';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count asiakirjan tallennus epäonnistui. Suljetaanko silti?';
  }

  @override
  String get saveFailedDialogClose => 'Sulje silti';

  @override
  String get saveChangesTitle => 'Tallenna muutokset?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Haluatko tallentaa muutokset tiedostoon \"$fileName\" ennen sulkemista?';
  }

  @override
  String get saveButton => 'Tallenna';

  @override
  String get discardButton => 'Älä tallenna';

  @override
  String get documentEdited => 'Muokattu';

  @override
  String get documentSaved => 'Tallennettu';

  @override
  String get menuSettings => 'Asetukset...';

  @override
  String get menuWindow => 'Ikkuna';

  @override
  String get menuMinimize => 'Pienennä';

  @override
  String get menuZoom => 'Zoomaa';

  @override
  String get menuBringAllToFront => 'Tuo kaikki eteen';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get settingsLanguage => 'Kieli';

  @override
  String get settingsLanguageSystem => 'Järjestelmän oletus';

  @override
  String get settingsUnits => 'Yksiköt';

  @override
  String get settingsUnitsCentimeters => 'Senttimetrit';

  @override
  String get settingsUnitsInches => 'Tuumat';

  @override
  String get settingsSearchLanguages => 'Etsi kieliä...';

  @override
  String get settingsGeneral => 'Yleistä';

  @override
  String get addImage => 'Lisää kuva';

  @override
  String get selectImages => 'Valitse kuvat';

  @override
  String get zoomFitWidth => 'Sovita leveyteen';

  @override
  String get zoomIn => 'Lähennä';

  @override
  String get zoomOut => 'Loitonna';

  @override
  String get selectZoomLevel => 'Valitse zoomaustaso';

  @override
  String get goToPage => 'Siirry sivulle';

  @override
  String get go => 'Siirry';

  @override
  String get savePdfAs => 'Tallenna PDF nimellä';

  @override
  String get incorrectPassword => 'Väärä salasana';

  @override
  String get saveFailed => 'Tallennus epäonnistui';

  @override
  String savedTo(String path) {
    return 'Tallennettu: $path';
  }

  @override
  String get noOriginalPdfStored => 'Alkuperäistä PDF:ää ei tallennettu';

  @override
  String get waitingForFolderPermission =>
      'Odotetaan kansion käyttöoikeutta...';

  @override
  String get deleteButtonLabel => 'Poista';

  @override
  String get deleteButtonTooltip => 'Poista valittu kohde';

  @override
  String get documentProtectedTitle => 'Tämä dokumentti on suojattu';

  @override
  String get documentProtectedBody => 'Avaa se antamalla salasana.';

  @override
  String get passwordFieldLabel => 'Salasana';

  @override
  String get openDocumentButton => 'Avaa';

  @override
  String get documentReadOnlyTitle => 'Tämä dokumentti ei salli muutoksia';

  @override
  String get documentReadOnlyBody =>
      'Sitä voi lukea ja tulostaa, mutta omistaja ei ole sallinut muutoksia. Anna omistajan salasana, jotta voit muokata sitä.';

  @override
  String get enterOwnerPassword => 'Anna omistajan salasana';

  @override
  String get ownerPasswordFieldLabel => 'Omistajan salasana';

  @override
  String get menuPrint => 'Tulosta…';

  @override
  String get menuPrintCurrentPage => 'Tulosta nykyinen sivu';

  @override
  String get printingIsTheOwnersTitle =>
      'Vain omistaja voi tulostaa tämän dokumentin';

  @override
  String get printingNotAllowed => 'Tämä dokumentti ei salli tulostamista.';

  @override
  String get printingFailed => 'Dokumenttia ei voitu tulostaa.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Vain omistaja voi muuttaa tämän dokumentin suojausta';

  @override
  String get continueButton => 'Jatka';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Suojattu dokumentti näytetään muistista, ja tämän koko on $size. Sen avaaminen käyttää suunnilleen saman verran muistia.';
  }

  @override
  String get shareProtectedNotice =>
      'Jaettu kopio säilyttää dokumentin salasanan.';

  @override
  String get unsupportedProtection =>
      'Tämän dokumentin suojausta ei tueta. PDFSign avaa salasanalla suojattuja dokumentteja, ei varmenteella suojattuja.';

  @override
  String get menuBringToFront => 'Siirrä eteen';

  @override
  String get menuBringForward => 'Siirrä eteenpäin';

  @override
  String get menuSendBackward => 'Siirrä taaksepäin';

  @override
  String get menuSendToBack => 'Siirrä taakse';

  @override
  String get zOrderGroupLabel => 'Järjestä';

  @override
  String get menuUndo => 'Kumoa';

  @override
  String get menuRedo => 'Tee uudelleen';

  @override
  String get dragToReorder => 'Muuta järjestystä vetämällä';

  @override
  String get protectDocumentTitle => 'Suojaa dokumentti';

  @override
  String get requirePasswordToOpen => 'Vaadi salasana dokumentin avaamiseen';

  @override
  String get verifyFieldLabel => 'Vahvistus';

  @override
  String get permissionsHeading => 'Käyttöoikeudet';

  @override
  String get permissionsNote =>
      'Salli seuraavat muutokset ilman omistajan salasanaa.';

  @override
  String get permissionPrinting => 'Tulostus';

  @override
  String get permissionCopying => 'Tekstin tai grafiikan kopiointi';

  @override
  String get permissionPageAssembly =>
      'Sivujen lisääminen, poistaminen ja kääntäminen';

  @override
  String get permissionAnnotations =>
      'Merkintöjen ja allekirjoitusten lisääminen';

  @override
  String get permissionChangingContent => 'Dokumentin muuttaminen';

  @override
  String get permissionFormFilling =>
      'Olemassa olevien lomakekenttien täyttäminen';

  @override
  String get changingContentIncludes =>
      'Dokumentin muuttaminen kattaa merkinnät ja lomakkeiden täyttämisen — ne sallitaan sen mukana.';

  @override
  String get ownerPasswordHeading => 'Omistajan salasana';

  @override
  String get removeProtection => 'Poista suojaus';

  @override
  String get applyButton => 'Käytä';

  @override
  String get passwordsDoNotMatch => 'Salasanat eivät täsmää';

  @override
  String get passwordCannotBeEmpty => 'Anna salasana';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Rajoitukset vaativat omistajan salasanan. Ilman sitä kuka tahansa voi poistaa ne.';

  @override
  String get signingNeedsChangingContent =>
      'Ilman kohtaa ”Dokumentin muuttaminen” tätä tiedostoa ei voi allekirjoittaa täällä uudelleen ilman omistajan salasanaa.';

  @override
  String get menuProtectDocument => 'Suojaa dokumentti…';

  @override
  String get protectButtonLabel => 'Suojaa';

  @override
  String get protectButtonTooltip =>
      'Määritä tämän dokumentin salasanat ja käyttöoikeudet';
}
