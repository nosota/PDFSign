// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Icelandic (`is`).
class AppLocalizationsIs extends AppLocalizations {
  AppLocalizationsIs([String locale = 'is']) : super(locale);

  @override
  String get openPdf => 'Opna PDF';

  @override
  String get selectPdf => 'Velja PDF';

  @override
  String get recentFiles => 'Nyjar skrar';

  @override
  String get removeFromList => 'Fjarlægja af lista';

  @override
  String get openedNow => 'Nyopnað';

  @override
  String openedMinutesAgo(int count) {
    return 'Opnað fyrir $count min';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Opnað fyrir $count klst';
  }

  @override
  String get openedYesterday => 'Opnað i gær';

  @override
  String openedDaysAgo(int count) {
    return 'Opnað fyrir $count dogum';
  }

  @override
  String get fileNotFound => 'Skra fannst ekki';

  @override
  String get fileAccessDenied => 'Adgangur synjadur';

  @override
  String get clearRecentFiles => 'Hreinsa nyjar skrar';

  @override
  String get cancel => 'Hætta vid';

  @override
  String get confirm => 'Stadsfesta';

  @override
  String get error => 'Villa';

  @override
  String get ok => 'I lagi';

  @override
  String get menuFile => 'Skra';

  @override
  String get menuOpen => 'Opna...';

  @override
  String get menuOpenRecent => 'Opna nyjar';

  @override
  String get menuNoRecentFiles => 'Engar nyjar skrar';

  @override
  String get menuClearMenu => 'Hreinsa valmynd';

  @override
  String get menuSave => 'Vista';

  @override
  String get menuSaveAs => 'Vista sem...';

  @override
  String get menuSaveAll => 'Vista allt';

  @override
  String get menuShare => 'Deila...';

  @override
  String get menuCloseWindow => 'Loka glugga';

  @override
  String get menuCloseAll => 'Loka öllu';

  @override
  String get menuEdit => 'Breyta';

  @override
  String get menuDelete => 'Eyða';

  @override
  String get menuView => 'Skoða';

  @override
  String goToPagePrompt(int total) {
    return 'Sláðu inn blaðsíðunúmer (1–$total):';
  }

  @override
  String get goToPageHint => 'Blaðsíðunúmer';

  @override
  String get goToPageInvalid => 'Sláðu inn gilda tölu';

  @override
  String goToPageOutOfRange(int total) {
    return 'Blaðsíðan verður að vera á bilinu 1 til $total';
  }

  @override
  String get menuRotateLeft => 'Snúa til vinstri';

  @override
  String get menuRotateRight => 'Snúa til hægri';

  @override
  String get menuCut => 'Klippa';

  @override
  String get menuCopy => 'Afrita';

