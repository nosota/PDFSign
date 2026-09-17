// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get openPdf => 'PDF-is gakhsna';

  @override
  String get selectPdf => 'PDF-is archeeva';

  @override
  String get recentFiles => 'bolodroindfeli failebi';

  @override
  String get removeFromList => 'siidan amoshla';

  @override
  String get openedNow => 'akhla gakhsnili';

  @override
  String openedMinutesAgo(int count) {
    return 'gakhsnili $count tsutis tsin';
  }

  @override
  String openedHoursAgo(int count) {
    return 'gakhsnili $count saatis tsin';
  }

  @override
  String get openedYesterday => 'gakhsnili gushin';

  @override
  String openedDaysAgo(int count) {
    return 'gakhsnili $count dghis tsin';
  }

  @override
  String get fileNotFound => 'faili ver moidzebna';

  @override
  String get fileAccessDenied => 'tsvrda akridzalulia';

  @override
  String get clearRecentFiles => 'bolodroindfeli failebis gasuptaveba';

  @override
  String get cancel => 'gaukmeba';

  @override
  String get confirm => 'dadastureba';

  @override
  String get error => 'shecdoma';

  @override
  String get ok => 'karghi';

  @override
  String get menuFile => 'Faili';

  @override
  String get menuOpen => 'Gakhsna...';

  @override
  String get menuOpenRecent => 'Bolodroindfeli';

  @override
  String get menuNoRecentFiles => 'Ar aris bolodroindfeli failebi';

  @override
  String get menuClearMenu => 'Meniuis gasuptaveba';

  @override
  String get menuSave => 'Shenakhva';

  @override
  String get menuSaveAs => 'Shenakhva rogorc...';

  @override
  String get menuSaveAll => 'ყველას შენახვა';

  @override
  String get menuShare => 'Gaziareba...';

  @override
  String get menuCloseWindow => 'Panjeris dakhetva';

  @override
  String get menuCloseAll => 'ყველას დახურვა';

  @override
  String get menuEdit => 'რედაქტირება';

  @override
  String get menuDelete => 'წაშლა';

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
  String get menuQuit => 'გასვლა PDFSign-დან';

  @override
  String get closeAllDialogTitle => 'ცვლილებების შენახვა?';

  @override
  String closeAllDialogMessage(int count) {
    return 'გსურთ შეინახოთ ცვლილებები $count დოკუმენტში დახურვამდე?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'გსურთ შეინახოთ ცვლილებები 1 დოკუმენტში დახურვამდე?';

  @override
  String get closeAllDialogSaveAll => 'ყველას შენახვა';

  @override
  String get closeAllDialogDontSave => 'არ შეინახო';

  @override
  String get closeAllDialogCancel => 'გაუქმება';

  @override
  String get saveFailedDialogTitle => 'შენახვა ვერ მოხერხდა';

  @override
  String saveFailedDialogMessage(int count) {
    return 'ვერ მოხერხდა $count დოკუმენტის შენახვა. მაინც დაიხუროს?';
  }

  @override
  String get saveFailedDialogClose => 'მაინც დახურვა';

  @override
  String get saveChangesTitle => 'Cvlilebebis shenakhva?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Gindakht shenakhat cvlilebebi \"$fileName\"-shi dakhetvamdfe?';
  }

  @override
  String get saveButton => 'Shenakhva';

  @override
  String get discardButton => 'Gaukmeba';

  @override
  String get documentEdited => 'Redaktrebuli';

  @override
  String get documentSaved => 'Shenakhuli';

  @override
  String get menuSettings => 'Parametrebi...';

  @override
  String get menuWindow => 'ფანჯარა';

  @override
  String get menuMinimize => 'შემცირება';

  @override
  String get menuZoom => 'მასშტაბირება';

  @override
  String get menuBringAllToFront => 'ყველას წინ მოტანა';

  @override
  String get settingsTitle => 'Parametrebi';

  @override
  String get settingsLanguage => 'Ena';

  @override
  String get settingsLanguageSystem => 'Sistemis nagulistseti';

  @override
  String get settingsUnits => 'Erteuelebi';

  @override
  String get settingsUnitsCentimeters => 'Santimetrebi';

  @override
  String get settingsUnitsInches => 'Diumebi';

  @override
  String get settingsSearchLanguages => 'ენების ძიება...';

  @override
  String get settingsGeneral => 'ზოგადი';

  @override
  String get addImage => 'სურათის დამატება';

  @override
  String get selectImages => 'სურათების არჩევა';

  @override
  String get zoomFitWidth => 'სიგანეზე მორგება';

  @override
  String get zoomIn => 'გადიდება';

  @override
  String get zoomOut => 'შემცირება';

  @override
  String get selectZoomLevel => 'მასშტაბის არჩევა';

  @override
  String get goToPage => 'გვერდზე გადასვლა';

  @override
  String get go => 'გადასვლა';

  @override
  String get savePdfAs => 'PDF-ის შენახვა როგორც';

  @override
  String get incorrectPassword => 'არასწორი პაროლი';

  @override
  String get saveFailed => 'შენახვა ვერ მოხერხდა';

  @override
  String savedTo(String path) {
    return 'შენახულია: $path';
  }

  @override
  String get noOriginalPdfStored => 'ორიგინალი PDF არ არის შენახული';

  @override
  String get waitingForFolderPermission =>
      'საქაღალდეზე წვდომის ნებართვის მოლოდინი...';

  @override
  String get deleteButtonLabel => 'წაშლა';

  @override
  String get deleteButtonTooltip => 'არჩეული ობიექტის წაშლა';

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
