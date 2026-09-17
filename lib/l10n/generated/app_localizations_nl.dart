// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get openPdf => 'PDF openen';

  @override
  String get selectPdf => 'PDF selecteren';

  @override
  String get recentFiles => 'Recente bestanden';

  @override
  String get removeFromList => 'Verwijderen uit lijst';

  @override
  String get openedNow => 'Zojuist geopend';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuten',
      one: 'minuut',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'uur',
      one: 'uur',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String get openedYesterday => 'Gisteren geopend';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dagen',
      one: 'dag',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String get fileNotFound => 'Bestand niet gevonden';

  @override
  String get fileAccessDenied => 'Toegang geweigerd';

  @override
  String get clearRecentFiles => 'Recente bestanden wissen';

  @override
  String get cancel => 'Annuleer';

  @override
  String get confirm => 'Bevestig';

  @override
  String get error => 'Fout';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Archief';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open recente';

  @override
  String get menuNoRecentFiles => 'Geen recente bestanden';

  @override
  String get menuClearMenu => 'Wis menu';

  @override
  String get menuSave => 'Bewaar';

  @override
  String get menuSaveAs => 'Bewaar als...';

  @override
  String get menuSaveAll => 'Alles opslaan';

  @override
  String get menuShare => 'Deel...';

  @override
  String get menuCloseWindow => 'Sluit venster';

  @override
  String get menuCloseAll => 'Alles sluiten';

  @override
  String get menuEdit => 'Bewerken';

  @override
  String get menuDelete => 'Verwijderen';

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
  String get menuQuit => 'Stop PDFSign';

  @override
  String get closeAllDialogTitle => 'Wijzigingen opslaan?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Wilt u de wijzigingen in $count documenten opslaan voordat u sluit?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Wilt u de wijzigingen in 1 document opslaan voordat u sluit?';

  @override
  String get closeAllDialogSaveAll => 'Alles opslaan';

  @override
  String get closeAllDialogDontSave => 'Niet opslaan';

  @override
  String get closeAllDialogCancel => 'Annuleren';

  @override
  String get saveFailedDialogTitle => 'Opslaan mislukt';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Kon $count document(en) niet opslaan. Toch sluiten?';
  }

  @override
  String get saveFailedDialogClose => 'Toch sluiten';

  @override
  String get saveChangesTitle => 'Wijzigingen bewaren?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Wilt u de wijzigingen in \"$fileName\" bewaren voordat u sluit?';
  }

  @override
  String get saveButton => 'Bewaar';

  @override
  String get discardButton => 'Niet bewaren';

  @override
  String get documentEdited => 'Bewerkt';

  @override
  String get documentSaved => 'Bewaard';

  @override
  String get menuSettings => 'Instellingen...';

  @override
  String get menuWindow => 'Venster';

  @override
  String get menuMinimize => 'Minimaliseer';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Breng alles naar voren';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get settingsLanguage => 'Taal';

  @override
  String get settingsLanguageSystem => 'Systeemstandaard';

  @override
  String get settingsUnits => 'Eenheden';

  @override
  String get settingsUnitsCentimeters => 'Centimeters';

  @override
  String get settingsUnitsInches => 'Inches';

  @override
  String get settingsSearchLanguages => 'Talen zoeken...';

  @override
  String get settingsGeneral => 'Algemeen';

  @override
  String get addImage => 'Afbeelding toevoegen';

  @override
  String get selectImages => 'Afbeeldingen selecteren';

  @override
  String get zoomFitWidth => 'Breedte aanpassen';

  @override
  String get zoomIn => 'Inzoomen';

  @override
  String get zoomOut => 'Uitzoomen';

  @override
  String get selectZoomLevel => 'Zoomniveau selecteren';

  @override
  String get goToPage => 'Ga naar pagina';

  @override
  String get go => 'Ga';

  @override
  String get savePdfAs => 'PDF opslaan als';

  @override
  String get incorrectPassword => 'Onjuist wachtwoord';

  @override
  String get saveFailed => 'Opslaan mislukt';

  @override
  String savedTo(String path) {
    return 'Opgeslagen naar: $path';
  }

  @override
  String get noOriginalPdfStored => 'Geen originele PDF opgeslagen';

  @override
  String get waitingForFolderPermission =>
      'Wachten op toestemming voor maptoegang...';

  @override
  String get deleteButtonLabel => 'Verwijderen';

  @override
  String get deleteButtonTooltip => 'Geselecteerd object verwijderen';

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
