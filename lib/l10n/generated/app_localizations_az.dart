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
  String get menuView => 'Görünüş';

  @override
  String goToPagePrompt(int total) {
    return 'Səhifə nömrəsini daxil edin (1–$total):';
  }

  @override
  String get goToPageHint => 'Səhifə nömrəsi';

  @override
  String get goToPageInvalid => 'Düzgün rəqəm daxil edin';

  @override
  String goToPageOutOfRange(int total) {
    return 'Səhifə 1 ilə $total arasında olmalıdır';
  }

  @override
  String get menuRotateLeft => 'Sola çevir';

  @override
  String get menuRotateRight => 'Sağa çevir';

  @override
  String get menuCut => 'Kəs';

  @override
  String get menuCopy => 'Kopyala';

  @override
  String get menuPaste => 'Yapışdır';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Əlavə edilmədi: $count şəkil $limit həddini aşır';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Əlavə edilmədi: $count şəkil $limit piksel həddini aşır';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Əlavə edilmədi: $count şəkil';
  }

  @override
  String get clipboardUnavailable => 'Mübadilə buferi əlçatan deyil';

  @override
  String get pasteImageFailed => 'Bu şəkil əlavə edilə bilmədi';

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
  String get documentProtectedTitle => 'Bu sənəd qorunur';

  @override
  String get documentProtectedBody => 'Onu açmaq üçün parolu daxil edin.';

  @override
  String get passwordFieldLabel => 'Parol';

  @override
  String get openDocumentButton => 'Aç';

  @override
  String get documentReadOnlyTitle => 'Bu sənəd dəyişikliyə icazə vermir';

  @override
  String get documentReadOnlyBody =>
      'Onu oxumaq və çap etmək olar, lakin sahibi dəyişikliyə icazə verməyib. Redaktə etmək üçün sahib parolunu daxil edin.';

  @override
  String get enterOwnerPassword => 'Sahib parolunu daxil et';

  @override
  String get ownerPasswordFieldLabel => 'Sahib parolu';

  @override
  String get menuPrint => 'Çap et…';

  @override
  String get menuPrintCurrentPage => 'Cari səhifəni çap et';

  @override
  String get printingIsTheOwnersTitle =>
      'Bu sənədi yalnız sahibi çap edə bilər';

  @override
  String get printingNotAllowed => 'Bu sənəd çapa icazə vermir.';

  @override
  String get printingFailed => 'Sənədi çap etmək mümkün olmadı.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Bu sənədin qorunmasını yalnız sahibi dəyişə bilər';

  @override
  String get continueButton => 'Davam et';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Qorunan sənəd yaddaşdan göstərilir, bunun ölçüsü isə $size-dır. Onu açmaq təxminən bir o qədər yaddaş tutacaq.';
  }

  @override
  String get shareProtectedNotice =>
      'Paylaşılan nüsxə sənədin parolunu saxlayır.';

  @override
  String get unsupportedProtection =>
      'Bu sənədin qorunması dəstəklənmir. PDFSign parolla qorunan sənədləri açır, sertifikatla qorunanları yox.';

  @override
  String get menuBringToFront => 'Ən önə gətir';

  @override
  String get menuBringForward => 'Önə gətir';

  @override
  String get menuSendBackward => 'Arxaya göndər';

  @override
  String get menuSendToBack => 'Ən arxaya göndər';

  @override
  String get zOrderGroupLabel => 'Düz';

  @override
  String get menuUndo => 'Geri al';

  @override
  String get menuRedo => 'Təkrarla';

  @override
  String get dragToReorder => 'Sıranı dəyişmək üçün dartın';

  @override
  String get protectDocumentTitle => 'Sənədin qorunması';

  @override
  String get requirePasswordToOpen => 'Sənədi açmaq üçün parol tələb olunsun';

  @override
  String get verifyFieldLabel => 'Təsdiq';

  @override
  String get permissionsHeading => 'İcazələr';

  @override
  String get permissionsNote =>
      'Aşağıdakı dəyişikliklərə sahib parolu daxil edilmədən icazə verilsin.';

  @override
  String get permissionPrinting => 'Çap';

  @override
  String get permissionCopying => 'Mətnin və ya qrafikanın kopyalanması';

  @override
  String get permissionPageAssembly =>
      'Səhifələrin əlavə edilməsi, silinməsi və çevrilməsi';

  @override
  String get permissionAnnotations => 'Qeydlərin və imzaların əlavə edilməsi';

  @override
  String get permissionChangingContent => 'Sənədin dəyişdirilməsi';

  @override
  String get permissionFormFilling => 'Mövcud forma sahələrinin doldurulması';

  @override
  String get changingContentIncludes =>
      'Sənədin dəyişdirilməsi qeyd etməyi və formaların doldurulmasını da əhatə edir — onlar bununla birlikdə icazəlidir.';

  @override
  String get ownerPasswordHeading => 'Sahib parolu';

  @override
  String get removeProtection => 'Qorunmanı sil';

  @override
  String get applyButton => 'Tətbiq et';

  @override
  String get passwordsDoNotMatch => 'Parollar uyğun gəlmir';

  @override
  String get passwordCannotBeEmpty => 'Parol daxil edin';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Məhdudiyyətlər üçün sahib parolu lazımdır. Onsuz onları istənilən şəxs götürə bilər.';

  @override
  String get signingNeedsChangingContent =>
      '“Sənədin dəyişdirilməsi” olmadan bu fayl sahib parolu daxil edilmədən burada yenidən imzalana bilməz.';

  @override
  String get menuProtectDocument => 'Sənədi qoru…';

  @override
  String get protectButtonLabel => 'Qoru';

  @override
  String get protectButtonTooltip =>
      'Bu sənədin parollarını və icazələrini təyin edin';
}
