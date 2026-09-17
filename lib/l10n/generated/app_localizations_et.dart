// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get openPdf => 'Ava PDF';

  @override
  String get selectPdf => 'Vali PDF';

  @override
  String get recentFiles => 'Hiljutised failid';

  @override
  String get removeFromList => 'Eemalda loendist';

  @override
  String get openedNow => 'Asja avatud';

  @override
  String openedMinutesAgo(int count) {
    return 'Avatud $count minutit tagasi';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Avatud $count tundi tagasi';
  }

  @override
  String get openedYesterday => 'Avatud eile';

  @override
  String openedDaysAgo(int count) {
    return 'Avatud $count paeva tagasi';
  }

  @override
  String get fileNotFound => 'Faili ei leitud';

  @override
  String get fileAccessDenied => 'Juurdepaaas keelatud';

  @override
  String get clearRecentFiles => 'Tuehjenda hiljutised failid';

  @override
  String get cancel => 'Tuehista';

  @override
  String get confirm => 'Kinnita';

  @override
  String get error => 'Viga';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fail';

  @override
  String get menuOpen => 'Ava...';

  @override
  String get menuOpenRecent => 'Ava hiljutised';

  @override
  String get menuNoRecentFiles => 'Hiljutisi faile pole';

  @override
  String get menuClearMenu => 'Tuehjenda menyy';

  @override
  String get menuSave => 'Salvesta';

  @override
  String get menuSaveAs => 'Salvesta kui...';

  @override
  String get menuSaveAll => 'Salvesta kõik';

  @override
  String get menuShare => 'Jaga...';

  @override
  String get menuCloseWindow => 'Sulge aken';

  @override
  String get menuCloseAll => 'Sulge kõik';

  @override
  String get menuEdit => 'Redigeeri';

  @override
  String get menuDelete => 'Kustuta';

  @override
  String get menuView => 'Vaade';

  @override
  String goToPagePrompt(int total) {
    return 'Sisestage lehekülje number (1–$total):';
  }

  @override
  String get goToPageHint => 'Lehekülje number';

  @override
  String get goToPageInvalid => 'Sisestage kehtiv arv';

  @override
  String goToPageOutOfRange(int total) {
    return 'Lehekülg peab jääma vahemikku 1 kuni $total';
  }

  @override
  String get menuRotateLeft => 'Pööra vasakule';

  @override
  String get menuRotateRight => 'Pööra paremale';

  @override
  String get menuCut => 'Lõika';

  @override
  String get menuCopy => 'Kopeeri';

  @override
  String get menuPaste => 'Aseta';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Lisamata pilte: $count — suuremad kui $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Lisamata pilte: $count — suuremad kui $limit pikslit';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Lisamata pilte: $count';
  }

  @override
  String get clipboardUnavailable => 'Lõikelaud ei ole saadaval';

  @override
  String get pasteImageFailed => 'Seda pilti ei õnnestunud lisada';

  @override
  String get menuQuit => 'Välju PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvesta muudatused?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Kas soovite salvestada muudatused $count dokumendis enne sulgemist?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Kas soovite salvestada muudatused 1 dokumendis enne sulgemist?';

  @override
  String get closeAllDialogSaveAll => 'Salvesta kõik';

  @override
  String get closeAllDialogDontSave => 'Ära salvesta';

  @override
  String get closeAllDialogCancel => 'Tühista';

  @override
  String get saveFailedDialogTitle => 'Salvestamine ebaõnnestus';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count dokumendi salvestamine ebaõnnestus. Kas sulgeda siiski?';
  }

  @override
  String get saveFailedDialogClose => 'Sulge siiski';

  @override
  String get saveChangesTitle => 'Salvesta muudatused?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Kas soovite salvestada muudatused failis \"$fileName\" enne sulgemist?';
  }

  @override
  String get saveButton => 'Salvesta';

  @override
  String get discardButton => 'Ara salvesta';

  @override
  String get documentEdited => 'Muudetud';

  @override
  String get documentSaved => 'Salvestatud';

  @override
  String get menuSettings => 'Seaded...';

  @override
  String get menuWindow => 'Aken';

  @override
  String get menuMinimize => 'Minimeeri';

  @override
  String get menuZoom => 'Suumi';

  @override
  String get menuBringAllToFront => 'Too kõik ette';

  @override
  String get settingsTitle => 'Seaded';

  @override
  String get settingsLanguage => 'Keel';

  @override
  String get settingsLanguageSystem => 'Systeemi vaikevaartus';

  @override
  String get settingsUnits => 'Uhikud';

  @override
  String get settingsUnitsCentimeters => 'Sentimeetrid';

  @override
  String get settingsUnitsInches => 'Tollid';

  @override
  String get settingsSearchLanguages => 'Otsi keeli...';

  @override
  String get settingsGeneral => 'Üldine';

  @override
  String get addImage => 'Lisa pilt';

  @override
  String get selectImages => 'Vali pildid';

  @override
  String get zoomFitWidth => 'Sobita laiusega';

  @override
  String get zoomIn => 'Suurenda';

  @override
  String get zoomOut => 'Vähenda';

  @override
  String get selectZoomLevel => 'Vali suurenduse tase';

  @override
  String get goToPage => 'Mine leheküljele';

  @override
  String get go => 'Mine';

  @override
  String get savePdfAs => 'Salvesta PDF kui';

  @override
  String get incorrectPassword => 'Vale parool';

  @override
  String get saveFailed => 'Salvestamine ebaõnnestus';

  @override
  String savedTo(String path) {
    return 'Salvestatud: $path';
  }

  @override
  String get noOriginalPdfStored => 'Algset PDF-i pole salvestatud';

  @override
  String get waitingForFolderPermission => 'Kausta juurdepääsu loa ootamine...';

  @override
  String get deleteButtonLabel => 'Kustuta';

  @override
  String get deleteButtonTooltip => 'Kustuta valitud objekt';

  @override
  String get documentProtectedTitle => 'See dokument on kaitstud';

  @override
  String get documentProtectedBody => 'Selle avamiseks sisestage parool.';

  @override
  String get passwordFieldLabel => 'Parool';

  @override
  String get openDocumentButton => 'Ava';

  @override
  String get documentReadOnlyTitle => 'See dokument ei luba muudatusi';

  @override
  String get documentReadOnlyBody =>
      'Seda saab lugeda ja printida, kuid omanik ei ole muudatusi lubanud. Selle muutmiseks sisestage omaniku parool.';

  @override
  String get enterOwnerPassword => 'Sisestage omaniku parool';

  @override
  String get ownerPasswordFieldLabel => 'Omaniku parool';

  @override
  String get menuPrint => 'Prindi…';

  @override
  String get menuPrintCurrentPage => 'Prindi praegune lehekülg';

  @override
  String get printingIsTheOwnersTitle =>
      'Seda dokumenti tohib printida ainult omanik';

  @override
  String get printingNotAllowed => 'See dokument ei luba printimist.';

  @override
  String get printingFailed => 'Dokumenti ei õnnestunud printida.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Selle dokumendi kaitset tohib muuta ainult omanik';

  @override
  String get continueButton => 'Jätka';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Kaitstud dokumenti kuvatakse mälust ja selle maht on $size. Avamine kasutab umbes sama palju mälu.';
  }

  @override
  String get shareProtectedNotice =>
      'Jagatud koopia säilitab dokumendi parooli.';

  @override
  String get unsupportedProtection =>
      'Selle dokumendi kaitse ei ole toetatud. PDFSign avab parooliga kaitstud dokumente, mitte sertifikaadiga kaitstuid.';

  @override
  String get menuBringToFront => 'Too kõige ette';

  @override
  String get menuBringForward => 'Too ettepoole';

  @override
  String get menuSendBackward => 'Vii tahapoole';

  @override
  String get menuSendToBack => 'Vii kõige taha';

  @override
  String get zOrderGroupLabel => 'Korralda';

  @override
  String get menuUndo => 'Võta tagasi';

  @override
  String get menuRedo => 'Tee uuesti';

  @override
  String get dragToReorder => 'Järjestuse muutmiseks lohistage';

  @override
  String get protectDocumentTitle => 'Dokumendi kaitsmine';

  @override
  String get requirePasswordToOpen => 'Nõua dokumendi avamiseks parooli';

  @override
  String get verifyFieldLabel => 'Kinnitus';

  @override
  String get permissionsHeading => 'Õigused';

  @override
  String get permissionsNote =>
      'Luba järgmised muudatused ilma omaniku parooli sisestamata.';

  @override
  String get permissionPrinting => 'Printimine';

  @override
  String get permissionCopying => 'Teksti või graafika kopeerimine';

  @override
  String get permissionPageAssembly =>
      'Lehekülgede lisamine, kustutamine ja pööramine';

  @override
  String get permissionAnnotations => 'Märkuste ja allkirjade lisamine';

  @override
  String get permissionChangingContent => 'Dokumendi muutmine';

  @override
  String get permissionFormFilling => 'Olemasolevate vormiväljade täitmine';

  @override
  String get changingContentIncludes =>
      'Dokumendi muutmine hõlmab märkusi ja vormide täitmist — need lubatakse koos sellega.';

  @override
  String get ownerPasswordHeading => 'Omaniku parool';

  @override
  String get removeProtection => 'Eemalda kaitse';

  @override
  String get applyButton => 'Rakenda';

  @override
  String get passwordsDoNotMatch => 'Paroolid ei kattu';

  @override
  String get passwordCannotBeEmpty => 'Sisestage parool';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Piirangud nõuavad omaniku parooli. Ilma selleta võib igaüks need eemaldada.';

  @override
  String get signingNeedsChangingContent =>
      'Ilma valikuta „Dokumendi muutmine“ ei saa seda faili siin uuesti allkirjastada ilma omaniku paroolita.';

  @override
  String get menuProtectDocument => 'Kaitse dokumenti…';

  @override
  String get protectButtonLabel => 'Kaitse';

  @override
  String get protectButtonTooltip =>
      'Määrake selle dokumendi paroolid ja õigused';
}
