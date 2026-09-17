// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Latvian (`lv`).
class AppLocalizationsLv extends AppLocalizations {
  AppLocalizationsLv([String locale = 'lv']) : super(locale);

  @override
  String get openPdf => 'Avert PDF';

  @override
  String get selectPdf => 'Izvelieties PDF';

  @override
  String get recentFiles => 'Nesenie faili';

  @override
  String get removeFromList => 'Nonemt no saraksta';

  @override
  String get openedNow => 'Tikko atverts';

  @override
  String openedMinutesAgo(int count) {
    return 'Atverts pirms $count minutem';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Atverts pirms $count stundam';
  }

  @override
  String get openedYesterday => 'Atverts vakar';

  @override
  String openedDaysAgo(int count) {
    return 'Atverts pirms $count dienam';
  }

  @override
  String get fileNotFound => 'Fails nav atrasts';

  @override
  String get fileAccessDenied => 'Pieklave liegta';

  @override
  String get clearRecentFiles => 'Notiret nesenos failus';

  @override
  String get cancel => 'Atcelt';

  @override
  String get confirm => 'Apstiprinat';

  @override
  String get error => 'Kluda';

  @override
  String get ok => 'Labi';

  @override
  String get menuFile => 'Fails';

  @override
  String get menuOpen => 'Avert...';

  @override
  String get menuOpenRecent => 'Avert nesenos';

  @override
  String get menuNoRecentFiles => 'Nav neseno failu';

  @override
  String get menuClearMenu => 'Notiret izvēlni';

  @override
  String get menuSave => 'Saglabat';

  @override
  String get menuSaveAs => 'Saglabat ka...';

  @override
  String get menuSaveAll => 'Saglabāt visu';

  @override
  String get menuShare => 'Dalieties...';

  @override
  String get menuCloseWindow => 'Aizvert logu';

  @override
  String get menuCloseAll => 'Aizvērt visu';

  @override
  String get menuEdit => 'Rediģēt';

  @override
  String get menuDelete => 'Dzēst';

  @override
  String get menuView => 'Skats';

  @override
  String goToPagePrompt(int total) {
    return 'Ievadiet lappuses numuru (1–$total):';
  }

  @override
  String get goToPageHint => 'Lappuses numurs';

  @override
  String get goToPageInvalid => 'Ievadiet derīgu skaitli';

  @override
  String goToPageOutOfRange(int total) {
    return 'Lappusei jābūt no 1 līdz $total';
  }

  @override
  String get menuRotateLeft => 'Pagriezt pa kreisi';

  @override
  String get menuRotateRight => 'Pagriezt pa labi';

  @override
  String get menuCut => 'Izgriezt';

  @override
  String get menuCopy => 'Kopēt';

