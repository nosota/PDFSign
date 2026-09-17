// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get openPdf => 'PDF Aç';

  @override
  String get selectPdf => 'PDF Seç';

  @override
  String get recentFiles => 'Son dosyalar';

  @override
  String get removeFromList => 'Listeden kaldır';

  @override
  String get openedNow => 'Az önce açıldı';

  @override
  String openedMinutesAgo(int count) {
    return '$count dakika önce açıldı';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count saat önce açıldı';
  }

  @override
  String get openedYesterday => 'Dün açıldı';

  @override
  String openedDaysAgo(int count) {
    return '$count gün önce açıldı';
  }

  @override
  String get fileNotFound => 'Dosya bulunamadı';

  @override
  String get fileAccessDenied => 'Erişim reddedildi';

  @override
  String get clearRecentFiles => 'Son dosyaları temizle';

  @override
  String get cancel => 'İptal';

  @override
  String get confirm => 'Onayla';

  @override
  String get error => 'Hata';

  @override
  String get ok => 'Tamam';

  @override
  String get menuFile => 'Dosya';

  @override
  String get menuOpen => 'Aç...';

  @override
  String get menuOpenRecent => 'Son Kullanılanları Aç';

  @override
  String get menuNoRecentFiles => 'Son dosya yok';

  @override
  String get menuClearMenu => 'Menüyü Temizle';

  @override
  String get menuSave => 'Kaydet';

  @override
  String get menuSaveAs => 'Farklı Kaydet...';

  @override
  String get menuSaveAll => 'Tümünü Kaydet';

  @override
  String get menuShare => 'Paylaş...';

  @override
  String get menuCloseWindow => 'Pencereyi Kapat';

  @override
  String get menuCloseAll => 'Tümünü Kapat';

  @override
  String get menuEdit => 'Düzenle';

  @override
  String get menuDelete => 'Sil';

  @override
  String get menuView => 'Görünüm';

  @override
  String goToPagePrompt(int total) {
    return 'Sayfa numarasını girin (1–$total):';
  }

  @override
  String get goToPageHint => 'Sayfa numarası';

  @override
  String get goToPageInvalid => 'Geçerli bir sayı girin';

  @override
  String goToPageOutOfRange(int total) {
    return 'Sayfa 1 ile $total arasında olmalıdır';
  }

  @override
  String get menuRotateLeft => 'Sola Döndür';

  @override
  String get menuRotateRight => 'Sağa Döndür';

  @override
  String get menuCut => 'Kes';

  @override
  String get menuCopy => 'Kopyala';

  @override
  String get menuPaste => 'Yapıştır';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Eklenmedi: $count görüntü $limit sınırını aşıyor';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Eklenmedi: $count görüntü $limit piksel sınırını aşıyor';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Eklenmedi: $count görüntü';
  }

  @override
  String get clipboardUnavailable => 'Pano kullanılamıyor';

  @override
  String get pasteImageFailed => 'Bu görüntü eklenemedi';

  @override
  String get menuQuit => 'PDFSign\'dan Çık';

  @override
  String get closeAllDialogTitle => 'Değişiklikler kaydedilsin mi?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Kapatmadan önce $count belgedeki değişiklikleri kaydetmek istiyor musunuz?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Kapatmadan önce 1 belgedeki değişiklikleri kaydetmek istiyor musunuz?';

  @override
  String get closeAllDialogSaveAll => 'Tümünü Kaydet';

  @override
  String get closeAllDialogDontSave => 'Kaydetme';

  @override
  String get closeAllDialogCancel => 'İptal';

  @override
  String get saveFailedDialogTitle => 'Kaydetme başarısız';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count belge kaydedilemedi. Yine de kapatılsın mı?';
  }

  @override
  String get saveFailedDialogClose => 'Yine de Kapat';

  @override
  String get saveChangesTitle => 'Değişiklikler kaydedilsin mi?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Kapatmadan önce \"$fileName\" dosyasındaki değişiklikleri kaydetmek istiyor musunuz?';
  }

  @override
  String get saveButton => 'Kaydet';

  @override
  String get discardButton => 'Kaydetme';

  @override
  String get documentEdited => 'Düzenlendi';

  @override
  String get documentSaved => 'Kaydedildi';

  @override
  String get menuSettings => 'Ayarlar...';

  @override
  String get menuWindow => 'Pencere';

  @override
  String get menuMinimize => 'Simge Durumuna Küçült';

  @override
  String get menuZoom => 'Büyüt/Küçült';

  @override
  String get menuBringAllToFront => 'Tümünü Öne Getir';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSystem => 'Sistem varsayılanı';

  @override
  String get settingsUnits => 'Birimler';

  @override
  String get settingsUnitsCentimeters => 'Santimetre';

  @override
  String get settingsUnitsInches => 'İnç';

  @override
  String get settingsSearchLanguages => 'Dil ara...';

  @override
  String get settingsGeneral => 'Genel';

  @override
  String get addImage => 'Resim ekle';

  @override
  String get selectImages => 'Resimleri seç';

  @override
  String get zoomFitWidth => 'Genişliğe sığdır';

  @override
  String get zoomIn => 'Yakınlaştır';

  @override
  String get zoomOut => 'Uzaklaştır';

  @override
  String get selectZoomLevel => 'Yakınlaştırma seviyesi seç';

  @override
  String get goToPage => 'Sayfaya git';

  @override
  String get go => 'Git';

  @override
  String get savePdfAs => 'PDF olarak kaydet';

  @override
  String get incorrectPassword => 'Hatalı şifre';

  @override
  String get saveFailed => 'Kaydetme başarısız';

  @override
  String savedTo(String path) {
    return 'Kaydedildi: $path';
  }

  @override
  String get noOriginalPdfStored => 'Orijinal PDF kaydedilmedi';

  @override
  String get waitingForFolderPermission => 'Klasör erişim izni bekleniyor...';

  @override
  String get deleteButtonLabel => 'Sil';

  @override
  String get deleteButtonTooltip => 'Seçili nesneyi sil';

  @override
  String get documentProtectedTitle => 'Bu belge korumalı';

  @override
  String get documentProtectedBody => 'Açmak için parolasını girin.';

  @override
  String get passwordFieldLabel => 'Parola';

  @override
  String get openDocumentButton => 'Aç';

  @override
  String get documentReadOnlyTitle => 'Bu belge değişikliğe izin vermiyor';

  @override
  String get documentReadOnlyBody =>
      'Okunabilir ve yazdırılabilir, ancak sahibi değiştirilmesine izin vermemiş. Düzenlemek için sahip parolasını girin.';

  @override
  String get enterOwnerPassword => 'Sahip parolasını gir';

  @override
  String get ownerPasswordFieldLabel => 'Sahip parolası';

  @override
  String get menuPrint => 'Yazdır…';

  @override
  String get menuPrintCurrentPage => 'Geçerli Sayfayı Yazdır';

  @override
  String get printingIsTheOwnersTitle =>
      'Bu belgeyi yalnızca sahibi yazdırabilir';

  @override
  String get printingNotAllowed => 'Bu belge yazdırmaya izin vermiyor.';

  @override
  String get printingFailed => 'Belge yazdırılamadı.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Bu belgenin korumasını yalnızca sahibi değiştirebilir';

  @override
  String get continueButton => 'Devam';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Korumalı bir belge bellekten gösterilir; bu belge $size boyutunda. Açılması yaklaşık olarak bu kadar bellek kullanır.';
  }

  @override
  String get shareProtectedNotice =>
      'Paylaşılan kopya belgenin parolasını korur.';

  @override
  String get unsupportedProtection =>
      'Bu belgenin koruması desteklenmiyor. PDFSign parolayla korunan belgeleri açar, sertifikayla korunanları değil.';

  @override
  String get menuBringToFront => 'En Öne Getir';

  @override
  String get menuBringForward => 'Öne Getir';

  @override
  String get menuSendBackward => 'Arkaya Gönder';

  @override
  String get menuSendToBack => 'En Arkaya Gönder';

  @override
  String get zOrderGroupLabel => 'Düzenle';

  @override
  String get menuUndo => 'Geri Al';

  @override
  String get menuRedo => 'Yinele';

  @override
  String get dragToReorder => 'Sırayı değiştirmek için sürükleyin';

  @override
  String get protectDocumentTitle => 'Belgeyi Koru';

  @override
  String get requirePasswordToOpen => 'Belgeyi açmak için parola iste';

  @override
  String get verifyFieldLabel => 'Doğrulama';

  @override
  String get permissionsHeading => 'İzinler';

  @override
  String get permissionsNote =>
      'Aşağıdaki değişikliklere sahip parolası girilmeden izin ver.';

  @override
  String get permissionPrinting => 'Yazdırma';

  @override
  String get permissionCopying => 'Metin veya grafik kopyalama';

  @override
  String get permissionPageAssembly => 'Sayfa ekleme, silme ve döndürme';

  @override
  String get permissionAnnotations => 'Açıklama ve imza ekleme';

  @override
  String get permissionChangingContent => 'Belgeyi değiştirme';

  @override
  String get permissionFormFilling => 'Var olan form alanlarını doldurma';

  @override
  String get changingContentIncludes =>
      'Belgeyi değiştirme, açıklama ekleme ve form doldurmayı da kapsar; bunlar onunla birlikte verilir.';

  @override
  String get ownerPasswordHeading => 'Sahip parolası';

  @override
  String get removeProtection => 'Korumayı Kaldır';

  @override
  String get applyButton => 'Uygula';

  @override
  String get passwordsDoNotMatch => 'Parolalar eşleşmiyor';

  @override
  String get passwordCannotBeEmpty => 'Bir parola girin';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Kısıtlamalar bir sahip parolası gerektirir. Parola olmadan herkes bunları kaldırabilir.';

  @override
  String get signingNeedsChangingContent =>
      '“Belgeyi değiştirme” izni olmadan bu dosya, sahip parolası girilmeden burada yeniden imzalanamaz.';

  @override
  String get menuProtectDocument => 'Belgeyi Koru…';

  @override
  String get protectButtonLabel => 'Koru';

  @override
  String get protectButtonTooltip =>
      'Bu belgenin parolalarını ve izinlerini ayarla';
}
