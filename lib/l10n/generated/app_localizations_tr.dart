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
  String get menuShare => 'Paylaş...';

  @override
  String get menuCloseWindow => 'Pencereyi Kapat';

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
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Add Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get zoomFitWidth => 'Fit Width';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get selectZoomLevel => 'Select zoom level';

  @override
  String get goToPage => 'Go to Page';

  @override
  String get go => 'Go';

  @override
  String get savePdfAs => 'Save PDF As';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get saveFailed => 'Save failed';

  @override
  String savedTo(String path) {
    return 'Saved to: $path';
  }

  @override
  String get noOriginalPdfStored => 'No original PDF stored';
}
