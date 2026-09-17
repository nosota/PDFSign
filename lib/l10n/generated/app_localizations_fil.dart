// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get openPdf => 'Buksan ang PDF';

  @override
  String get selectPdf => 'Pumili ng PDF';

  @override
  String get recentFiles => 'Kamakailang mga file';

  @override
  String get removeFromList => 'Alisin sa listahan';

  @override
  String get openedNow => 'Kabukas lang';

  @override
  String openedMinutesAgo(int count) {
    return 'Binuksan $count minuto na ang nakalipas';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Binuksan $count oras na ang nakalipas';
  }

  @override
  String get openedYesterday => 'Binuksan kahapon';

  @override
  String openedDaysAgo(int count) {
    return 'Binuksan $count araw na ang nakalipas';
  }

  @override
  String get fileNotFound => 'Hindi nahanap ang file';

  @override
  String get fileAccessDenied => 'Tinanggihan ang access';

  @override
  String get clearRecentFiles => 'I-clear ang mga kamakailang file';

  @override
  String get cancel => 'Kanselahin';

  @override
  String get confirm => 'Kumpirmahin';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Buksan...';

  @override
  String get menuOpenRecent => 'Buksan ang Kamakailang';

  @override
  String get menuNoRecentFiles => 'Walang kamakailang mga file';

  @override
  String get menuClearMenu => 'I-clear ang Menu';

  @override
  String get menuSave => 'I-save';

  @override
  String get menuSaveAs => 'I-save Bilang...';

  @override
  String get menuSaveAll => 'I-save Lahat';

  @override
  String get menuShare => 'Ibahagi...';

  @override
  String get menuCloseWindow => 'Isara ang Window';

  @override
  String get menuCloseAll => 'Isara lahat';

  @override
  String get menuEdit => 'I-edit';

  @override
  String get menuDelete => 'Tanggalin';

  @override
  String get menuView => 'Tingnan';

  @override
  String goToPagePrompt(int total) {
    return 'Ilagay ang numero ng pahina (1–$total):';
  }

  @override
  String get goToPageHint => 'Numero ng pahina';

  @override
  String get goToPageInvalid => 'Maglagay ng wastong numero';

  @override
  String goToPageOutOfRange(int total) {
    return 'Ang pahina ay dapat nasa pagitan ng 1 at $total';
  }

  @override
  String get menuRotateLeft => 'Iikot pakaliwa';

  @override
  String get menuRotateRight => 'Iikot pakanan';

  @override
  String get menuCut => 'Gupitin';

  @override
  String get menuCopy => 'Kopyahin';

  @override
  String get menuPaste => 'I-paste';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Hindi naidagdag: $count larawan ang lumampas sa $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Hindi naidagdag: $count larawan ang lumampas sa $limit pixel';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Hindi naidagdag: $count larawan';
  }

  @override
  String get clipboardUnavailable => 'Hindi magamit ang clipboard';

  @override
  String get pasteImageFailed => 'Hindi naidagdag ang larawang ito';

  @override
  String get menuQuit => 'Lumabas sa PDFSign';

  @override
  String get closeAllDialogTitle => 'I-save ang mga pagbabago?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Gusto mo bang i-save ang mga pagbabago sa $count dokumento bago isara?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Gusto mo bang i-save ang mga pagbabago sa 1 dokumento bago isara?';

  @override
  String get closeAllDialogSaveAll => 'I-save lahat';

  @override
  String get closeAllDialogDontSave => 'Huwag i-save';

  @override
  String get closeAllDialogCancel => 'Kanselahin';

  @override
  String get saveFailedDialogTitle => 'Nabigo ang Pag-save';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nabigong i-save ang $count dokumento. Isara pa rin?';
  }

  @override
  String get saveFailedDialogClose => 'Isara Pa Rin';

  @override
  String get saveChangesTitle => 'I-save ang mga pagbabago?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Gusto mo bang i-save ang mga pagbabago sa \"$fileName\" bago isara?';
  }

  @override
  String get saveButton => 'I-save';

  @override
  String get discardButton => 'Huwag i-save';

  @override
  String get documentEdited => 'Na-edit';

  @override
  String get documentSaved => 'Na-save';

  @override
  String get menuSettings => 'Mga Setting...';

  @override
  String get menuWindow => 'Window';

  @override
  String get menuMinimize => 'I-minimize';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Dalhin Lahat sa Harap';

  @override
  String get settingsTitle => 'Mga Setting';

  @override
  String get settingsLanguage => 'Wika';

  @override
  String get settingsLanguageSystem => 'Default ng System';

  @override
  String get settingsUnits => 'Mga Unit';

  @override
  String get settingsUnitsCentimeters => 'Sentimetro';

  @override
  String get settingsUnitsInches => 'Pulgada';

  @override
  String get settingsSearchLanguages => 'Maghanap ng wika...';

  @override
  String get settingsGeneral => 'Pangkalahatan';

  @override
  String get addImage => 'Magdagdag ng larawan';

  @override
  String get selectImages => 'Pumili ng mga larawan';

  @override
  String get zoomFitWidth => 'Iayon sa lapad';

  @override
  String get zoomIn => 'Palakihin';

  @override
  String get zoomOut => 'Paliitin';

  @override
  String get selectZoomLevel => 'Pumili ng antas ng zoom';

  @override
  String get goToPage => 'Pumunta sa pahina';

  @override
  String get go => 'Pumunta';

  @override
  String get savePdfAs => 'I-save ang PDF bilang';

  @override
  String get incorrectPassword => 'Maling password';

  @override
  String get saveFailed => 'Hindi ma-save';

  @override
  String savedTo(String path) {
    return 'Na-save sa: $path';
  }

  @override
  String get noOriginalPdfStored => 'Walang nakaimbak na orihinal na PDF';

  @override
  String get waitingForFolderPermission =>
      'Naghihintay ng pahintulot sa pag-access sa folder...';

  @override
  String get deleteButtonLabel => 'Tanggalin';

  @override
  String get deleteButtonTooltip => 'Tanggalin ang napiling bagay';

  @override
  String get documentProtectedTitle => 'Protektado ang dokumentong ito';

  @override
  String get documentProtectedBody => 'Ilagay ang password nito upang buksan.';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get openDocumentButton => 'Buksan';

  @override
  String get documentReadOnlyTitle =>
      'Hindi pinapayagan ng dokumentong ito ang mga pagbabago';

  @override
  String get documentReadOnlyBody =>
      'Mababasa at maipi-print ito, ngunit hindi pinayagan ng may-ari ang mga pagbabago. Ilagay ang password ng may-ari upang i-edit ito.';

  @override
  String get enterOwnerPassword => 'Ilagay ang password ng may-ari';

  @override
  String get ownerPasswordFieldLabel => 'Password ng may-ari';

  @override
  String get menuPrint => 'I-print…';

  @override
  String get menuPrintCurrentPage => 'I-print ang kasalukuyang pahina';

  @override
  String get printingIsTheOwnersTitle =>
      'Ang may-ari lamang ang makapagpi-print ng dokumentong ito';

  @override
  String get printingNotAllowed =>
      'Hindi pinapayagan ng dokumentong ito ang pag-print.';

  @override
  String get printingFailed => 'Hindi na-print ang dokumento.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Ang may-ari lamang ang makapagbabago ng proteksiyon ng dokumentong ito';

  @override
  String get continueButton => 'Magpatuloy';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Ipinapakita mula sa memorya ang isang protektadong dokumento, at ang laki nito ay $size. Halos ganoon din karami ang gagamitin sa pagbubukas nito.';
  }

  @override
  String get shareProtectedNotice =>
      'Pinapanatili ng ibinahaging kopya ang password ng dokumento.';

  @override
  String get unsupportedProtection =>
      'Hindi suportado ang proteksiyon ng dokumentong ito. Binubuksan ng PDFSign ang mga dokumentong protektado ng password, hindi ang mga protektado ng sertipiko.';

  @override
  String get menuBringToFront => 'Dalhin sa pinakaharap';

  @override
  String get menuBringForward => 'Dalhin sa harap';

  @override
  String get menuSendBackward => 'Dalhin sa likod';

  @override
  String get menuSendToBack => 'Dalhin sa pinakalikod';

  @override
  String get zOrderGroupLabel => 'Ayusin';

  @override
  String get menuUndo => 'I-undo';

  @override
  String get menuRedo => 'I-redo';

  @override
  String get dragToReorder => 'I-drag upang baguhin ang pagkakasunod-sunod';

  @override
  String get protectDocumentTitle => 'Protektahan ang dokumento';

  @override
  String get requirePasswordToOpen =>
      'Humingi ng password upang buksan ang dokumento';

  @override
  String get verifyFieldLabel => 'Kumpirmasyon';

  @override
  String get permissionsHeading => 'Mga pahintulot';

  @override
  String get permissionsNote =>
      'Payagan ang mga sumusunod na pagbabago nang hindi inilalagay ang password ng may-ari.';

  @override
  String get permissionPrinting => 'Pag-print';

  @override
  String get permissionCopying => 'Pagkopya ng teksto o grapiks';

  @override
  String get permissionPageAssembly =>
      'Pagpasok, pagtanggal at pag-ikot ng mga pahina';

  @override
  String get permissionAnnotations => 'Pagdaragdag ng mga anotasyon o lagda';

  @override
  String get permissionChangingContent => 'Pagbabago ng dokumento';

  @override
  String get permissionFormFilling =>
      'Pagpuno sa mga umiiral na patlang ng form';

  @override
  String get changingContentIncludes =>
      'Kasama sa pagbabago ng dokumento ang pag-anotasyon at pagpuno ng mga form — pinapayagan ang mga ito kasabay nito.';

  @override
  String get ownerPasswordHeading => 'Password ng may-ari';

  @override
  String get removeProtection => 'Alisin ang proteksiyon';

  @override
  String get applyButton => 'Ilapat';

  @override
  String get passwordsDoNotMatch => 'Hindi magkatugma ang mga password';

  @override
  String get passwordCannotBeEmpty => 'Maglagay ng password';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Kailangan ng mga paghihigpit ang password ng may-ari. Kung wala ito, maaaring alisin ng sinuman ang mga ito.';

  @override
  String get signingNeedsChangingContent =>
      'Kung wala ang “Pagbabago ng dokumento”, hindi na muling malalagdaan dito ang file na ito nang walang password ng may-ari.';

  @override
  String get menuProtectDocument => 'Protektahan ang dokumento…';

  @override
  String get protectButtonLabel => 'Protektahan';

  @override
  String get protectButtonTooltip =>
      'Itakda ang mga password at pahintulot ng dokumentong ito';
}
