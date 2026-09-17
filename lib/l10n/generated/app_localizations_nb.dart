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
  String get menuPrint => 'Print…';

  @override
  String get menuPrintCurrentPage => 'Print Current Page';

  @override
  String get printingIsTheOwnersTitle =>
      'Only the owner may print this document';

  @override
  String get printingNotAllowed => 'This document does not allow printing.';

  @override
  String get printingFailed => 'The document could not be printed.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Only the owner may change this document\'s protection';

  @override
  String get continueButton => 'Continue';

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

  @override
  String get menuUndo => 'Undo';

  @override
  String get menuRedo => 'Redo';

  @override
  String get dragToReorder => 'Drag to reorder';

  @override
  String get protectDocumentTitle => 'Protect Document';

  @override
  String get requirePasswordToOpen => 'Require Password To Open Document';

  @override
  String get verifyFieldLabel => 'Verify';

  @override
  String get permissionsHeading => 'Permissions';

  @override
  String get permissionsNote =>
      'Allow the following changes to be made without entering the owner password.';

  @override
  String get permissionPrinting => 'Printing';

  @override
  String get permissionCopying => 'Copying Text or Graphics';

  @override
  String get permissionPageAssembly => 'Inserting, Deleting, or Rotating Pages';

  @override
  String get permissionAnnotations => 'Adding Annotations or Signatures';

  @override
  String get permissionChangingContent => 'Changing the Document';

  @override
  String get permissionFormFilling => 'Filling Existing Form Fields';

  @override
  String get changingContentIncludes =>
      'Changing the document includes annotating and filling in forms, so those are granted with it.';

  @override
  String get ownerPasswordHeading => 'Owner Password';

  @override
  String get removeProtection => 'Remove Protection';

  @override
  String get applyButton => 'Apply';

  @override
  String get passwordsDoNotMatch => 'The passwords do not match';

  @override
  String get passwordCannotBeEmpty => 'Enter a password';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Restrictions need an owner password. Without one, anyone can lift them.';

  @override
  String get signingNeedsChangingContent =>
      'Without “Changing the Document”, this file cannot be signed here again unless the owner password is given.';

  @override
  String get menuProtectDocument => 'Protect Document…';

  @override
  String get protectButtonLabel => 'Protect';

  @override
  String get protectButtonTooltip =>
      'Set this document\'s passwords and permissions';
}
