// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Esperanto (`eo`).
class AppLocalizationsEo extends AppLocalizations {
  AppLocalizationsEo([String locale = 'eo']) : super(locale);

  @override
  String get openPdf => 'Malfermi PDF';

  @override
  String get selectPdf => 'Elekti PDF';

  @override
  String get recentFiles => 'Lastaj dosieroj';

  @override
  String get removeFromList => 'Forigi el listo';

  @override
  String get openedNow => 'Jxus malfermita';

  @override
  String openedMinutesAgo(int count) {
    return 'Malfermita antaux $count minutoj';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Malfermita antaux $count horoj';
  }

  @override
  String get openedYesterday => 'Malfermita hieraux';

  @override
  String openedDaysAgo(int count) {
    return 'Malfermita antaux $count tagoj';
  }

  @override
  String get fileNotFound => 'Dosiero ne trovita';

  @override
  String get fileAccessDenied => 'Aliro rifuzita';

  @override
  String get clearRecentFiles => 'Forviŝi lastajn dosierojn';

  @override
  String get cancel => 'Nuligi';

  @override
  String get confirm => 'Konfirmi';

  @override
  String get error => 'Eraro';

  @override
  String get ok => 'Bone';

  @override
  String get menuFile => 'Dosiero';

  @override
  String get menuOpen => 'Malfermi...';

  @override
  String get menuOpenRecent => 'Malfermi lastajn';

  @override
  String get menuNoRecentFiles => 'Neniuj lastaj dosieroj';

  @override
  String get menuClearMenu => 'Forviŝi menuon';

  @override
  String get menuSave => 'Konservi';

  @override
  String get menuSaveAs => 'Konservi kiel...';

  @override
  String get menuSaveAll => 'Konservi ĉiujn';

  @override
  String get menuShare => 'Kunhavigi...';

  @override
  String get menuCloseWindow => 'Fermi fenestron';

  @override
  String get menuCloseAll => 'Fermi ĉiujn';

  @override
  String get menuEdit => 'Redakti';

  @override
  String get menuDelete => 'Forigi';

  @override
  String get menuView => 'Vido';

  @override
  String goToPagePrompt(int total) {
    return 'Enigu paĝnumeron (1–$total):';
  }

  @override
  String get goToPageHint => 'Paĝnumero';

  @override
  String get goToPageInvalid => 'Enigu validan numeron';

  @override
  String goToPageOutOfRange(int total) {
    return 'La paĝo devas esti inter 1 kaj $total';
  }

  @override
  String get menuRotateLeft => 'Turni maldekstren';

  @override
  String get menuRotateRight => 'Turni dekstren';

  @override
  String get menuCut => 'Eltondi';

  @override
  String get menuCopy => 'Kopii';

