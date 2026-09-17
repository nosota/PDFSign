// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Basque (`eu`).
class AppLocalizationsEu extends AppLocalizations {
  AppLocalizationsEu([String locale = 'eu']) : super(locale);

  @override
  String get openPdf => 'Ireki PDF';

  @override
  String get selectPdf => 'Hautatu PDF';

  @override
  String get recentFiles => 'Azken fitxategiak';

  @override
  String get removeFromList => 'Kendu zerrendatik';

  @override
  String get openedNow => 'Orain irekita';

  @override
  String openedMinutesAgo(int count) {
    return 'Duela $count minutu irekita';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Duela $count ordu irekita';
  }

  @override
  String get openedYesterday => 'Atzo irekita';

  @override
  String openedDaysAgo(int count) {
    return 'Duela $count egun irekita';
  }

  @override
  String get fileNotFound => 'Ez da fitxategia aurkitu';

  @override
  String get fileAccessDenied => 'Sarbidea ukatua';

  @override
  String get clearRecentFiles => 'Garbitu azken fitxategiak';

  @override
  String get cancel => 'Utzi';

  @override
  String get confirm => 'Berretsi';

  @override
  String get error => 'Errorea';

  @override
  String get ok => 'Ados';

  @override
  String get menuFile => 'Fitxategia';

  @override
  String get menuOpen => 'Ireki...';

  @override
  String get menuOpenRecent => 'Ireki azkenak';

  @override
  String get menuNoRecentFiles => 'Ez dago azken fitxategirik';

  @override
  String get menuClearMenu => 'Garbitu menua';

  @override
  String get menuSave => 'Gorde';

  @override
  String get menuSaveAs => 'Gorde honela...';

  @override
  String get menuSaveAll => 'Gorde dena';

  @override
  String get menuShare => 'Partekatu...';

  @override
  String get menuCloseWindow => 'Itxi leihoa';

  @override
  String get menuCloseAll => 'Itxi dena';

  @override
  String get menuEdit => 'Editatu';

  @override
  String get menuDelete => 'Ezabatu';

  @override
  String get menuView => 'Ikusi';

  @override
  String goToPagePrompt(int total) {
    return 'Idatzi orrialde-zenbakia (1–$total):';
  }

  @override
  String get goToPageHint => 'Orrialde-zenbakia';

  @override
  String get goToPageInvalid => 'Idatzi baliozko zenbaki bat';

  @override
  String goToPageOutOfRange(int total) {
    return 'Orrialdeak 1 eta $total artean egon behar du';
  }

  @override
  String get menuRotateLeft => 'Biratu ezkerrera';

  @override
  String get menuRotateRight => 'Biratu eskuinera';

  @override
  String get menuCut => 'Ebaki';

  @override
  String get menuCopy => 'Kopiatu';

