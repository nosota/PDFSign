// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get openPdf => 'PDF ochish';

  @override
  String get selectPdf => 'PDF tanlash';

  @override
  String get recentFiles => 'Soʻnggi fayllar';

  @override
  String get removeFromList => 'Roʻyxatdan oʻchirish';

  @override
  String get openedNow => 'Hozirgina ochildi';

  @override
  String openedMinutesAgo(int count) {
    return '$count daqiqa oldin ochildi';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count soat oldin ochildi';
  }

  @override
  String get openedYesterday => 'Kecha ochildi';

  @override
  String openedDaysAgo(int count) {
    return '$count kun oldin ochildi';
  }

  @override
  String get fileNotFound => 'Fayl topilmadi';

  @override
  String get fileAccessDenied => 'Kirish taqiqlangan';

  @override
  String get clearRecentFiles => 'Soʻnggi fayllarni tozalash';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get confirm => 'Tasdiqlash';

  @override
  String get error => 'Xato';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Ochish...';

  @override
  String get menuOpenRecent => 'Soʻnggilarni ochish';

  @override
  String get menuNoRecentFiles => 'Soʻnggi fayllar yoʻq';

  @override
  String get menuClearMenu => 'Menyuni tozalash';

  @override
  String get menuSave => 'Saqlash';

  @override
  String get menuSaveAs => 'Boshqacha saqlash...';

  @override
  String get menuSaveAll => 'Barchasini saqlash';

  @override
  String get menuShare => 'Ulashish...';

  @override
  String get menuCloseWindow => 'Oynani yopish';

  @override
  String get menuCloseAll => 'Barchasini yopish';

  @override
  String get menuEdit => 'Tahrirlash';

  @override
  String get menuDelete => 'O\'chirish';

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
  String get menuQuit => 'PDFSign-dan chiqish';

  @override
  String get closeAllDialogTitle => 'O\'zgarishlarni saqlash?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Yopishdan oldin $count hujjatdagi o\'zgarishlarni saqlamoqchimisiz?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Yopishdan oldin 1 hujjatdagi o\'zgarishlarni saqlamoqchimisiz?';

  @override
  String get closeAllDialogSaveAll => 'Barchasini saqlash';

  @override
  String get closeAllDialogDontSave => 'Saqlamaslik';

  @override
  String get closeAllDialogCancel => 'Bekor qilish';

  @override
  String get saveFailedDialogTitle => 'Saqlash muvaffaqiyatsiz';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count ta hujjatni saqlash muvaffaqiyatsiz. Baribir yopilsinmi?';
  }

  @override
  String get saveFailedDialogClose => 'Baribir yopish';

  @override
  String get saveChangesTitle => 'Oʻzgarishlarni saqlash?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Yopishdan oldin \"$fileName\" faylidagi oʻzgarishlarni saqlamoqchimisiz?';
  }

  @override
  String get saveButton => 'Saqlash';

  @override
  String get discardButton => 'Saqlamaslik';

  @override
  String get documentEdited => 'Tahrirlangan';

  @override
  String get documentSaved => 'Saqlandi';

  @override
  String get menuSettings => 'Sozlamalar...';

  @override
  String get menuWindow => 'Oyna';

  @override
  String get menuMinimize => 'Kichiklashtirish';

  @override
  String get menuZoom => 'Masshtab';

  @override
  String get menuBringAllToFront => 'Barchasini oldinga olib kelish';

  @override
  String get settingsTitle => 'Sozlamalar';

  @override
  String get settingsLanguage => 'Til';

  @override
  String get settingsLanguageSystem => 'Tizim standart';

  @override
  String get settingsUnits => 'Oʻlchov birliklari';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Dyuym';

  @override
  String get settingsSearchLanguages => 'Tillarni qidirish...';

  @override
  String get settingsGeneral => 'Umumiy';

  @override
  String get addImage => 'Rasm qoʻshish';

  @override
  String get selectImages => 'Rasmlarni tanlash';

  @override
  String get zoomFitWidth => 'Kenglikka moslashtirish';

  @override
  String get zoomIn => 'Kattalashtirish';

  @override
  String get zoomOut => 'Kichiklashtirish';

  @override
  String get selectZoomLevel => 'Masshtab darajasini tanlash';

  @override
  String get goToPage => 'Sahifaga oʻtish';

  @override
  String get go => 'Oʻtish';

  @override
  String get savePdfAs => 'PDF sifatida saqlash';

  @override
  String get incorrectPassword => 'Notoʻgʻri parol';

  @override
  String get saveFailed => 'Saqlash muvaffaqiyatsiz';

  @override
  String savedTo(String path) {
    return 'Saqlandi: $path';
  }

  @override
  String get noOriginalPdfStored => 'Asl PDF saqlanmagan';

  @override
  String get waitingForFolderPermission =>
      'Jildga kirish ruxsati kutilmoqda...';

  @override
  String get deleteButtonLabel => 'O\'chirish';

  @override
  String get deleteButtonTooltip => 'Tanlangan obyektni o\'chirish';

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
