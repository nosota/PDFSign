// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get openPdf => 'PDF ashu';

  @override
  String get selectPdf => 'PDF tandau';

  @override
  String get recentFiles => 'Songhy fayldar';

  @override
  String get removeFromList => 'Tizimnen oshiru';

  @override
  String get openedNow => 'Kazir ashyldy';

  @override
  String openedMinutesAgo(int count) {
    return '$count minut buryn ashyldy';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count saghat buryn ashyldy';
  }

  @override
  String get openedYesterday => 'Keshe ashyldy';

  @override
  String openedDaysAgo(int count) {
    return '$count kun buryn ashyldy';
  }

  @override
  String get fileNotFound => 'Fayl tabylmady';

  @override
  String get fileAccessDenied => 'Kiru tyiym salyndy';

  @override
  String get clearRecentFiles => 'Songhy fayldardy tazalau';

  @override
  String get cancel => 'Boldyrmai';

  @override
  String get confirm => 'Rastau';

  @override
  String get error => 'Qate';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Ashu...';

  @override
  String get menuOpenRecent => 'Songhylardy ashu';

  @override
  String get menuNoRecentFiles => 'Songhy fayldar zhoq';

  @override
  String get menuClearMenu => 'Menudi tazalau';

  @override
  String get menuSave => 'Saqtau';

  @override
  String get menuSaveAs => 'Basqasha saqtau...';

  @override
  String get menuSaveAll => 'Барлығын сақтау';

  @override
  String get menuShare => 'Bolisu...';

  @override
  String get menuCloseWindow => 'Terezeni zhabu';

  @override
  String get menuCloseAll => 'Барлығын жабу';

  @override
  String get menuEdit => 'Өңдеу';

  @override
  String get menuDelete => 'Жою';

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
  String get menuQuit => 'PDFSign-нан шығу';

  @override
  String get closeAllDialogTitle => 'Өзгерістерді сақтау керек пе?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Жабу алдында $count құжаттағы өзгерістерді сақтағыңыз келе ме?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Жабу алдында 1 құжаттағы өзгерістерді сақтағыңыз келе ме?';

  @override
  String get closeAllDialogSaveAll => 'Барлығын сақтау';

  @override
  String get closeAllDialogDontSave => 'Сақтамау';

  @override
  String get closeAllDialogCancel => 'Болдырмау';

  @override
  String get saveFailedDialogTitle => 'Сақтау сәтсіз аяқталды';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count құжатты сақтау сәтсіз. Бәрібір жабу керек пе?';
  }

  @override
  String get saveFailedDialogClose => 'Бәрібір жабу';

  @override
  String get saveChangesTitle => 'Ozgeristerdi saqtau?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Zhabardyn aldynda \"$fileName\" faylyndaghy ozgeristerdi saqtaunu qalaisyz ba?';
  }

  @override
  String get saveButton => 'Saqtau';

  @override
  String get discardButton => 'Saqtamau';

  @override
  String get documentEdited => 'Ozgertildi';

  @override
  String get documentSaved => 'Saqtaldy';

  @override
  String get menuSettings => 'Parametrler...';

  @override
  String get menuWindow => 'Терезе';

  @override
  String get menuMinimize => 'Кішірейту';

  @override
  String get menuZoom => 'Масштаб';

  @override
  String get menuBringAllToFront => 'Барлығын алдыға әкелу';

  @override
  String get settingsTitle => 'Parametrler';

  @override
  String get settingsLanguage => 'Til';

  @override
  String get settingsLanguageSystem => 'Zhyie adepki';

  @override
  String get settingsUnits => 'Olshem birlkteri';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Diuym';

  @override
  String get settingsSearchLanguages => 'Тілдерді іздеу...';

  @override
  String get settingsGeneral => 'Жалпы';

  @override
  String get addImage => 'Сурет қосу';

  @override
  String get selectImages => 'Суреттерді таңдау';

  @override
  String get zoomFitWidth => 'Енге сәйкестендіру';

  @override
  String get zoomIn => 'Үлкейту';

  @override
  String get zoomOut => 'Кішірейту';

  @override
  String get selectZoomLevel => 'Масштаб деңгейін таңдау';

  @override
  String get goToPage => 'Бетке өту';

  @override
  String get go => 'Өту';

  @override
  String get savePdfAs => 'PDF ретінде сақтау';

  @override
  String get incorrectPassword => 'Құпия сөз қате';

  @override
  String get saveFailed => 'Сақтау сәтсіз';

  @override
  String savedTo(String path) {
    return 'Сақталды: $path';
  }

  @override
  String get noOriginalPdfStored => 'Түпнұсқа PDF сақталмаған';

  @override
  String get waitingForFolderPermission => 'Қалтаға кіру рұқсатын күтуде...';

  @override
  String get deleteButtonLabel => 'Жою';

  @override
  String get deleteButtonTooltip => 'Таңдалған нысанды жою';

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