  @override
  String get menuPaste => 'Ielīmēt';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Nav pievienoti attēli: $count — pārsniedz $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Nav pievienoti attēli: $count — pārsniedz $limit pikseļu';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Nav pievienoti attēli: $count';
  }

  @override
  String get clipboardUnavailable => 'Starpliktuve nav pieejama';

  @override
  String get pasteImageFailed => 'Šo attēlu neizdevās pievienot';

  @override
  String get menuQuit => 'Iziet no PDFSign';

  @override
  String get closeAllDialogTitle => 'Saglabāt izmaiņas?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vai vēlaties saglabāt izmaiņas $count dokumentos pirms aizvēršanas?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vai vēlaties saglabāt izmaiņas 1 dokumentā pirms aizvēršanas?';

  @override
  String get closeAllDialogSaveAll => 'Saglabāt visu';

  @override
  String get closeAllDialogDontSave => 'Nesaglabāt';

  @override
  String get closeAllDialogCancel => 'Atcelt';

  @override
  String get saveFailedDialogTitle => 'Saglabāšana neizdevās';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Neizdevās saglabāt $count dokumentu(s). Aizvērt tik un tā?';
  }

  @override
  String get saveFailedDialogClose => 'Aizvērt tik un tā';

  @override
  String get saveChangesTitle => 'Saglabat izmainas?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vai velaties saglabat izmainas faila \"$fileName\" pirms aizvershanas?';
  }

  @override
  String get saveButton => 'Saglabat';

  @override
  String get discardButton => 'Nesaglabat';

  @override
  String get documentEdited => 'Redigets';

  @override
  String get documentSaved => 'Saglabats';

  @override
  String get menuSettings => 'Iestatijumi...';

  @override
  String get menuWindow => 'Logs';

  @override
  String get menuMinimize => 'Minimizēt';

  @override
  String get menuZoom => 'Tālummaiņa';

  @override
  String get menuBringAllToFront => 'Pārvietot visu priekšplānā';

  @override
  String get settingsTitle => 'Iestatijumi';

  @override
  String get settingsLanguage => 'Valoda';

  @override
  String get settingsLanguageSystem => 'Sistemas noklusejums';

  @override
  String get settingsUnits => 'Mervienibas';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Collas';

  @override
  String get settingsSearchLanguages => 'Meklēt valodas...';

  @override
  String get settingsGeneral => 'Vispārīgi';

  @override
  String get addImage => 'Pievienot attēlu';

  @override
  String get selectImages => 'Izvēlieties attēlus';

  @override
  String get zoomFitWidth => 'Pielāgot platumam';

  @override
  String get zoomIn => 'Pietuvināt';

  @override
  String get zoomOut => 'Attālināt';

  @override
  String get selectZoomLevel => 'Izvēlieties tālummaiņas līmeni';

  @override
  String get goToPage => 'Doties uz lapu';

  @override
  String get go => 'Doties';

  @override
  String get savePdfAs => 'Saglabāt PDF kā';

  @override
  String get incorrectPassword => 'Nepareiza parole';

  @override
  String get saveFailed => 'Saglabāšana neizdevās';

  @override
  String savedTo(String path) {
    return 'Saglabāts: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nav saglabāts oriģinālais PDF';

  @override
  String get waitingForFolderPermission => 'Gaida mapes piekļuves atļauju...';

  @override
  String get deleteButtonLabel => 'Dzēst';

  @override
  String get deleteButtonTooltip => 'Dzēst atlasīto objektu';

  @override
  String get documentProtectedTitle => 'Šis dokuments ir aizsargāts';

  @override
  String get documentProtectedBody => 'Ievadiet paroli, lai to atvērtu.';

  @override
  String get passwordFieldLabel => 'Parole';

  @override
  String get openDocumentButton => 'Atvērt';

  @override
  String get documentReadOnlyTitle => 'Šis dokuments neļauj veikt izmaiņas';

  @override
  String get documentReadOnlyBody =>
      'To var lasīt un drukāt, taču īpašnieks nav atļāvis izmaiņas. Ievadiet īpašnieka paroli, lai to rediģētu.';

  @override
  String get enterOwnerPassword => 'Ievadiet īpašnieka paroli';

  @override
  String get ownerPasswordFieldLabel => 'Īpašnieka parole';

  @override
  String get menuPrint => 'Drukāt…';

  @override
  String get menuPrintCurrentPage => 'Drukāt pašreizējo lappusi';

  @override
  String get printingIsTheOwnersTitle =>
      'Šo dokumentu drīkst drukāt tikai īpašnieks';

  @override
  String get printingNotAllowed => 'Šis dokuments neļauj drukāt.';

  @override
  String get printingFailed => 'Dokumentu neizdevās izdrukāt.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Šī dokumenta aizsardzību drīkst mainīt tikai īpašnieks';

  @override
  String get continueButton => 'Turpināt';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Aizsargāts dokuments tiek rādīts no atmiņas, un šis aizņem $size. Tā atvēršana izmantos aptuveni tikpat.';
  }

  @override
  String get shareProtectedNotice =>
      'Kopīgotā kopija saglabā dokumenta paroli.';

  @override
  String get unsupportedProtection =>
      'Šī dokumenta aizsardzība netiek atbalstīta. PDFSign atver ar paroli aizsargātus dokumentus, nevis tos, kas aizsargāti ar sertifikātu.';

  @override
  String get menuBringToFront => 'Novietot priekšplānā';

  @override
  String get menuBringForward => 'Pārvietot uz priekšu';

  @override
  String get menuSendBackward => 'Pārvietot atpakaļ';

  @override
  String get menuSendToBack => 'Novietot fonā';

  @override
  String get zOrderGroupLabel => 'Kārtot';

  @override
  String get menuUndo => 'Atsaukt';

  @override
  String get menuRedo => 'Atcelt atsaukšanu';

  @override
  String get dragToReorder => 'Velciet, lai mainītu secību';

  @override
  String get protectDocumentTitle => 'Dokumenta aizsardzība';

  @override
  String get requirePasswordToOpen => 'Pieprasīt paroli dokumenta atvēršanai';

  @override
  String get verifyFieldLabel => 'Apstiprinājums';

  @override
  String get permissionsHeading => 'Atļaujas';

  @override
  String get permissionsNote =>
      'Atļaut tālāk norādītās izmaiņas, neievadot īpašnieka paroli.';

  @override
  String get permissionPrinting => 'Drukāšana';

  @override
  String get permissionCopying => 'Teksta vai grafikas kopēšana';

  @override
  String get permissionPageAssembly =>
      'Lappušu ievietošana, dzēšana un pagriešana';

  @override
  String get permissionAnnotations => 'Anotāciju un parakstu pievienošana';

  @override
  String get permissionChangingContent => 'Dokumenta mainīšana';

  @override
  String get permissionFormFilling => 'Esošo veidlapu lauku aizpildīšana';

  @override
  String get changingContentIncludes =>
      'Dokumenta mainīšana ietver anotēšanu un veidlapu aizpildīšanu — tās tiek atļautas kopā ar to.';

  @override
  String get ownerPasswordHeading => 'Īpašnieka parole';

  @override
  String get removeProtection => 'Noņemt aizsardzību';

  @override
  String get applyButton => 'Lietot';

  @override
  String get passwordsDoNotMatch => 'Paroles nesakrīt';

  @override
  String get passwordCannotBeEmpty => 'Ievadiet paroli';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Ierobežojumiem nepieciešama īpašnieka parole. Bez tās tos var noņemt jebkurš.';

  @override
  String get signingNeedsChangingContent =>
      'Bez „Dokumenta mainīšanas“ šo failu šeit nevarēs parakstīt vēlreiz bez īpašnieka paroles.';

  @override
  String get menuProtectDocument => 'Aizsargāt dokumentu…';

  @override
  String get protectButtonLabel => 'Aizsargāt';

  @override
  String get protectButtonTooltip =>
      'Iestatiet šī dokumenta paroles un atļaujas';
}
