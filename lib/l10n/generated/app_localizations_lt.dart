// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get openPdf => 'Atidaryti PDF';

  @override
  String get selectPdf => 'Pasirinkti PDF';

  @override
  String get recentFiles => 'Naujausi failai';

  @override
  String get removeFromList => 'Pasalinti is saraso';

  @override
  String get openedNow => 'Ka tik atidarytas';

  @override
  String openedMinutesAgo(int count) {
    return 'Atidarytas pries $count min.';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Atidarytas pries $count val.';
  }

  @override
  String get openedYesterday => 'Atidarytas vakar';

  @override
  String openedDaysAgo(int count) {
    return 'Atidarytas pries $count d.';
  }

  @override
  String get fileNotFound => 'Failas nerastas';

  @override
  String get fileAccessDenied => 'Prieiga uzdrausta';

  @override
  String get clearRecentFiles => 'Isvalyti naujausius';

  @override
  String get cancel => 'Atsaukti';

  @override
  String get confirm => 'Patvirtinti';

  @override
  String get error => 'Klaida';

  @override
  String get ok => 'Gerai';

  @override
  String get menuFile => 'Failas';

  @override
  String get menuOpen => 'Atidaryti...';

  @override
  String get menuOpenRecent => 'Atidaryti naujausius';

  @override
  String get menuNoRecentFiles => 'Nera naujausiu failu';

  @override
  String get menuClearMenu => 'Isvalyti meniu';

  @override
  String get menuSave => 'Issaugoti';

  @override
  String get menuSaveAs => 'Issaugoti kaip...';

  @override
  String get menuSaveAll => 'Išsaugoti viską';

  @override
  String get menuShare => 'Bendrinti...';

  @override
  String get menuCloseWindow => 'Uzdaryti langa';

  @override
  String get menuCloseAll => 'Uždaryti visus';

  @override
  String get menuEdit => 'Redaguoti';

  @override
  String get menuDelete => 'Ištrinti';

  @override
  String get menuView => 'Rodinys';

  @override
  String goToPagePrompt(int total) {
    return 'Įveskite puslapio numerį (1–$total):';
  }

  @override
  String get goToPageHint => 'Puslapio numeris';

  @override
  String get goToPageInvalid => 'Įveskite tinkamą skaičių';

  @override
  String goToPageOutOfRange(int total) {
    return 'Puslapis turi būti nuo 1 iki $total';
  }

  @override
  String get menuRotateLeft => 'Pasukti kairėn';

  @override
  String get menuRotateRight => 'Pasukti dešinėn';

  @override
  String get menuCut => 'Iškirpti';

  @override
  String get menuCopy => 'Kopijuoti';

  @override
  String get menuPaste => 'Įklijuoti';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Nepridėta paveikslėlių: $count — viršija $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Nepridėta paveikslėlių: $count — viršija $limit pikselių';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Nepridėta paveikslėlių: $count';
  }

  @override
  String get clipboardUnavailable => 'Iškarpinė nepasiekiama';

  @override
  String get pasteImageFailed => 'Šio paveikslėlio nepavyko pridėti';

  @override
  String get menuQuit => 'Išeiti iš PDFSign';

  @override
  String get closeAllDialogTitle => 'Išsaugoti pakeitimus?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ar norite išsaugoti pakeitimus $count dokumentuose prieš uždarant?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ar norite išsaugoti pakeitimus 1 dokumente prieš uždarant?';

  @override
  String get closeAllDialogSaveAll => 'Išsaugoti visus';

  @override
  String get closeAllDialogDontSave => 'Neišsaugoti';

  @override
  String get closeAllDialogCancel => 'Atšaukti';

  @override
  String get saveFailedDialogTitle => 'Išsaugoti nepavyko';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nepavyko išsaugoti $count dokumentų. Vis tiek uždaryti?';
  }

  @override
  String get saveFailedDialogClose => 'Vis tiek uždaryti';

  @override
  String get saveChangesTitle => 'Issaugoti pakeitimus?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ar norite issaugoti pakeitimus faile \"$fileName\" pries uzdarant?';
  }

  @override
  String get saveButton => 'Issaugoti';

  @override
  String get discardButton => 'Atmesti';

  @override
  String get documentEdited => 'Redaguota';

  @override
  String get documentSaved => 'Issaugota';

  @override
  String get menuSettings => 'Nustatymai...';

  @override
  String get menuWindow => 'Langas';

  @override
  String get menuMinimize => 'Sumažinti';

  @override
  String get menuZoom => 'Mastelis';

  @override
  String get menuBringAllToFront => 'Visus į priekį';

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get settingsLanguage => 'Kalba';

  @override
  String get settingsLanguageSystem => 'Sistemos numatytoji';

  @override
  String get settingsUnits => 'Matavimo vienetai';

  @override
  String get settingsUnitsCentimeters => 'Centimetrai';

  @override
  String get settingsUnitsInches => 'Coliai';

  @override
  String get settingsSearchLanguages => 'Ieškoti kalbų...';

  @override
  String get settingsGeneral => 'Bendra';

  @override
  String get addImage => 'Pridėti vaizdą';

  @override
  String get selectImages => 'Pasirinkti vaizdus';

  @override
  String get zoomFitWidth => 'Pritaikyti pločiui';

  @override
  String get zoomIn => 'Priartinti';

  @override
  String get zoomOut => 'Atitolinti';

  @override
  String get selectZoomLevel => 'Pasirinkti mastelio lygį';

  @override
  String get goToPage => 'Eiti į puslapį';

  @override
  String get go => 'Eiti';

  @override
  String get savePdfAs => 'Išsaugoti PDF kaip';

  @override
  String get incorrectPassword => 'Neteisingas slaptažodis';

  @override
  String get saveFailed => 'Išsaugoti nepavyko';

  @override
  String savedTo(String path) {
    return 'Išsaugota: $path';
  }

  @override
  String get noOriginalPdfStored => 'Originalus PDF neišsaugotas';

  @override
  String get waitingForFolderPermission =>
      'Laukiama aplanko prieigos leidimo...';

  @override
  String get deleteButtonLabel => 'Ištrinti';

  @override
  String get deleteButtonTooltip => 'Ištrinti pasirinktą objektą';

  @override
  String get documentProtectedTitle => 'Šis dokumentas yra apsaugotas';

  @override
  String get documentProtectedBody =>
      'Įveskite slaptažodį, kad jį atvertumėte.';

  @override
  String get passwordFieldLabel => 'Slaptažodis';

  @override
  String get openDocumentButton => 'Atverti';

  @override
  String get documentReadOnlyTitle => 'Šis dokumentas neleidžia keisti';

  @override
  String get documentReadOnlyBody =>
      'Jį galima skaityti ir spausdinti, bet savininkas neleido jo keisti. Įveskite savininko slaptažodį, kad galėtumėte jį redaguoti.';

  @override
  String get enterOwnerPassword => 'Įveskite savininko slaptažodį';

  @override
  String get ownerPasswordFieldLabel => 'Savininko slaptažodis';

  @override
  String get menuPrint => 'Spausdinti…';

  @override
  String get menuPrintCurrentPage => 'Spausdinti esamą puslapį';

  @override
  String get printingIsTheOwnersTitle =>
      'Šį dokumentą spausdinti gali tik savininkas';

  @override
  String get printingNotAllowed => 'Šis dokumentas neleidžia spausdinti.';

  @override
  String get printingFailed => 'Dokumento nepavyko išspausdinti.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Šio dokumento apsaugą keisti gali tik savininkas';

  @override
  String get continueButton => 'Tęsti';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Apsaugotas dokumentas rodomas iš atminties, o šis užima $size. Jį atveriant bus panaudota maždaug tiek pat.';
  }

  @override
  String get shareProtectedNotice =>
      'Bendrinama kopija išsaugo dokumento slaptažodį.';

  @override
  String get unsupportedProtection =>
      'Šio dokumento apsauga nepalaikoma. PDFSign atveria slaptažodžiu apsaugotus dokumentus, o ne apsaugotus liudijimu.';

  @override
  String get menuBringToFront => 'Perkelti į priekį';

  @override
  String get menuBringForward => 'Pastumti pirmyn';

  @override
  String get menuSendBackward => 'Pastumti atgal';

  @override
  String get menuSendToBack => 'Perkelti į galą';

  @override
  String get zOrderGroupLabel => 'Išdėstyti';

  @override
  String get menuUndo => 'Atšaukti';

  @override
  String get menuRedo => 'Grąžinti';

  @override
  String get dragToReorder => 'Vilkite, kad pakeistumėte tvarką';

  @override
  String get protectDocumentTitle => 'Dokumento apsauga';

  @override
  String get requirePasswordToOpen =>
      'Reikalauti slaptažodžio dokumentui atverti';

  @override
  String get verifyFieldLabel => 'Patvirtinimas';

  @override
  String get permissionsHeading => 'Leidimai';

  @override
  String get permissionsNote =>
      'Leisti toliau nurodytus keitimus neįvedus savininko slaptažodžio.';

  @override
  String get permissionPrinting => 'Spausdinimas';

  @override
  String get permissionCopying => 'Teksto ar grafikos kopijavimas';

  @override
  String get permissionPageAssembly =>
      'Puslapių įterpimas, šalinimas ir sukimas';

  @override
  String get permissionAnnotations => 'Anotacijų ir parašų pridėjimas';

  @override
  String get permissionChangingContent => 'Dokumento keitimas';

  @override
  String get permissionFormFilling => 'Esamų formos laukų pildymas';

  @override
  String get changingContentIncludes =>
      'Dokumento keitimas apima anotavimą ir formų pildymą — jie leidžiami kartu su juo.';

  @override
  String get ownerPasswordHeading => 'Savininko slaptažodis';

  @override
  String get removeProtection => 'Pašalinti apsaugą';

  @override
  String get applyButton => 'Taikyti';

  @override
  String get passwordsDoNotMatch => 'Slaptažodžiai nesutampa';

  @override
  String get passwordCannotBeEmpty => 'Įveskite slaptažodį';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Apribojimams reikia savininko slaptažodžio. Be jo juos gali panaikinti bet kas.';

  @override
  String get signingNeedsChangingContent =>
      'Be „Dokumento keitimo“ šio failo čia nebus galima pasirašyti iš naujo be savininko slaptažodžio.';

  @override
  String get menuProtectDocument => 'Apsaugoti dokumentą…';

  @override
  String get protectButtonLabel => 'Apsaugoti';

  @override
  String get protectButtonTooltip =>
      'Nustatykite šio dokumento slaptažodžius ir leidimus';
}
