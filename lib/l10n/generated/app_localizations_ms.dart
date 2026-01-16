// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get openPdf => 'Buka PDF';

  @override
  String get selectPdf => 'Pilih PDF';

  @override
  String get recentFiles => 'Fail terkini';

  @override
  String get removeFromList => 'Alih keluar dari senarai';

  @override
  String get openedNow => 'Baru dibuka';

  @override
  String openedMinutesAgo(int count) {
    return 'Dibuka $count minit lalu';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Dibuka $count jam lalu';
  }

  @override
  String get openedYesterday => 'Dibuka semalam';

  @override
  String openedDaysAgo(int count) {
    return 'Dibuka $count hari lalu';
  }

  @override
  String get fileNotFound => 'Fail tidak dijumpai';

  @override
  String get fileAccessDenied => 'Akses ditolak';

  @override
  String get clearRecentFiles => 'Kosongkan fail terkini';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Sahkan';

  @override
  String get error => 'Ralat';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fail';

  @override
  String get menuOpen => 'Buka...';

  @override
  String get menuOpenRecent => 'Buka terkini';

  @override
  String get menuNoRecentFiles => 'Tiada fail terkini';

  @override
  String get menuClearMenu => 'Kosongkan menu';

  @override
  String get menuSave => 'Simpan';

  @override
  String get menuSaveAs => 'Simpan sebagai...';

  @override
  String get menuShare => 'Kongsi...';

  @override
  String get menuCloseWindow => 'Tutup tetingkap';

  @override
  String get saveChangesTitle => 'Simpan perubahan?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Adakah anda ingin menyimpan perubahan dalam \"$fileName\" sebelum menutup?';
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
  String get menuSettings => 'Tetapan...';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageSystem => 'Lalai sistem';

  @override
  String get settingsUnits => 'Unit';

  @override
  String get settingsUnitsCentimeters => 'Sentimeter';

  @override
  String get settingsUnitsInches => 'Inci';

  @override
  String get settingsSearchLanguages => 'Cari bahasa...';
}
