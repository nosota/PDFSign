// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get openPdf => 'Åbn PDF';

  @override
  String get selectPdf => 'Vælg PDF';

  @override
  String get recentFiles => 'Seneste filer';

  @override
  String get removeFromList => 'Fjern fra listen';

  @override
  String get openedNow => 'Lige åbnet';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutter',
      one: 'minut',
    );
    return 'Åbnet for $count $_temp0 siden';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'timer',
      one: 'time',
    );
    return 'Åbnet for $count $_temp0 siden';
  }

  @override
  String get openedYesterday => 'Åbnet i går';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dage',
      one: 'dag',
    );
    return 'Åbnet for $count $_temp0 siden';
  }

  @override
  String get fileNotFound => 'Filen blev ikke fundet';

  @override
  String get fileAccessDenied => 'Adgang nægtet';

  @override
  String get clearRecentFiles => 'Ryd seneste filer';

  @override
  String get cancel => 'Annuller';

  @override
  String get confirm => 'Bekræft';

  @override
  String get error => 'Fejl';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkiv';

  @override
  String get menuOpen => 'Åbn...';

  @override
  String get menuOpenRecent => 'Åbn seneste';

  @override
  String get menuNoRecentFiles => 'Ingen seneste filer';

  @override
  String get menuClearMenu => 'Ryd menu';

  @override
  String get menuSave => 'Gem';

  @override
  String get menuSaveAs => 'Gem som...';

  @override
  String get menuSaveAll => 'Gem alle';

  @override
  String get menuShare => 'Del...';

  @override
  String get menuCloseWindow => 'Luk vindue';

  @override
  String get menuCloseAll => 'Luk alle';

  @override
  String get menuEdit => 'Rediger';

  @override
  String get menuDelete => 'Slet';

  @override
  String get menuView => 'Vis';

  @override
  String goToPagePrompt(int total) {
    return 'Indtast sidetal (1–$total):';
  }

  @override
  String get goToPageHint => 'Sidetal';

  @override
  String get goToPageInvalid => 'Indtast et gyldigt tal';

  @override
  String goToPageOutOfRange(int total) {
    return 'Siden skal være mellem 1 og $total';
  }

  @override
  String get menuRotateLeft => 'Roter mod venstre';

  @override
  String get menuRotateRight => 'Roter mod højre';

  @override
  String get menuCut => 'Klip';

  @override
  String get menuCopy => 'Kopier';

  @override
  String get menuPaste => 'Sæt ind';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'billeder er',
      one: 'billede er',
    );
    return 'Ikke tilføjet: $count $_temp0 større end $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'billeder er',
      one: 'billede er',
    );
    return 'Ikke tilføjet: $count $_temp0 større end $limit pixel';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'billeder',
      one: 'billede',
    );
    return 'Ikke tilføjet: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'Udklipsholderen er ikke tilgængelig';

  @override
  String get pasteImageFailed => 'Billedet kunne ikke tilføjes';

  @override
  String get menuQuit => 'Afslut PDFSign';

  @override
  String get closeAllDialogTitle => 'Gem ændringer?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vil du gemme ændringerne i $count dokumenter før lukning?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vil du gemme ændringerne i 1 dokument før lukning?';

  @override
  String get closeAllDialogSaveAll => 'Gem alle';

  @override
  String get closeAllDialogDontSave => 'Gem ikke';

  @override
  String get closeAllDialogCancel => 'Annuller';

  @override
  String get saveFailedDialogTitle => 'Gem mislykkedes';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Kunne ikke gemme $count dokument(er). Luk alligevel?';
  }

  @override
  String get saveFailedDialogClose => 'Luk alligevel';

  @override
  String get saveChangesTitle => 'Gem ændringer?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vil du gemme ændringerne i \"$fileName\" før lukning?';
  }

  @override
  String get saveButton => 'Gem';

  @override
  String get discardButton => 'Gem ikke';

  @override
  String get documentEdited => 'Redigeret';

  @override
  String get documentSaved => 'Gemt';

  @override
  String get menuSettings => 'Indstillinger...';

  @override
  String get menuWindow => 'Vindue';

  @override
  String get menuMinimize => 'Minimer';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Bring alle forrest';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get settingsLanguage => 'Sprog';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Enheder';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Tommer';

  @override
  String get settingsSearchLanguages => 'Søg sprog...';

  @override
  String get settingsGeneral => 'Generelt';

  @override
  String get addImage => 'Tilføj billede';

  @override
  String get selectImages => 'Vælg billeder';

  @override
  String get zoomFitWidth => 'Tilpas bredde';

  @override
  String get zoomIn => 'Zoom ind';

  @override
  String get zoomOut => 'Zoom ud';

  @override
  String get selectZoomLevel => 'Vælg zoomniveau';

  @override
  String get goToPage => 'Gå til side';

  @override
  String get go => 'Gå';

  @override
  String get savePdfAs => 'Gem PDF som';

  @override
  String get incorrectPassword => 'Forkert adgangskode';

  @override
  String get saveFailed => 'Gemning mislykkedes';

  @override
  String savedTo(String path) {
    return 'Gemt til: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ingen original PDF gemt';

  @override
  String get waitingForFolderPermission =>
      'Venter på tilladelse til mappeadgang...';

  @override
  String get deleteButtonLabel => 'Slet';

  @override
  String get deleteButtonTooltip => 'Slet valgt objekt';

  @override
  String get documentProtectedTitle => 'Dette dokument er beskyttet';

  @override
  String get documentProtectedBody => 'Indtast adgangskoden for at åbne det.';

  @override
  String get passwordFieldLabel => 'Adgangskode';

  @override
  String get openDocumentButton => 'Åbn';

  @override
  String get documentReadOnlyTitle => 'Dette dokument tillader ikke ændringer';

  @override
  String get documentReadOnlyBody =>
      'Det kan læses og udskrives, men ejeren har ikke tilladt ændringer. Indtast ejerens adgangskode for at redigere det.';

  @override
  String get enterOwnerPassword => 'Indtast ejerens adgangskode';

  @override
  String get ownerPasswordFieldLabel => 'Ejerens adgangskode';

  @override
  String get menuPrint => 'Udskriv…';

  @override
  String get menuPrintCurrentPage => 'Udskriv den aktuelle side';

  @override
  String get printingIsTheOwnersTitle =>
      'Kun ejeren må udskrive dette dokument';

  @override
  String get printingNotAllowed => 'Dette dokument tillader ikke udskrivning.';

  @override
  String get printingFailed => 'Dokumentet kunne ikke udskrives.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Kun ejeren må ændre beskyttelsen af dette dokument';

  @override
  String get continueButton => 'Fortsæt';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Et beskyttet dokument vises fra hukommelsen, og dette fylder $size. At åbne det bruger omtrent lige så meget.';
  }

  @override
  String get shareProtectedNotice =>
      'Den delte kopi beholder dokumentets adgangskode.';

  @override
  String get unsupportedProtection =>
      'Beskyttelsen af dette dokument understøttes ikke. PDFSign åbner dokumenter beskyttet med adgangskode, ikke dem der er beskyttet med et certifikat.';

  @override
  String get menuBringToFront => 'Placer forrest';

  @override
  String get menuBringForward => 'Flyt fremad';

  @override
  String get menuSendBackward => 'Flyt bagud';

  @override
  String get menuSendToBack => 'Placer bagerst';

  @override
  String get zOrderGroupLabel => 'Arranger';

  @override
  String get menuUndo => 'Fortryd';

  @override
  String get menuRedo => 'Gentag';

  @override
  String get dragToReorder => 'Træk for at ændre rækkefølgen';

  @override
  String get protectDocumentTitle => 'Beskyt dokument';

  @override
  String get requirePasswordToOpen => 'Kræv adgangskode for at åbne dokumentet';

  @override
  String get verifyFieldLabel => 'Bekræftelse';

  @override
  String get permissionsHeading => 'Tilladelser';

  @override
  String get permissionsNote =>
      'Tillad følgende ændringer uden at indtaste ejerens adgangskode.';

  @override
  String get permissionPrinting => 'Udskrivning';

  @override
  String get permissionCopying => 'Kopiering af tekst eller grafik';

  @override
  String get permissionPageAssembly =>
      'Indsættelse, sletning og rotation af sider';

  @override
  String get permissionAnnotations => 'Tilføjelse af noter og underskrifter';

  @override
  String get permissionChangingContent => 'Ændring af dokumentet';

  @override
  String get permissionFormFilling =>
      'Udfyldning af eksisterende formularfelter';

  @override
  String get changingContentIncludes =>
      'Ændring af dokumentet omfatter noter og udfyldning af formularer — de tillades sammen med den.';

  @override
  String get ownerPasswordHeading => 'Ejerens adgangskode';

  @override
  String get removeProtection => 'Fjern beskyttelse';

  @override
  String get applyButton => 'Anvend';

  @override
  String get passwordsDoNotMatch => 'Adgangskoderne er ikke ens';

  @override
  String get passwordCannotBeEmpty => 'Indtast en adgangskode';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Begrænsninger kræver en ejeradgangskode. Uden den kan enhver fjerne dem.';

  @override
  String get signingNeedsChangingContent =>
      'Uden “Ændring af dokumentet” kan denne fil ikke underskrives her igen uden ejerens adgangskode.';

  @override
  String get menuProtectDocument => 'Beskyt dokument…';

  @override
  String get protectButtonLabel => 'Beskyt';

  @override
  String get protectButtonTooltip =>
      'Angiv adgangskoder og tilladelser for dette dokument';
}
