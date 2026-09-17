// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class AppLocalizationsAz extends AppLocalizations {
  AppLocalizationsAz([String locale = 'az']) : super(locale);

  @override
  String get openPdf => 'PDF ac';

  @override
  String get selectPdf => 'PDF sec';

  @override
  String get recentFiles => 'Son fayllar';

  @override
  String get removeFromList => 'Siyahidan sil';

  @override
  String get openedNow => 'Indi acildi';

  @override
  String openedMinutesAgo(int count) {
    return '$count deqiqe evvel acildi';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count saat evvel acildi';
  }

  @override
  String get openedYesterday => 'Dunen acildi';

  @override
  String openedDaysAgo(int count) {
    return '$count gun evvel acildi';
  }

  @override
  String get fileNotFound => 'Fayl tapilmadi';

  @override
  String get fileAccessDenied => 'Giris qadagandir';

  @override
  String get clearRecentFiles => 'Son fayllari temizle';

  @override
  String get cancel => 'Legv et';

  @override
  String get confirm => 'Tesdiqle';

  @override
  String get error => 'Xeta';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Ac...';

  @override
  String get menuOpenRecent => 'Sonlari ac';

  @override
  String get menuNoRecentFiles => 'Son fayllar yoxdur';

  @override
  String get menuClearMenu => 'Menyunu temizle';

  @override
  String get menuSave => 'Yadda saxla';

  @override
  String get menuSaveAs => 'Ferqli yadda saxla...';

  @override
  String get menuSaveAll => 'Hamısını saxla';

  @override
  String get menuShare => 'Payla...';

  @override
  String get menuCloseWindow => 'Pencerani bagla';

  @override
  String get menuCloseAll => 'Hamısını bağla';

  @override
  String get menuEdit => 'Redaktə';

  @override
  String get menuDelete => 'Sil';

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
  String get menuQuit => 'PDFSign-dan çıx';

  @override
  String get closeAllDialogTitle => 'Dəyişikliklər saxlanılsın?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Bağlamadan əvvəl $count sənəddəki dəyişiklikləri saxlamaq istəyirsiniz?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Bağlamadan əvvəl 1 sənəddəki dəyişiklikləri saxlamaq istəyirsiniz?';

  @override
  String get closeAllDialogSaveAll => 'Hamısını saxla';

  @override
  String get closeAllDialogDontSave => 'Saxlama';

  @override
  String get closeAllDialogCancel => 'Ləğv et';

  @override
  String get saveFailedDialogTitle => 'Saxlama uğursuz oldu';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count sənədi saxlamaq alınmadı. Yenə də bağlansın?';
  }

  @override
  String get saveFailedDialogClose => 'Yenə də bağla';

  @override
  String get saveChangesTitle => 'Deyisiklikleri yadda saxla?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Baglamadan evvel \"$fileName\" faylindaki deyisiklikleri yadda saxlamaq istersiniz?';
  }

  @override
  String get saveButton => 'Yadda saxla';

  @override
  String get discardButton => 'Legv et';

  @override
  String get documentEdited => 'Deyisdirildi';

  @override
  String get documentSaved => 'Yadda saxlanildi';

  @override
  String get menuSettings => 'Parametrler...';

  @override
  String get menuWindow => 'Pəncərə';

  @override
  String get menuMinimize => 'Kiçilt';

  @override
  String get menuZoom => 'Böyüt/Kiçilt';

  @override
  String get menuBringAllToFront => 'Hamısını öndə göstər';

  @override
  String get settingsTitle => 'Parametrler';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSystem => 'Sistem defolt';

  @override
  String get settingsUnits => 'Olcu vahidleri';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Duym';

  @override
  String get settingsSearchLanguages => 'Dil axtar...';

  @override
  String get settingsGeneral => 'Ümumi';

  @override
  String get addImage => 'Şəkil əlavə et';

  @override
  String get selectImages => 'Şəkilləri seç';

  @override
  String get zoomFitWidth => 'Enə sığdır';

  @override
  String get zoomIn => 'Yaxınlaşdır';

  @override
  String get zoomOut => 'Uzaqlaşdır';

  @override
  String get selectZoomLevel => 'Böyütmə səviyyəsini seç';

  @override
  String get goToPage => 'Səhifəyə keç';

  @override
  String get go => 'Keç';

  @override
  String get savePdfAs => 'PDF olaraq saxla';

  @override
  String get incorrectPassword => 'Yanlış şifrə';

  @override
  String get saveFailed => 'Saxlama uğursuz';

  @override
  String savedTo(String path) {
    return 'Saxlanıldı: $path';
  }

  @override
  String get noOriginalPdfStored => 'Orijinal PDF saxlanılmayıb';

  @override
  String get waitingForFolderPermission =>
      'Qovluğa giriş icazəsi gözlənilir...';

  @override
  String get deleteButtonLabel => 'Sil';

  @override
  String get deleteButtonTooltip => 'Seçilmiş obyekti sil';

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
