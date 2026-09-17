// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get openPdf => 'Hap PDF';

  @override
  String get selectPdf => 'Zgjidh PDF';

  @override
  String get recentFiles => 'Skedaret e fundit';

  @override
  String get removeFromList => 'Hiq nga lista';

  @override
  String get openedNow => 'Sapo u hap';

  @override
  String openedMinutesAgo(int count) {
    return 'U hap $count minuta me pare';
  }

  @override
  String openedHoursAgo(int count) {
    return 'U hap $count ore me pare';
  }

  @override
  String get openedYesterday => 'U hap dje';

  @override
  String openedDaysAgo(int count) {
    return 'U hap $count dite me pare';
  }

  @override
  String get fileNotFound => 'Skedari nuk u gjet';

  @override
  String get fileAccessDenied => 'Qasja e refuzuar';

  @override
  String get clearRecentFiles => 'Pastro skedaret e fundit';

  @override
  String get cancel => 'Anullo';

  @override
  String get confirm => 'Konfirmo';

  @override
  String get error => 'Gabim';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Skedar';

  @override
  String get menuOpen => 'Hap...';

  @override
  String get menuOpenRecent => 'Hap te fundit';

  @override
  String get menuNoRecentFiles => 'Nuk ka skedare te fundit';

  @override
  String get menuClearMenu => 'Pastro menune';

  @override
  String get menuSave => 'Ruaj';

  @override
  String get menuSaveAs => 'Ruaj si...';

  @override
  String get menuSaveAll => 'Ruaj të gjitha';

  @override
  String get menuShare => 'Ndaj...';

  @override
  String get menuCloseWindow => 'Mbyll dritaren';

  @override
  String get menuCloseAll => 'Mbyll të gjitha';

  @override
  String get menuEdit => 'Ndrysho';

  @override
  String get menuDelete => 'Fshi';

  @override
  String get menuView => 'Pamja';

  @override
  String goToPagePrompt(int total) {
    return 'Shkruani numrin e faqes (1–$total):';
  }

  @override
  String get goToPageHint => 'Numri i faqes';

  @override
  String get goToPageInvalid => 'Shkruani një numër të vlefshëm';

  @override
  String goToPageOutOfRange(int total) {
    return 'Faqja duhet të jetë midis 1 dhe $total';
  }

  @override
  String get menuRotateLeft => 'Rrotullo majtas';

  @override
  String get menuRotateRight => 'Rrotullo djathtas';

  @override
  String get menuCut => 'Pri';

  @override
  String get menuCopy => 'Kopjo';

  @override
  String get menuPaste => 'Ngjit';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Nuk u shtuan imazhe: $count — tejkalojnë $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Nuk u shtuan imazhe: $count — tejkalojnë $limit piksel';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Nuk u shtuan imazhe: $count';
  }

  @override
  String get clipboardUnavailable =>
      'Kujtesa e fragmenteve nuk është e disponueshme';

  @override
  String get pasteImageFailed => 'Ky imazh nuk mund të shtohej';

  @override
  String get menuQuit => 'Dil nga PDFSign';

  @override
  String get closeAllDialogTitle => 'Ruaj ndryshimet?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Dëshironi të ruani ndryshimet në $count dokumente para se të mbyllni?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Dëshironi të ruani ndryshimet në 1 dokument para se të mbyllni?';

  @override
  String get closeAllDialogSaveAll => 'Ruaj të gjitha';

  @override
  String get closeAllDialogDontSave => 'Mos ruaj';

  @override
  String get closeAllDialogCancel => 'Anulo';

  @override
  String get saveFailedDialogTitle => 'Ruajtja dështoi';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Dështoi ruajtja e $count dokumenteve. Mbyll gjithsesi?';
  }

  @override
  String get saveFailedDialogClose => 'Mbyll Gjithsesi';

  @override
  String get saveChangesTitle => 'Ruaj ndryshimet?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deshironi te ruani ndryshimet ne \"$fileName\" para se te mbyllni?';
  }

  @override
  String get saveButton => 'Ruaj';

  @override
  String get discardButton => 'Mos ruaj';

  @override
  String get documentEdited => 'I redaktuar';

  @override
  String get documentSaved => 'U ruajt';

  @override
  String get menuSettings => 'Cilesimet...';

  @override
  String get menuWindow => 'Dritare';

  @override
  String get menuMinimize => 'Minimizo';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Sill Të Gjitha Para';

  @override
  String get settingsTitle => 'Cilesimet';

  @override
  String get settingsLanguage => 'Gjuha';

  @override
  String get settingsLanguageSystem => 'Parazgjedhja e sistemit';

  @override
  String get settingsUnits => 'Njesite';

  @override
  String get settingsUnitsCentimeters => 'Centimetra';

  @override
  String get settingsUnitsInches => 'Inca';

  @override
  String get settingsSearchLanguages => 'Kërko gjuhët...';

  @override
  String get settingsGeneral => 'Të përgjithshme';

  @override
  String get addImage => 'Shto imazh';

  @override
  String get selectImages => 'Zgjidh imazhe';

  @override
  String get zoomFitWidth => 'Përshtat gjerësinë';

  @override
  String get zoomIn => 'Zmadho';

  @override
  String get zoomOut => 'Zvogëlo';

  @override
  String get selectZoomLevel => 'Zgjidh nivelin e zmadhimit';

  @override
  String get goToPage => 'Shko te faqja';

  @override
  String get go => 'Shko';

  @override
  String get savePdfAs => 'Ruaj PDF si';

  @override
  String get incorrectPassword => 'Fjalëkalim i gabuar';

  @override
  String get saveFailed => 'Ruajtja dështoi';

  @override
  String savedTo(String path) {
    return 'U ruajt në: $path';
  }

  @override
  String get noOriginalPdfStored => 'Asnjë PDF origjinal i ruajtur';

  @override
  String get waitingForFolderPermission =>
      'Duke pritur lejen e qasjes në dosje...';

  @override
  String get deleteButtonLabel => 'Fshi';

  @override
  String get deleteButtonTooltip => 'Fshi objektin e zgjedhur';

  @override
  String get documentProtectedTitle => 'Ky dokument është i mbrojtur';

  @override
  String get documentProtectedBody => 'Shkruani fjalëkalimin për ta hapur.';

  @override
  String get passwordFieldLabel => 'Fjalëkalimi';

  @override
  String get openDocumentButton => 'Hap';

  @override
  String get documentReadOnlyTitle => 'Ky dokument nuk lejon ndryshime';

  @override
  String get documentReadOnlyBody =>
      'Mund të lexohet dhe të printohet, por pronari nuk ka lejuar ndryshime. Shkruani fjalëkalimin e pronarit për ta redaktuar.';

  @override
  String get enterOwnerPassword => 'Shkruani fjalëkalimin e pronarit';

  @override
  String get ownerPasswordFieldLabel => 'Fjalëkalimi i pronarit';

  @override
  String get menuPrint => 'Printo…';

  @override
  String get menuPrintCurrentPage => 'Printo faqen aktuale';

  @override
  String get printingIsTheOwnersTitle =>
      'Vetëm pronari mund ta printojë këtë dokument';

  @override
  String get printingNotAllowed => 'Ky dokument nuk lejon printimin.';

  @override
  String get printingFailed => 'Dokumenti nuk mund të printohej.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Vetëm pronari mund të ndryshojë mbrojtjen e këtij dokumenti';

  @override
  String get continueButton => 'Vazhdo';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Një dokument i mbrojtur shfaqet nga memoria dhe ky zë $size. Hapja e tij do të përdorë përafërsisht po aq.';
  }

  @override
  String get shareProtectedNotice =>
      'Kopja e ndarë ruan fjalëkalimin e dokumentit.';

  @override
  String get unsupportedProtection =>
      'Mbrojtja e këtij dokumenti nuk mbështetet. PDFSign hap dokumente të mbrojtura me fjalëkalim, jo ato të mbrojtura me certifikatë.';

  @override
  String get menuBringToFront => 'Sill përpara të gjithave';

  @override
  String get menuBringForward => 'Sill përpara';

  @override
  String get menuSendBackward => 'Dërgo prapa';

  @override
  String get menuSendToBack => 'Dërgo prapa të gjithave';

  @override
  String get zOrderGroupLabel => 'Rendit';

  @override
  String get menuUndo => 'Zhbëj';

  @override
  String get menuRedo => 'Ribëj';

  @override
  String get dragToReorder => 'Tërhiqni për të ndryshuar radhën';

  @override
  String get protectDocumentTitle => 'Mbrojtja e dokumentit';

  @override
  String get requirePasswordToOpen =>
      'Kërko fjalëkalim për hapjen e dokumentit';

  @override
  String get verifyFieldLabel => 'Konfirmimi';

  @override
  String get permissionsHeading => 'Lejet';

  @override
  String get permissionsNote =>
      'Lejo ndryshimet e mëposhtme pa shkruar fjalëkalimin e pronarit.';

  @override
  String get permissionPrinting => 'Printimi';

  @override
  String get permissionCopying => 'Kopjimi i tekstit ose i grafikës';

  @override
  String get permissionPageAssembly => 'Futja, fshirja dhe rrotullimi i faqeve';

  @override
  String get permissionAnnotations => 'Shtimi i shënimeve dhe i nënshkrimeve';

  @override
  String get permissionChangingContent => 'Ndryshimi i dokumentit';

  @override
  String get permissionFormFilling =>
      'Plotësimi i fushave ekzistuese të formularëve';

  @override
  String get changingContentIncludes =>
      'Ndryshimi i dokumentit përfshin shënimet dhe plotësimin e formularëve — ato lejohen bashkë me të.';

  @override
  String get ownerPasswordHeading => 'Fjalëkalimi i pronarit';

  @override
  String get removeProtection => 'Hiq mbrojtjen';

  @override
  String get applyButton => 'Zbato';

  @override
  String get passwordsDoNotMatch => 'Fjalëkalimet nuk përputhen';

  @override
  String get passwordCannotBeEmpty => 'Shkruani një fjalëkalim';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Kufizimet kërkojnë një fjalëkalim pronari. Pa të, kushdo mund t’i heqë.';

  @override
  String get signingNeedsChangingContent =>
      'Pa „Ndryshimin e dokumentit”, ky skedar nuk do të mund të nënshkruhet përsëri këtu pa fjalëkalimin e pronarit.';

  @override
  String get menuProtectDocument => 'Mbro dokumentin…';

  @override
  String get protectButtonLabel => 'Mbro';

  @override
  String get protectButtonTooltip =>
      'Cakto fjalëkalimet dhe lejet e këtij dokumenti';
}
