// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get openPdf => 'Ava PDF';

  @override
  String get selectPdf => 'Vali PDF';

  @override
  String get recentFiles => 'Hiljutised failid';

  @override
  String get removeFromList => 'Eemalda loendist';

  @override
  String get openedNow => 'Asja avatud';

  @override
  String openedMinutesAgo(int count) {
    return 'Avatud $count minutit tagasi';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Avatud $count tundi tagasi';
  }

  @override
  String get openedYesterday => 'Avatud eile';

  @override
  String openedDaysAgo(int count) {
    return 'Avatud $count paeva tagasi';
  }

  @override
  String get fileNotFound => 'Faili ei leitud';

  @override
  String get fileAccessDenied => 'Juurdepaaas keelatud';

  @override
  String get clearRecentFiles => 'Tuehjenda hiljutised failid';

  @override
  String get cancel => 'Tuehista';

  @override
  String get confirm => 'Kinnita';

  @override
  String get error => 'Viga';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fail';

  @override
  String get menuOpen => 'Ava...';

  @override
  String get menuOpenRecent => 'Ava hiljutised';

  @override
  String get menuNoRecentFiles => 'Hiljutisi faile pole';

  @override
  String get menuClearMenu => 'Tuehjenda menyy';

  @override
  String get menuSave => 'Salvesta';

  @override
  String get menuSaveAs => 'Salvesta kui...';

  @override
  String get menuSaveAll => 'Salvesta kõik';

  @override
  String get menuShare => 'Jaga...';

  @override
  String get menuCloseWindow => 'Sulge aken';

  @override
  String get menuCloseAll => 'Sulge kõik';

  @override
  String get menuEdit => 'Redigeeri';

  @override
  String get menuDelete => 'Kustuta';

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
  String get menuQuit => 'Välju PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvesta muudatused?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Kas soovite salvestada muudatused $count dokumendis enne sulgemist?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Kas soovite salvestada muudatused 1 dokumendis enne sulgemist?';

  @override
  String get closeAllDialogSaveAll => 'Salvesta kõik';

  @override
  String get closeAllDialogDontSave => 'Ära salvesta';

  @override
  String get closeAllDialogCancel => 'Tühista';

  @override
  String get saveFailedDialogTitle => 'Salvestamine ebaõnnestus';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count dokumendi salvestamine ebaõnnestus. Kas sulgeda siiski?';
  }

  @override
  String get saveFailedDialogClose => 'Sulge siiski';

  @override
  String get saveChangesTitle => 'Salvesta muudatused?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Kas soovite salvestada muudatused failis \"$fileName\" enne sulgemist?';
  }

  @override
  String get saveButton => 'Salvesta';

  @override
  String get discardButton => 'Ara salvesta';

  @override
  String get documentEdited => 'Muudetud';

  @override
  String get documentSaved => 'Salvestatud';

  @override
  String get menuSettings => 'Seaded...';

  @override
  String get menuWindow => 'Aken';

  @override
  String get menuMinimize => 'Minimeeri';

  @override
  String get menuZoom => 'Suumi';

  @override
  String get menuBringAllToFront => 'Too kõik ette';

  @override
  String get settingsTitle => 'Seaded';

  @override
  String get settingsLanguage => 'Keel';

  @override
  String get settingsLanguageSystem => 'Systeemi vaikevaartus';

  @override
  String get settingsUnits => 'Uhikud';

  @override
  String get settingsUnitsCentimeters => 'Sentimeetrid';

  @override
  String get settingsUnitsInches => 'Tollid';

  @override
  String get settingsSearchLanguages => 'Otsi keeli...';

  @override
  String get settingsGeneral => 'Üldine';

  @override
  String get addImage => 'Lisa pilt';

  @override
  String get selectImages => 'Vali pildid';

  @override
  String get zoomFitWidth => 'Sobita laiusega';

  @override
  String get zoomIn => 'Suurenda';

  @override
  String get zoomOut => 'Vähenda';

  @override
  String get selectZoomLevel => 'Vali suurenduse tase';

  @override
  String get goToPage => 'Mine leheküljele';

  @override
  String get go => 'Mine';

  @override
  String get savePdfAs => 'Salvesta PDF kui';

  @override
  String get incorrectPassword => 'Vale parool';

  @override
  String get saveFailed => 'Salvestamine ebaõnnestus';

  @override
  String savedTo(String path) {
    return 'Salvestatud: $path';
  }

  @override
  String get noOriginalPdfStored => 'Algset PDF-i pole salvestatud';

  @override
  String get waitingForFolderPermission => 'Kausta juurdepääsu loa ootamine...';

  @override
  String get deleteButtonLabel => 'Kustuta';

  @override
  String get deleteButtonTooltip => 'Kustuta valitud objekt';

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