  @override
  String get menuPaste => 'Itsatsi';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Ez dira gehitu: $count irudi $limit baino handiagoak dira';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Ez dira gehitu: $count irudi $limit pixel baino handiagoak dira';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Ez dira gehitu: $count irudi';
  }

  @override
  String get clipboardUnavailable => 'Arbela ez dago erabilgarri';

  @override
  String get pasteImageFailed => 'Ezin izan da irudi hori gehitu';

  @override
  String get menuQuit => 'Irten PDFSign-etik';

  @override
  String get closeAllDialogTitle => 'Aldaketak gorde?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Itxi baino lehen $count dokumentuetako aldaketak gorde nahi dituzu?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Itxi baino lehen dokumentu bateko aldaketak gorde nahi dituzu?';

  @override
  String get closeAllDialogSaveAll => 'Gorde dena';

  @override
  String get closeAllDialogDontSave => 'Ez gorde';

  @override
  String get closeAllDialogCancel => 'Utzi';

  @override
  String get saveFailedDialogTitle => 'Gordetzeak huts egin du';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Ezin izan dira $count dokumentu gorde. Itxi hala ere?';
  }

  @override
  String get saveFailedDialogClose => 'Itxi hala ere';

  @override
  String get saveChangesTitle => 'Aldaketak gorde?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Itxi baino lehen \"$fileName\" fitxategiko aldaketak gorde nahi dituzu?';
  }

  @override
  String get saveButton => 'Gorde';

  @override
  String get discardButton => 'Ez gorde';

  @override
  String get documentEdited => 'Editatua';

  @override
  String get documentSaved => 'Gordeta';

  @override
  String get menuSettings => 'Ezarpenak...';

  @override
  String get menuWindow => 'Leihoa';

  @override
  String get menuMinimize => 'Minimizatu';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Ekarri dena aurrera';

  @override
  String get settingsTitle => 'Ezarpenak';

  @override
  String get settingsLanguage => 'Hizkuntza';

  @override
  String get settingsLanguageSystem => 'Sistemaren lehenetsia';

  @override
  String get settingsUnits => 'Unitateak';

  @override
  String get settingsUnitsCentimeters => 'Zentimetroak';

  @override
  String get settingsUnitsInches => 'Hazbeteak';

  @override
  String get settingsSearchLanguages => 'Bilatu hizkuntzak...';

  @override
  String get settingsGeneral => 'Orokorra';

  @override
  String get addImage => 'Gehitu irudia';

  @override
  String get selectImages => 'Hautatu irudiak';

  @override
  String get zoomFitWidth => 'Egokitu zabaleran';

  @override
  String get zoomIn => 'Handitu';

  @override
  String get zoomOut => 'Txikitu';

  @override
  String get selectZoomLevel => 'Hautatu zoom maila';

  @override
  String get goToPage => 'Joan orrialdera';

  @override
  String get go => 'Joan';

  @override
  String get savePdfAs => 'Gorde PDF honela';

  @override
  String get incorrectPassword => 'Pasahitz okerra';

  @override
  String get saveFailed => 'Gordetzeak huts egin du';

  @override
  String savedTo(String path) {
    return 'Gordeta: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ez dago jatorrizko PDF-ik gordetuta';

  @override
  String get waitingForFolderPermission =>
      'Karpeta sarbide baimena itxaroten...';

  @override
  String get deleteButtonLabel => 'Ezabatu';

  @override
  String get deleteButtonTooltip => 'Ezabatu hautatutako objektua';

  @override
  String get documentProtectedTitle => 'Dokumentu hau babestuta dago';

  @override
  String get documentProtectedBody => 'Idatzi pasahitza irekitzeko.';

  @override
  String get passwordFieldLabel => 'Pasahitza';

  @override
  String get openDocumentButton => 'Ireki';

  @override
  String get documentReadOnlyTitle =>
      'Dokumentu honek ez du aldaketarik onartzen';

  @override
  String get documentReadOnlyBody =>
      'Irakur eta inprima daiteke, baina jabeak ez du aldaketarik baimendu. Idatzi jabearen pasahitza editatzeko.';

  @override
  String get enterOwnerPassword => 'Idatzi jabearen pasahitza';

  @override
  String get ownerPasswordFieldLabel => 'Jabearen pasahitza';

  @override
  String get menuPrint => 'Inprimatu…';

  @override
  String get menuPrintCurrentPage => 'Inprimatu uneko orrialdea';

  @override
  String get printingIsTheOwnersTitle =>
      'Jabeak bakarrik inprima dezake dokumentu hau';

  @override
  String get printingNotAllowed =>
      'Dokumentu honek ez du inprimatzea onartzen.';

  @override
  String get printingFailed => 'Ezin izan da dokumentua inprimatu.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Jabeak bakarrik alda dezake dokumentu honen babesa';

  @override
  String get continueButton => 'Jarraitu';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Babestutako dokumentua memoriatik erakusten da, eta honek $size hartzen ditu. Irekitzeak antzeko memoria erabiliko du.';
  }

  @override
  String get shareProtectedNotice =>
      'Partekatutako kopiak dokumentuaren pasahitza gordetzen du.';

  @override
  String get unsupportedProtection =>
      'Dokumentu honen babesa ez da onartzen. PDFSign-ek pasahitzarekin babestutako dokumentuak irekitzen ditu, ez ziurtagiriarekin babestutakoak.';

  @override
  String get menuBringToFront => 'Ekarri aurrenera';

  @override
  String get menuBringForward => 'Ekarri aurrera';

  @override
  String get menuSendBackward => 'Eraman atzera';

  @override
  String get menuSendToBack => 'Eraman azkenera';

  @override
  String get zOrderGroupLabel => 'Antolatu';

  @override
  String get menuUndo => 'Desegin';

  @override
  String get menuRedo => 'Berregin';

  @override
  String get dragToReorder => 'Arrastatu ordena aldatzeko';

  @override
  String get protectDocumentTitle => 'Babestu dokumentua';

  @override
  String get requirePasswordToOpen => 'Eskatu pasahitza dokumentua irekitzeko';

  @override
  String get verifyFieldLabel => 'Berrespena';

  @override
  String get permissionsHeading => 'Baimenak';

  @override
  String get permissionsNote =>
      'Baimendu ondorengo aldaketak jabearen pasahitza idatzi gabe.';

  @override
  String get permissionPrinting => 'Inprimatzea';

  @override
  String get permissionCopying => 'Testua edo grafikoak kopiatzea';

  @override
  String get permissionPageAssembly =>
      'Orrialdeak txertatzea, ezabatzea eta biratzea';

  @override
  String get permissionAnnotations => 'Oharrak edo sinadurak gehitzea';

  @override
  String get permissionChangingContent => 'Dokumentua aldatzea';

  @override
  String get permissionFormFilling => 'Dauden inprimaki-eremuak betetzea';

  @override
  String get changingContentIncludes =>
      'Dokumentua aldatzeak oharrak eta inprimakiak betetzea barne hartzen ditu — horiek ere harekin batera baimentzen dira.';

  @override
  String get ownerPasswordHeading => 'Jabearen pasahitza';

  @override
  String get removeProtection => 'Kendu babesa';

  @override
  String get applyButton => 'Aplikatu';

  @override
  String get passwordsDoNotMatch => 'Pasahitzak ez datoz bat';

  @override
  String get passwordCannotBeEmpty => 'Idatzi pasahitz bat';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Murrizketek jabearen pasahitza behar dute. Hori gabe, edonork ken ditzake.';

  @override
  String get signingNeedsChangingContent =>
      '«Dokumentua aldatzea» gabe, fitxategi hau ezin izango da hemen berriro sinatu jabearen pasahitzik gabe.';

  @override
  String get menuProtectDocument => 'Babestu dokumentua…';

  @override
  String get protectButtonLabel => 'Babestu';

  @override
  String get protectButtonTooltip =>
      'Ezarri dokumentu honen pasahitzak eta baimenak';
}
