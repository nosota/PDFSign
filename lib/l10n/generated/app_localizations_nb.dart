// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get openPdf => 'Åpne PDF';

  @override
  String get selectPdf => 'Velg PDF';

  @override
  String get recentFiles => 'Nylige filer';

  @override
  String get removeFromList => 'Fjern fra listen';

  @override
  String get openedNow => 'Nettopp åpnet';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutter',
      one: 'minutt',
    );
    return 'Åpnet for $count $_temp0 siden';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'timer',
      one: 'time',
    );
    return 'Åpnet for $count $_temp0 siden';
  }

  @override
  String get openedYesterday => 'Åpnet i går';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dager',
      one: 'dag',
    );
    return 'Åpnet for $count $_temp0 siden';
  }

  @override
  String get fileNotFound => 'Filen ble ikke funnet';

  @override
  String get fileAccessDenied => 'Tilgang nektet';

  @override
  String get clearRecentFiles => 'Tøm nylige filer';

  @override
  String get cancel => 'Avbryt';

  @override
  String get confirm => 'Bekreft';

  @override
  String get error => 'Feil';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkiv';

  @override
  String get menuOpen => 'Åpne...';

  @override
  String get menuOpenRecent => 'Åpne nylige';

  @override
  String get menuNoRecentFiles => 'Ingen nylige filer';

  @override
  String get menuClearMenu => 'Tøm meny';

  @override
  String get menuSave => 'Lagre';

  @override
  String get menuSaveAs => 'Lagre som...';

  @override
  String get menuSaveAll => 'Lagre alle';

  @override
  String get menuShare => 'Del...';

  @override
  String get menuCloseWindow => 'Lukk vindu';

  @override
  String get menuCloseAll => 'Lukk alle';

  @override
  String get menuEdit => 'Rediger';

  @override
  String get menuDelete => 'Slett';

  @override
  String get menuView => 'Vis';

  @override
  String goToPagePrompt(int total) {
    return 'Skriv inn sidetall (1–$total):';
  }

  @override
  String get goToPageHint => 'Sidetall';

  @override
  String get goToPageInvalid => 'Skriv inn et gyldig tall';

  @override
  String goToPageOutOfRange(int total) {
    return 'Siden må være mellom 1 og $total';
  }

  @override
  String get menuRotateLeft => 'Roter mot venstre';

  @override
  String get menuRotateRight => 'Roter mot høyre';

  @override
  String get menuCut => 'Klipp ut';

  @override
  String get menuCopy => 'Kopier';

  @override
  String get menuPaste => 'Lim inn';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bilder er',
      one: 'bilde er',
    );
    return 'Ikke lagt til: $count $_temp0 større enn $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bilder er',
      one: 'bilde er',
    );
    return 'Ikke lagt til: $count $_temp0 større enn $limit piksler';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bilder',
      one: 'bilde',
    );
    return 'Ikke lagt til: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'Utklippstavlen er ikke tilgjengelig';

  @override
  String get pasteImageFailed => 'Bildet kunne ikke legges til';

  @override
  String get menuQuit => 'Avslutt PDFSign';

  @override
  String get closeAllDialogTitle => 'Lagre endringer?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vil du lagre endringene i $count dokumenter før lukking?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vil du lagre endringene i 1 dokument før lukking?';

  @override
  String get closeAllDialogSaveAll => 'Lagre alle';

  @override
  String get closeAllDialogDontSave => 'Ikke lagre';

  @override
  String get closeAllDialogCancel => 'Avbryt';

  @override
  String get saveFailedDialogTitle => 'Lagring mislyktes';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Kunne ikke lagre $count dokument(er). Lukke likevel?';
  }

  @override
  String get saveFailedDialogClose => 'Lukk likevel';

  @override
  String get saveChangesTitle => 'Lagre endringer?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vil du lagre endringene i \"$fileName\" før lukking?';
  }

  @override
  String get saveButton => 'Lagre';

  @override
  String get discardButton => 'Ikke lagre';

  @override
  String get documentEdited => 'Redigert';

  @override
  String get documentSaved => 'Lagret';

  @override
  String get menuSettings => 'Innstillinger...';

  @override
  String get menuWindow => 'Vindu';

  @override
  String get menuMinimize => 'Minimer';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Vis alle foran';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Enheter';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Tommer';

  @override
  String get settingsSearchLanguages => 'Søk etter språk...';

  @override
  String get settingsGeneral => 'Generelt';

  @override
  String get addImage => 'Legg til bilde';

  @override
  String get selectImages => 'Velg bilder';

  @override
  String get zoomFitWidth => 'Tilpass bredde';

  @override
  String get zoomIn => 'Zoom inn';

  @override
  String get zoomOut => 'Zoom ut';

  @override
  String get selectZoomLevel => 'Velg zoomnivå';

  @override
  String get goToPage => 'Gå til side';

  @override
  String get go => 'Gå';

  @override
  String get savePdfAs => 'Lagre PDF som';

  @override
  String get incorrectPassword => 'Feil passord';

  @override
  String get saveFailed => 'Lagring mislyktes';

  @override
  String savedTo(String path) {
    return 'Lagret til: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ingen original PDF lagret';

  @override
  String get waitingForFolderPermission =>
      'Venter på tillatelse til mappeadgang...';

  @override
  String get deleteButtonLabel => 'Slett';

  @override
  String get deleteButtonTooltip => 'Slett valgt objekt';

  @override
  String get documentProtectedTitle => 'Dette dokumentet er beskyttet';

  @override
  String get documentProtectedBody => 'Skriv inn passordet for å åpne det.';

  @override
  String get passwordFieldLabel => 'Passord';

  @override
  String get openDocumentButton => 'Åpne';

  @override
  String get documentReadOnlyTitle =>
      'Dette dokumentet tillater ikke endringer';

  @override
  String get documentReadOnlyBody =>
      'Det kan leses og skrives ut, men eieren har ikke tillatt endringer. Skriv inn eierpassordet for å redigere det.';

  @override
  String get enterOwnerPassword => 'Skriv inn eierpassordet';

  @override
  String get ownerPasswordFieldLabel => 'Eierpassord';

  @override
  String get menuPrint => 'Skriv ut…';

  @override
  String get menuPrintCurrentPage => 'Skriv ut gjeldende side';

  @override
  String get printingIsTheOwnersTitle =>
      'Bare eieren kan skrive ut dette dokumentet';

  @override
  String get printingNotAllowed => 'Dette dokumentet tillater ikke utskrift.';

  @override
  String get printingFailed => 'Dokumentet kunne ikke skrives ut.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Bare eieren kan endre beskyttelsen av dette dokumentet';

  @override
  String get continueButton => 'Fortsett';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Et beskyttet dokument vises fra minnet, og dette er $size stort. Å åpne det bruker omtrent like mye minne.';
  }

  @override
  String get shareProtectedNotice =>
      'Den delte kopien beholder passordet til dokumentet.';

  @override
  String get unsupportedProtection =>
      'Beskyttelsen av dette dokumentet støttes ikke. PDFSign åpner dokumenter som er beskyttet med passord, ikke de som er beskyttet med et sertifikat.';

  @override
  String get menuBringToFront => 'Plasser forrest';

  @override
  String get menuBringForward => 'Flytt framover';

  @override
  String get menuSendBackward => 'Flytt bakover';

  @override
  String get menuSendToBack => 'Plasser bakerst';

  @override
  String get zOrderGroupLabel => 'Ordne';

  @override
  String get menuUndo => 'Angre';

  @override
  String get menuRedo => 'Gjør om';

  @override
  String get dragToReorder => 'Dra for å endre rekkefølgen';

  @override
  String get protectDocumentTitle => 'Beskytt dokument';

  @override
  String get requirePasswordToOpen => 'Krev passord for å åpne dokumentet';

  @override
  String get verifyFieldLabel => 'Bekreftelse';

  @override
  String get permissionsHeading => 'Tillatelser';

  @override
  String get permissionsNote =>
      'Tillat følgende endringer uten at eierpassordet skrives inn.';

  @override
  String get permissionPrinting => 'Utskrift';

  @override
  String get permissionCopying => 'Kopiering av tekst eller grafikk';

  @override
  String get permissionPageAssembly =>
      'Innsetting, sletting og rotering av sider';

  @override
  String get permissionAnnotations => 'Tillegg av merknader og signaturer';

  @override
  String get permissionChangingContent => 'Endring av dokumentet';

  @override
  String get permissionFormFilling => 'Utfylling av eksisterende skjemafelt';

  @override
  String get changingContentIncludes =>
      'Endring av dokumentet omfatter merknader og utfylling av skjemaer — de tillates sammen med den.';

  @override
  String get ownerPasswordHeading => 'Eierpassord';

  @override
  String get removeProtection => 'Fjern beskyttelsen';

  @override
  String get applyButton => 'Bruk';

  @override
  String get passwordsDoNotMatch => 'Passordene er ikke like';

  @override
  String get passwordCannotBeEmpty => 'Skriv inn et passord';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Begrensninger krever et eierpassord. Uten det kan hvem som helst fjerne dem.';

  @override
  String get signingNeedsChangingContent =>
      'Uten «Endring av dokumentet» kan ikke denne filen signeres her igjen uten eierpassordet.';

  @override
  String get menuProtectDocument => 'Beskytt dokument…';

  @override
  String get protectButtonLabel => 'Beskytt';

  @override
  String get protectButtonTooltip =>
      'Angi passord og tillatelser for dette dokumentet';
}