  @override
  String get menuPaste => 'Alglui';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Ne aldonitaj: $count bildoj superas $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Ne aldonitaj: $count bildoj superas $limit rastrumerojn';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Ne aldonitaj: $count bildoj';
  }

  @override
  String get clipboardUnavailable => 'La tondujo ne disponeblas';

  @override
  String get pasteImageFailed => 'Tiun bildon ne eblis aldoni';

  @override
  String get menuQuit => 'Eliri PDFSign';

  @override
  String get closeAllDialogTitle => 'Konservi ŝanĝojn?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ĉu vi volas konservi ŝanĝojn en $count dokumentoj antaŭ fermi?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ĉu vi volas konservi ŝanĝojn en 1 dokumento antaŭ fermi?';

  @override
  String get closeAllDialogSaveAll => 'Konservi ĉiujn';

  @override
  String get closeAllDialogDontSave => 'Ne konservi';

  @override
  String get closeAllDialogCancel => 'Nuligi';

  @override
  String get saveFailedDialogTitle => 'Konservo malsukcesis';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Malsukcesis konservi $count dokumenton(jn). Ĉu fermi tamen?';
  }

  @override
  String get saveFailedDialogClose => 'Fermi tamen';

  @override
  String get saveChangesTitle => 'Konservi sxangxojn?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Cxu vi volas konservi sxangxojn en \"$fileName\" antaux fermi?';
  }

  @override
  String get saveButton => 'Konservi';

  @override
  String get discardButton => 'Ne konservi';

  @override
  String get documentEdited => 'Redaktita';

  @override
  String get documentSaved => 'Konservita';

  @override
  String get menuSettings => 'Agordoj...';

  @override
  String get menuWindow => 'Fenestro';

  @override
  String get menuMinimize => 'Minimumigi';

  @override
  String get menuZoom => 'Zomi';

  @override
  String get menuBringAllToFront => 'Ĉiujn antaŭen';

  @override
  String get settingsTitle => 'Agordoj';

  @override
  String get settingsLanguage => 'Lingvo';

  @override
  String get settingsLanguageSystem => 'Sistema defauxlto';

  @override
  String get settingsUnits => 'Unuoj';

  @override
  String get settingsUnitsCentimeters => 'Centimetroj';

  @override
  String get settingsUnitsInches => 'Coloj';

  @override
  String get settingsSearchLanguages => 'Serĉi lingvojn...';

  @override
  String get settingsGeneral => 'Ĝenerale';

  @override
  String get addImage => 'Aldoni bildon';

  @override
  String get selectImages => 'Elekti bildojn';

  @override
  String get zoomFitWidth => 'Adapti larĝon';

  @override
  String get zoomIn => 'Pligrandigi';

  @override
  String get zoomOut => 'Malpligrandigi';

  @override
  String get selectZoomLevel => 'Elekti zoomnivelon';

  @override
  String get goToPage => 'Iri al paĝo';

  @override
  String get go => 'Iri';

  @override
  String get savePdfAs => 'Konservi PDF kiel';

  @override
  String get incorrectPassword => 'Malĝusta pasvorto';

  @override
  String get saveFailed => 'Konservado fiaskis';

  @override
  String savedTo(String path) {
    return 'Konservita al: $path';
  }

  @override
  String get noOriginalPdfStored => 'Neniu originala PDF konservita';

  @override
  String get waitingForFolderPermission =>
      'Atendante dosierujan alirpermeson...';

  @override
  String get deleteButtonLabel => 'Forigi';

  @override
  String get deleteButtonTooltip => 'Forigi elektitan objekton';

  @override
  String get documentProtectedTitle => 'Ĉi tiu dokumento estas protektita';

  @override
  String get documentProtectedBody => 'Enigu la pasvorton por malfermi ĝin.';

  @override
  String get passwordFieldLabel => 'Pasvorto';

  @override
  String get openDocumentButton => 'Malfermi';

  @override
  String get documentReadOnlyTitle => 'Ĉi tiu dokumento ne permesas ŝanĝojn';

  @override
  String get documentReadOnlyBody =>
      'Ĝin eblas legi kaj presi, sed ĝia posedanto ne permesis ŝanĝojn. Enigu la pasvorton de la posedanto por redakti ĝin.';

  @override
  String get enterOwnerPassword => 'Enigu la pasvorton de la posedanto';

  @override
  String get ownerPasswordFieldLabel => 'Pasvorto de la posedanto';

  @override
  String get menuPrint => 'Presi…';

  @override
  String get menuPrintCurrentPage => 'Presi la nunan paĝon';

  @override
  String get printingIsTheOwnersTitle =>
      'Nur la posedanto rajtas presi ĉi tiun dokumenton';

  @override
  String get printingNotAllowed => 'Ĉi tiu dokumento ne permesas presadon.';

  @override
  String get printingFailed => 'La dokumenton ne eblis presi.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Nur la posedanto rajtas ŝanĝi la protekton de ĉi tiu dokumento';

  @override
  String get continueButton => 'Daŭrigi';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Protektita dokumento estas montrata el la memoro, kaj ĉi tiu okupas $size. Malfermi ĝin uzos proksimume same multe.';
  }

  @override
  String get shareProtectedNotice =>
      'La kunhavigita kopio konservas la pasvorton de la dokumento.';

  @override
  String get unsupportedProtection =>
      'La protekto de ĉi tiu dokumento ne estas subtenata. PDFSign malfermas dokumentojn protektitajn per pasvorto, ne tiujn protektitajn per atestilo.';

  @override
  String get menuBringToFront => 'Meti plej antaŭen';

  @override
  String get menuBringForward => 'Movi antaŭen';

  @override
  String get menuSendBackward => 'Movi malantaŭen';

  @override
  String get menuSendToBack => 'Meti plej malantaŭen';

  @override
  String get zOrderGroupLabel => 'Aranĝi';

  @override
  String get menuUndo => 'Malfari';

  @override
  String get menuRedo => 'Refari';

  @override
  String get dragToReorder => 'Trenu por ŝanĝi la ordon';

  @override
  String get protectDocumentTitle => 'Protekti dokumenton';

  @override
  String get requirePasswordToOpen =>
      'Postuli pasvorton por malfermi la dokumenton';

  @override
  String get verifyFieldLabel => 'Konfirmo';

  @override
  String get permissionsHeading => 'Permesoj';

  @override
  String get permissionsNote =>
      'Permesi la jenajn ŝanĝojn sen enigi la pasvorton de la posedanto.';

  @override
  String get permissionPrinting => 'Presado';

  @override
  String get permissionCopying => 'Kopiado de teksto aŭ grafikaĵoj';

  @override
  String get permissionPageAssembly => 'Enmeto, forigo kaj turnado de paĝoj';

  @override
  String get permissionAnnotations => 'Aldono de notoj aŭ subskriboj';

  @override
  String get permissionChangingContent => 'Ŝanĝado de la dokumento';

  @override
  String get permissionFormFilling => 'Plenigo de ekzistantaj formulaj kampoj';

  @override
  String get changingContentIncludes =>
      'Ŝanĝado de la dokumento inkluzivas notadon kaj plenigon de formularoj — ili estas permesataj kune kun ĝi.';

  @override
  String get ownerPasswordHeading => 'Pasvorto de la posedanto';

  @override
  String get removeProtection => 'Forigi la protekton';

  @override
  String get applyButton => 'Apliki';

  @override
  String get passwordsDoNotMatch => 'La pasvortoj ne kongruas';

  @override
  String get passwordCannotBeEmpty => 'Enigu pasvorton';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Limigoj postulas pasvorton de la posedanto. Sen ĝi iu ajn povas forigi ilin.';

  @override
  String get signingNeedsChangingContent =>
      'Sen „Ŝanĝado de la dokumento“ ĉi tiu dosiero ne plu subskribeblos ĉi tie sen la pasvorto de la posedanto.';

  @override
  String get menuProtectDocument => 'Protekti dokumenton…';

  @override
  String get protectButtonLabel => 'Protekti';

  @override
  String get protectButtonTooltip =>
      'Agordu la pasvortojn kaj permesojn de ĉi tiu dokumento';
}