  @override
  String get menuPaste => 'Líma';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'myndir eru',
      one: 'mynd er',
    );
    return 'Ekki bætt við: $count $_temp0 stærri en $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'myndir eru',
      one: 'mynd er',
    );
    return 'Ekki bætt við: $count $_temp0 stærri en $limit dílar';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'myndir',
      one: 'mynd',
    );
    return 'Ekki bætt við: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'Klippiborðið er ekki tiltækt';

  @override
  String get pasteImageFailed => 'Ekki tókst að bæta þessari mynd við';

  @override
  String get menuQuit => 'Hætta í PDFSign';

  @override
  String get closeAllDialogTitle => 'Vista breytingar?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Viltu vista breytingar í $count skjölum áður en lokað er?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Viltu vista breytingar í 1 skjali áður en lokað er?';

  @override
  String get closeAllDialogSaveAll => 'Vista allt';

  @override
  String get closeAllDialogDontSave => 'Ekki vista';

  @override
  String get closeAllDialogCancel => 'Hætta við';

  @override
  String get saveFailedDialogTitle => 'Vista mistókst';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Mistókst að vista $count skjal. Loka samt?';
  }

  @override
  String get saveFailedDialogClose => 'Loka samt';

  @override
  String get saveChangesTitle => 'Vista breytingar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Viltu vista breytingar a \"$fileName\" adur en lokad er?';
  }

  @override
  String get saveButton => 'Vista';

  @override
  String get discardButton => 'Fleygja';

  @override
  String get documentEdited => 'Breytt';

  @override
  String get documentSaved => 'Vistað';

  @override
  String get menuSettings => 'Stillingar...';

  @override
  String get menuWindow => 'Gluggi';

  @override
  String get menuMinimize => 'Lágmarka';

  @override
  String get menuZoom => 'Stækka';

  @override
  String get menuBringAllToFront => 'Færa allt fremst';

  @override
  String get settingsTitle => 'Stillingar';

  @override
  String get settingsLanguage => 'Tungumál';

  @override
  String get settingsLanguageSystem => 'Sjálfgildi kerfis';

  @override
  String get settingsUnits => 'Einingar';

  @override
  String get settingsUnitsCentimeters => 'Sentimetrar';

  @override
  String get settingsUnitsInches => 'Tommur';

  @override
  String get settingsSearchLanguages => 'Leita að tungumálum...';

  @override
  String get settingsGeneral => 'Almennt';

  @override
  String get addImage => 'Bæta við mynd';

  @override
  String get selectImages => 'Velja myndir';

  @override
  String get zoomFitWidth => 'Passa við breidd';

  @override
  String get zoomIn => 'Stækka';

  @override
  String get zoomOut => 'Minnka';

  @override
  String get selectZoomLevel => 'Velja stækkunarstig';

  @override
  String get goToPage => 'Fara á síðu';

  @override
  String get go => 'Fara';

  @override
  String get savePdfAs => 'Vista PDF sem';

  @override
  String get incorrectPassword => 'Rangt lykilorð';

  @override
  String get saveFailed => 'Vistun mistókst';

  @override
  String savedTo(String path) {
    return 'Vistað í: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ekkert upprunalegt PDF vistað';

  @override
  String get waitingForFolderPermission =>
      'Bíð eftir aðgangsheimild fyrir möppu...';

  @override
  String get deleteButtonLabel => 'Eyða';

  @override
  String get deleteButtonTooltip => 'Eyða völdum hlut';

  @override
  String get documentProtectedTitle => 'Þetta skjal er varið';

  @override
  String get documentProtectedBody => 'Sláðu inn lykilorðið til að opna það.';

  @override
  String get passwordFieldLabel => 'Lykilorð';

  @override
  String get openDocumentButton => 'Opna';

  @override
  String get documentReadOnlyTitle => 'Þetta skjal leyfir ekki breytingar';

  @override
  String get documentReadOnlyBody =>
      'Það má lesa og prenta, en eigandinn hefur ekki leyft breytingar. Sláðu inn lykilorð eigandans til að breyta því.';

  @override
  String get enterOwnerPassword => 'Sláðu inn lykilorð eigandans';

  @override
  String get ownerPasswordFieldLabel => 'Lykilorð eigandans';

  @override
  String get menuPrint => 'Prenta…';

  @override
  String get menuPrintCurrentPage => 'Prenta núverandi síðu';

  @override
  String get printingIsTheOwnersTitle =>
      'Aðeins eigandinn má prenta þetta skjal';

  @override
  String get printingNotAllowed => 'Þetta skjal leyfir ekki prentun.';

  @override
  String get printingFailed => 'Ekki tókst að prenta skjalið.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Aðeins eigandinn má breyta vörn þessa skjals';

  @override
  String get continueButton => 'Halda áfram';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Varið skjal birtist úr minni, og þetta er $size að stærð. Að opna það notar álíka mikið minni.';
  }

  @override
  String get shareProtectedNotice =>
      'Deilda eintakið heldur lykilorði skjalsins.';

  @override
  String get unsupportedProtection =>
      'Vörn þessa skjals er ekki studd. PDFSign opnar skjöl sem varin eru með lykilorði, ekki þau sem varin eru með skilríki.';

  @override
  String get menuBringToFront => 'Færa fremst';

  @override
  String get menuBringForward => 'Færa framar';

  @override
  String get menuSendBackward => 'Færa aftar';

  @override
  String get menuSendToBack => 'Færa aftast';

  @override
  String get zOrderGroupLabel => 'Raða';

  @override
  String get menuUndo => 'Afturkalla';

  @override
  String get menuRedo => 'Endurtaka';

  @override
  String get dragToReorder => 'Dragðu til að breyta röðinni';

  @override
  String get protectDocumentTitle => 'Verja skjal';

  @override
  String get requirePasswordToOpen => 'Krefjast lykilorðs til að opna skjalið';

  @override
  String get verifyFieldLabel => 'Staðfesting';

  @override
  String get permissionsHeading => 'Heimildir';

  @override
  String get permissionsNote =>
      'Leyfa eftirfarandi breytingar án þess að slá inn lykilorð eigandans.';

  @override
  String get permissionPrinting => 'Prentun';

  @override
  String get permissionCopying => 'Afritun texta eða myndefnis';

  @override
  String get permissionPageAssembly => 'Innsetning, eyðing og snúningur síðna';

  @override
  String get permissionAnnotations => 'Viðbót skýringa og undirskrifta';

  @override
  String get permissionChangingContent => 'Breyting á skjalinu';

  @override
  String get permissionFormFilling => 'Útfylling fyrirliggjandi eyðublaðsreita';

  @override
  String get changingContentIncludes =>
      'Breyting á skjalinu nær yfir skýringar og útfyllingu eyðublaða — þær eru leyfðar með henni.';

  @override
  String get ownerPasswordHeading => 'Lykilorð eigandans';

  @override
  String get removeProtection => 'Fjarlægja vörn';

  @override
  String get applyButton => 'Nota';

  @override
  String get passwordsDoNotMatch => 'Lykilorðin stemma ekki';

  @override
  String get passwordCannotBeEmpty => 'Sláðu inn lykilorð';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Takmarkanir krefjast lykilorðs eigandans. Án þess getur hver sem er fjarlægt þær.';

  @override
  String get signingNeedsChangingContent =>
      'Án „Breytingar á skjalinu“ verður ekki hægt að undirrita þessa skrá hér aftur án lykilorðs eigandans.';

  @override
  String get menuProtectDocument => 'Verja skjal…';

  @override
  String get protectButtonLabel => 'Verja';

  @override
  String get protectButtonTooltip =>
      'Stilltu lykilorð og heimildir þessa skjals';
}
