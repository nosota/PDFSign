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
}
