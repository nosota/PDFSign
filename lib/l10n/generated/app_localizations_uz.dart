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
  String get menuShare => 'Ulashish...';

  @override
  String get menuCloseWindow => 'Oynani yopish';

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
