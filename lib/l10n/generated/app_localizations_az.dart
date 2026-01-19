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
}
