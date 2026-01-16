// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get openPdf => 'Buka PDF';

  @override
  String get selectPdf => 'Pilih PDF';

  @override
  String get recentFiles => 'File terbaru';

  @override
  String get removeFromList => 'Hapus dari daftar';

  @override
  String get openedNow => 'Baru dibuka';

  @override
  String openedMinutesAgo(int count) {
    return 'Dibuka $count menit yang lalu';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Dibuka $count jam yang lalu';
  }

  @override
  String get openedYesterday => 'Dibuka kemarin';

  @override
  String openedDaysAgo(int count) {
    return 'Dibuka $count hari yang lalu';
  }

  @override
  String get fileNotFound => 'File tidak ditemukan';

  @override
  String get fileAccessDenied => 'Akses ditolak';

  @override
  String get clearRecentFiles => 'Hapus file terbaru';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get error => 'Kesalahan';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Buka...';

  @override
  String get menuOpenRecent => 'Buka terbaru';

  @override
  String get menuNoRecentFiles => 'Tidak ada file terbaru';

  @override
  String get menuClearMenu => 'Hapus menu';

  @override
  String get menuSave => 'Simpan';

  @override
  String get menuSaveAs => 'Simpan sebagai...';

  @override
  String get menuShare => 'Bagikan...';

  @override
  String get menuCloseWindow => 'Tutup jendela';

  @override
  String get saveChangesTitle => 'Simpan perubahan?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Apakah Anda ingin menyimpan perubahan di \"$fileName\" sebelum menutup?';
  }

  @override
  String get saveButton => 'Simpan';

  @override
  String get discardButton => 'Jangan simpan';

  @override
  String get documentEdited => 'Diedit';

  @override
  String get documentSaved => 'Disimpan';

  @override
  String get menuSettings => 'Pengaturan...';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageSystem => 'Default sistem';

  @override
  String get settingsUnits => 'Satuan';

  @override
  String get settingsUnitsCentimeters => 'Sentimeter';

  @override
  String get settingsUnitsInches => 'Inci';

  @override
  String get settingsSearchLanguages => 'Cari bahasa...';

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
