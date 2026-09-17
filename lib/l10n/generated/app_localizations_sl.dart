// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Slovenian (`sl`).
class AppLocalizationsSl extends AppLocalizations {
  AppLocalizationsSl([String locale = 'sl']) : super(locale);

  @override
  String get openPdf => 'Odpri PDF';

  @override
  String get selectPdf => 'Izberi PDF';

  @override
  String get recentFiles => 'Nedavne datoteke';

  @override
  String get removeFromList => 'Odstrani s seznama';

  @override
  String get openedNow => 'Pravkar odprto';

  @override
  String openedMinutesAgo(int count) {
    return 'Odprto pred $count minutami';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Odprto pred $count urami';
  }

  @override
  String get openedYesterday => 'Odprto vceraj';

  @override
  String openedDaysAgo(int count) {
    return 'Odprto pred $count dnevi';
  }

  @override
  String get fileNotFound => 'Datoteka ni najdena';

  @override
  String get fileAccessDenied => 'Dostop zavrnjen';

  @override
  String get clearRecentFiles => 'Pocisti nedavne datoteke';

  @override
  String get cancel => 'Preklic';

  @override
  String get confirm => 'Potrdi';

  @override
  String get error => 'Napaka';

  @override
  String get ok => 'V redu';

  @override
  String get menuFile => 'Datoteka';

  @override
  String get menuOpen => 'Odpri...';

  @override
  String get menuOpenRecent => 'Odpri nedavne';

  @override
  String get menuNoRecentFiles => 'Ni nedavnih datotek';

  @override
  String get menuClearMenu => 'Pocisti meni';

  @override
  String get menuSave => 'Shrani';

  @override
  String get menuSaveAs => 'Shrani kot...';

  @override
  String get menuSaveAll => 'Shrani vse';

  @override
  String get menuShare => 'Deli...';

  @override
  String get menuCloseWindow => 'Zapri okno';

  @override
  String get menuCloseAll => 'Zapri vse';

  @override
  String get menuEdit => 'Uredi';

  @override
  String get menuDelete => 'Izbriši';

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
  String get menuQuit => 'Zapusti PDFSign';

  @override
  String get closeAllDialogTitle => 'Shrani spremembe?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ali želite shraniti spremembe v $count dokumentih pred zaprtjem?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ali želite shraniti spremembe v 1 dokumentu pred zaprtjem?';

  @override
  String get closeAllDialogSaveAll => 'Shrani vse';

  @override
  String get closeAllDialogDontSave => 'Ne shrani';

  @override
  String get closeAllDialogCancel => 'Preklic';

  @override
  String get saveFailedDialogTitle => 'Shranjevanje ni uspelo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Shranjevanje $count dokumenta(ov) ni uspelo. Vseeno zaprem?';
  }

  @override
  String get saveFailedDialogClose => 'Vseeno zapri';

  @override
  String get saveChangesTitle => 'Shrani spremembe?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ali zelite shraniti spremembe v \"$fileName\" pred zaprtjem?';
  }

  @override
  String get saveButton => 'Shrani';

  @override
  String get discardButton => 'Ne shrani';

  @override
  String get documentEdited => 'Urejeno';

  @override
  String get documentSaved => 'Shranjeno';

  @override
  String get menuSettings => 'Nastavitve...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimiraj';

  @override
  String get menuZoom => 'Povečaj';

  @override
  String get menuBringAllToFront => 'Prinesi vse v ospredje';

  @override
  String get settingsTitle => 'Nastavitve';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Sistemska privzeta';

  @override
  String get settingsUnits => 'Enote';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Palci';

  @override
  String get settingsSearchLanguages => 'Iskanje jezikov...';

  @override
  String get settingsGeneral => 'Splošno';

  @override
  String get addImage => 'Dodaj sliko';

  @override
  String get selectImages => 'Izberi slike';

  @override
  String get zoomFitWidth => 'Prilagodi širini';

  @override
  String get zoomIn => 'Povečaj';

  @override
  String get zoomOut => 'Pomanjšaj';

  @override
  String get selectZoomLevel => 'Izberi stopnjo povečave';

  @override
  String get goToPage => 'Pojdi na stran';

  @override
  String get go => 'Pojdi';

  @override
  String get savePdfAs => 'Shrani PDF kot';

  @override
  String get incorrectPassword => 'Napačno geslo';

  @override
  String get saveFailed => 'Shranjevanje ni uspelo';

  @override
  String savedTo(String path) {
    return 'Shranjeno v: $path';
  }

  @override
  String get noOriginalPdfStored => 'Izvirni PDF ni shranjen';

  @override
  String get waitingForFolderPermission =>
      'Čakanje na dovoljenje za dostop do mape...';

  @override
  String get deleteButtonLabel => 'Izbriši';

  @override
  String get deleteButtonTooltip => 'Izbriši izbrani predmet';

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
