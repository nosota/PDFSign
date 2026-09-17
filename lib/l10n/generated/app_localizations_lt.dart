// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Lithuanian (`lt`).
class AppLocalizationsLt extends AppLocalizations {
  AppLocalizationsLt([String locale = 'lt']) : super(locale);

  @override
  String get openPdf => 'Atidaryti PDF';

  @override
  String get selectPdf => 'Pasirinkti PDF';

  @override
  String get recentFiles => 'Naujausi failai';

  @override
  String get removeFromList => 'Pasalinti is saraso';

  @override
  String get openedNow => 'Ka tik atidarytas';

  @override
  String openedMinutesAgo(int count) {
    return 'Atidarytas pries $count min.';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Atidarytas pries $count val.';
  }

  @override
  String get openedYesterday => 'Atidarytas vakar';

  @override
  String openedDaysAgo(int count) {
    return 'Atidarytas pries $count d.';
  }

  @override
  String get fileNotFound => 'Failas nerastas';

  @override
  String get fileAccessDenied => 'Prieiga uzdrausta';

  @override
  String get clearRecentFiles => 'Isvalyti naujausius';

  @override
  String get cancel => 'Atsaukti';

  @override
  String get confirm => 'Patvirtinti';

  @override
  String get error => 'Klaida';

  @override
  String get ok => 'Gerai';

  @override
  String get menuFile => 'Failas';

  @override
  String get menuOpen => 'Atidaryti...';

  @override
  String get menuOpenRecent => 'Atidaryti naujausius';

  @override
  String get menuNoRecentFiles => 'Nera naujausiu failu';

  @override
  String get menuClearMenu => 'Isvalyti meniu';

  @override
  String get menuSave => 'Issaugoti';

  @override
  String get menuSaveAs => 'Issaugoti kaip...';

  @override
  String get menuSaveAll => 'Išsaugoti viską';

  @override
  String get menuShare => 'Bendrinti...';

  @override
  String get menuCloseWindow => 'Uzdaryti langa';

  @override
  String get menuCloseAll => 'Uždaryti visus';

  @override
  String get menuEdit => 'Redaguoti';

  @override
  String get menuDelete => 'Ištrinti';

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
  String get menuQuit => 'Išeiti iš PDFSign';

  @override
  String get closeAllDialogTitle => 'Išsaugoti pakeitimus?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Ar norite išsaugoti pakeitimus $count dokumentuose prieš uždarant?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Ar norite išsaugoti pakeitimus 1 dokumente prieš uždarant?';

  @override
  String get closeAllDialogSaveAll => 'Išsaugoti visus';

  @override
  String get closeAllDialogDontSave => 'Neišsaugoti';

  @override
  String get closeAllDialogCancel => 'Atšaukti';

  @override
  String get saveFailedDialogTitle => 'Išsaugoti nepavyko';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nepavyko išsaugoti $count dokumentų. Vis tiek uždaryti?';
  }

  @override
  String get saveFailedDialogClose => 'Vis tiek uždaryti';

  @override
  String get saveChangesTitle => 'Issaugoti pakeitimus?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ar norite issaugoti pakeitimus faile \"$fileName\" pries uzdarant?';
  }

  @override
  String get saveButton => 'Issaugoti';

  @override
  String get discardButton => 'Atmesti';

  @override
  String get documentEdited => 'Redaguota';

  @override
  String get documentSaved => 'Issaugota';

  @override
  String get menuSettings => 'Nustatymai...';

  @override
  String get menuWindow => 'Langas';

  @override
  String get menuMinimize => 'Sumažinti';

  @override
  String get menuZoom => 'Mastelis';

  @override
  String get menuBringAllToFront => 'Visus į priekį';

  @override
  String get settingsTitle => 'Nustatymai';

  @override
  String get settingsLanguage => 'Kalba';

  @override
  String get settingsLanguageSystem => 'Sistemos numatytoji';

  @override
  String get settingsUnits => 'Matavimo vienetai';

  @override
  String get settingsUnitsCentimeters => 'Centimetrai';

  @override
  String get settingsUnitsInches => 'Coliai';

  @override
  String get settingsSearchLanguages => 'Ieškoti kalbų...';

  @override
  String get settingsGeneral => 'Bendra';

  @override
  String get addImage => 'Pridėti vaizdą';

  @override
  String get selectImages => 'Pasirinkti vaizdus';

  @override
  String get zoomFitWidth => 'Pritaikyti pločiui';

  @override
  String get zoomIn => 'Priartinti';

  @override
  String get zoomOut => 'Atitolinti';

  @override
  String get selectZoomLevel => 'Pasirinkti mastelio lygį';

  @override
  String get goToPage => 'Eiti į puslapį';

  @override
  String get go => 'Eiti';

  @override
  String get savePdfAs => 'Išsaugoti PDF kaip';

  @override
  String get incorrectPassword => 'Neteisingas slaptažodis';

  @override
  String get saveFailed => 'Išsaugoti nepavyko';

  @override
  String savedTo(String path) {
    return 'Išsaugota: $path';
  }

  @override
  String get noOriginalPdfStored => 'Originalus PDF neišsaugotas';

  @override
  String get waitingForFolderPermission =>
      'Laukiama aplanko prieigos leidimo...';

  @override
  String get deleteButtonLabel => 'Ištrinti';

  @override
  String get deleteButtonTooltip => 'Ištrinti pasirinktą objektą';

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
