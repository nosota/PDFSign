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
