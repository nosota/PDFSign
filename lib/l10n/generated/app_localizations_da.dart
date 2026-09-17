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
  String get menuView => 'View';

  @override
  String goToPagePrompt(int total) {
    return 'Enter page number (1-$total):';
  }

  @override
  String get goToPageHint => 'Page number';

  @override
  String get goToPageInvalid => 'Please enter a valid number';

  @override
  String goToPageOutOfRange(int total) {
    return 'Page must be between 1 and $total';
  }

  @override
  String get menuRotateLeft => 'Rotate Left';

  @override
  String get menuRotateRight => 'Rotate Right';

  @override
  String get menuCut => 'Cut';

  @override
  String get menuCopy => 'Copy';

  @override
  String get menuPaste => 'Paste';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Not added: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'The clipboard is unavailable';

  @override
  String get pasteImageFailed => 'That image could not be added';

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
  String get documentProtectedTitle => 'This document is protected';

  @override
  String get documentProtectedBody => 'Enter its password to open it.';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get openDocumentButton => 'Open';

  @override
  String get documentReadOnlyTitle => 'This document does not allow changes';

  @override
  String get documentReadOnlyBody =>
      'It can be read and printed, but its owner has not allowed it to be changed. Enter the owner password to edit it.';

  @override
  String get enterOwnerPassword => 'Enter owner password';

  @override
  String get ownerPasswordFieldLabel => 'Owner password';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'A protected document has to be held in memory to be shown, and this one is $size. Opening it will use about that much.';
  }

  @override
  String get shareProtectedNotice =>
      'The shared copy keeps the document\'s password.';

  @override
  String get unsupportedProtection =>
      'This document\'s protection is not supported. PDFSign opens password-protected documents, not those protected by a certificate.';

  @override
  String get menuBringToFront => 'Bring to Front';

  @override
  String get menuBringForward => 'Bring Forward';

  @override
  String get menuSendBackward => 'Send Backward';

  @override
  String get menuSendToBack => 'Send to Back';

  @override
  String get zOrderGroupLabel => 'Arrange';
}
