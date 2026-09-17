// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Albanian (`sq`).
class AppLocalizationsSq extends AppLocalizations {
  AppLocalizationsSq([String locale = 'sq']) : super(locale);

  @override
  String get openPdf => 'Hap PDF';

  @override
  String get selectPdf => 'Zgjidh PDF';

  @override
  String get recentFiles => 'Skedaret e fundit';

  @override
  String get removeFromList => 'Hiq nga lista';

  @override
  String get openedNow => 'Sapo u hap';

  @override
  String openedMinutesAgo(int count) {
    return 'U hap $count minuta me pare';
  }

  @override
  String openedHoursAgo(int count) {
    return 'U hap $count ore me pare';
  }

  @override
  String get openedYesterday => 'U hap dje';

  @override
  String openedDaysAgo(int count) {
    return 'U hap $count dite me pare';
  }

  @override
  String get fileNotFound => 'Skedari nuk u gjet';

  @override
  String get fileAccessDenied => 'Qasja e refuzuar';

  @override
  String get clearRecentFiles => 'Pastro skedaret e fundit';

  @override
  String get cancel => 'Anullo';

  @override
  String get confirm => 'Konfirmo';

  @override
  String get error => 'Gabim';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Skedar';

  @override
  String get menuOpen => 'Hap...';

  @override
  String get menuOpenRecent => 'Hap te fundit';

  @override
  String get menuNoRecentFiles => 'Nuk ka skedare te fundit';

  @override
  String get menuClearMenu => 'Pastro menune';

  @override
  String get menuSave => 'Ruaj';

  @override
  String get menuSaveAs => 'Ruaj si...';

  @override
  String get menuSaveAll => 'Ruaj të gjitha';

  @override
  String get menuShare => 'Ndaj...';

  @override
  String get menuCloseWindow => 'Mbyll dritaren';

  @override
  String get menuCloseAll => 'Mbyll të gjitha';

  @override
  String get menuEdit => 'Ndrysho';

  @override
  String get menuDelete => 'Fshi';

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
  String get menuQuit => 'Dil nga PDFSign';

  @override
  String get closeAllDialogTitle => 'Ruaj ndryshimet?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Dëshironi të ruani ndryshimet në $count dokumente para se të mbyllni?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Dëshironi të ruani ndryshimet në 1 dokument para se të mbyllni?';

  @override
  String get closeAllDialogSaveAll => 'Ruaj të gjitha';

  @override
  String get closeAllDialogDontSave => 'Mos ruaj';

  @override
  String get closeAllDialogCancel => 'Anulo';

  @override
  String get saveFailedDialogTitle => 'Ruajtja dështoi';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Dështoi ruajtja e $count dokumenteve. Mbyll gjithsesi?';
  }

  @override
  String get saveFailedDialogClose => 'Mbyll Gjithsesi';

  @override
  String get saveChangesTitle => 'Ruaj ndryshimet?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deshironi te ruani ndryshimet ne \"$fileName\" para se te mbyllni?';
  }

  @override
  String get saveButton => 'Ruaj';

  @override
  String get discardButton => 'Mos ruaj';

  @override
  String get documentEdited => 'I redaktuar';

  @override
  String get documentSaved => 'U ruajt';

  @override
  String get menuSettings => 'Cilesimet...';

  @override
  String get menuWindow => 'Dritare';

  @override
  String get menuMinimize => 'Minimizo';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Sill Të Gjitha Para';

  @override
  String get settingsTitle => 'Cilesimet';

  @override
  String get settingsLanguage => 'Gjuha';

  @override
  String get settingsLanguageSystem => 'Parazgjedhja e sistemit';

  @override
  String get settingsUnits => 'Njesite';

  @override
  String get settingsUnitsCentimeters => 'Centimetra';

  @override
  String get settingsUnitsInches => 'Inca';

  @override
  String get settingsSearchLanguages => 'Kërko gjuhët...';

  @override
  String get settingsGeneral => 'Të përgjithshme';

  @override
  String get addImage => 'Shto imazh';

  @override
  String get selectImages => 'Zgjidh imazhe';

  @override
  String get zoomFitWidth => 'Përshtat gjerësinë';

  @override
  String get zoomIn => 'Zmadho';

  @override
  String get zoomOut => 'Zvogëlo';

  @override
  String get selectZoomLevel => 'Zgjidh nivelin e zmadhimit';

  @override
  String get goToPage => 'Shko te faqja';

  @override
  String get go => 'Shko';

  @override
  String get savePdfAs => 'Ruaj PDF si';

  @override
  String get incorrectPassword => 'Fjalëkalim i gabuar';

  @override
  String get saveFailed => 'Ruajtja dështoi';

  @override
  String savedTo(String path) {
    return 'U ruajt në: $path';
  }

  @override
  String get noOriginalPdfStored => 'Asnjë PDF origjinal i ruajtur';

  @override
  String get waitingForFolderPermission =>
      'Duke pritur lejen e qasjes në dosje...';

  @override
  String get deleteButtonLabel => 'Fshi';

  @override
  String get deleteButtonTooltip => 'Fshi objektin e zgjedhur';

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
