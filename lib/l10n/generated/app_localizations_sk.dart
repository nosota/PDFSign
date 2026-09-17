// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class AppLocalizationsSk extends AppLocalizations {
  AppLocalizationsSk([String locale = 'sk']) : super(locale);

  @override
  String get openPdf => 'Otvoriť PDF';

  @override
  String get selectPdf => 'Vybrať PDF';

  @override
  String get recentFiles => 'Nedávne súbory';

  @override
  String get removeFromList => 'Odstrániť zo zoznamu';

  @override
  String get openedNow => 'Práve otvorené';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minútami',
      few: 'minútami',
      one: 'minútou',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hodinami',
      few: 'hodinami',
      one: 'hodinou',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String get openedYesterday => 'Otvorené včera';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dňami',
      few: 'dňami',
      one: 'dňom',
    );
    return 'Otvorené pred $count $_temp0';
  }

  @override
  String get fileNotFound => 'Súbor sa nenašiel';

  @override
  String get fileAccessDenied => 'Prístup zamietnutý';

  @override
  String get clearRecentFiles => 'Vymazať nedávne súbory';

  @override
  String get cancel => 'Zrušiť';

  @override
  String get confirm => 'Potvrdiť';

  @override
  String get error => 'Chyba';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Súbor';

  @override
  String get menuOpen => 'Otvoriť...';

  @override
  String get menuOpenRecent => 'Otvoriť nedávne';

  @override
  String get menuNoRecentFiles => 'Žiadne nedávne súbory';

  @override
  String get menuClearMenu => 'Vymazať ponuku';

  @override
  String get menuSave => 'Uložiť';

  @override
  String get menuSaveAs => 'Uložiť ako...';

  @override
  String get menuSaveAll => 'Uložiť všetko';

  @override
  String get menuShare => 'Zdieľať...';

  @override
  String get menuCloseWindow => 'Zavrieť okno';

  @override
  String get menuCloseAll => 'Zavrieť všetko';

  @override
  String get menuEdit => 'Upraviť';

  @override
  String get menuDelete => 'Odstrániť';

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
  String get menuQuit => 'Ukončiť PDFSign';

  @override
  String get closeAllDialogTitle => 'Uložiť zmeny?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Chcete uložiť zmeny v $count dokumentoch pred zatvorením?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Chcete uložiť zmeny v 1 dokumente pred zatvorením?';

  @override
  String get closeAllDialogSaveAll => 'Uložiť všetko';

  @override
  String get closeAllDialogDontSave => 'Neuložiť';

  @override
  String get closeAllDialogCancel => 'Zrušiť';

  @override
  String get saveFailedDialogTitle => 'Uloženie zlyhalo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nepodarilo sa uložiť $count dokument(ov). Napriek tomu zavrieť?';
  }

  @override
  String get saveFailedDialogClose => 'Napriek tomu zavrieť';

  @override
  String get saveChangesTitle => 'Uložiť zmeny?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Chcete uložiť zmeny v \"$fileName\" pred zatvorením?';
  }

  @override
  String get saveButton => 'Uložiť';

  @override
  String get discardButton => 'Neuložiť';

  @override
  String get documentEdited => 'Upravené';

  @override
  String get documentSaved => 'Uložené';

  @override
  String get menuSettings => 'Nastavenia...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimalizovať';

  @override
  String get menuZoom => 'Zväčšiť';

  @override
  String get menuBringAllToFront => 'Preniesť všetko dopredu';

  @override
  String get settingsTitle => 'Nastavenia';

  @override
  String get settingsLanguage => 'Jazyk';

  @override
  String get settingsLanguageSystem => 'Predvolený systémový';

  @override
  String get settingsUnits => 'Jednotky';

  @override
  String get settingsUnitsCentimeters => 'Centimetre';

  @override
  String get settingsUnitsInches => 'Palce';

  @override
  String get settingsSearchLanguages => 'Hľadať jazyky...';

  @override
  String get settingsGeneral => 'Všeobecné';

  @override
  String get addImage => 'Pridať obrázok';

  @override
  String get selectImages => 'Vybrať obrázky';

  @override
  String get zoomFitWidth => 'Prispôsobiť šírke';

  @override
  String get zoomIn => 'Priblížiť';

  @override
  String get zoomOut => 'Oddialiť';

  @override
  String get selectZoomLevel => 'Vybrať úroveň priblíženia';

  @override
  String get goToPage => 'Prejsť na stranu';

  @override
  String get go => 'Prejsť';

  @override
  String get savePdfAs => 'Uložiť PDF ako';

  @override
  String get incorrectPassword => 'Nesprávne heslo';

  @override
  String get saveFailed => 'Uloženie zlyhalo';

  @override
  String savedTo(String path) {
    return 'Uložené do: $path';
  }

  @override
  String get noOriginalPdfStored => 'Žiadne pôvodné PDF nie je uložené';

  @override
  String get waitingForFolderPermission =>
      'Čakanie na povolenie prístupu k priečinku...';

  @override
  String get deleteButtonLabel => 'Odstrániť';

  @override
  String get deleteButtonTooltip => 'Odstrániť vybraný objekt';

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
