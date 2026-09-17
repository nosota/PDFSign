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
  String get menuSaveAll => 'Simpan Semua';

  @override
  String get menuShare => 'Bagikan...';

  @override
  String get menuCloseWindow => 'Tutup jendela';

  @override
  String get menuCloseAll => 'Tutup semua';

  @override
  String get menuEdit => 'Edit';

  @override
  String get menuDelete => 'Hapus';

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
  String get menuQuit => 'Keluar dari PDFSign';

  @override
  String get closeAllDialogTitle => 'Simpan perubahan?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Apakah Anda ingin menyimpan perubahan di $count dokumen sebelum menutup?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Apakah Anda ingin menyimpan perubahan di 1 dokumen sebelum menutup?';

  @override
  String get closeAllDialogSaveAll => 'Simpan semua';

  @override
  String get closeAllDialogDontSave => 'Jangan simpan';

  @override
  String get closeAllDialogCancel => 'Batal';

  @override
  String get saveFailedDialogTitle => 'Penyimpanan Gagal';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Gagal menyimpan $count dokumen. Tetap tutup?';
  }

  @override
  String get saveFailedDialogClose => 'Tetap Tutup';

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
  String get menuWindow => 'Jendela';

  @override
  String get menuMinimize => 'Perkecil';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Bawa Semua ke Depan';

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
  String get settingsGeneral => 'Umum';

  @override
  String get addImage => 'Tambah gambar';

  @override
  String get selectImages => 'Pilih gambar';

  @override
  String get zoomFitWidth => 'Sesuaikan lebar';

  @override
  String get zoomIn => 'Perbesar';

  @override
  String get zoomOut => 'Perkecil';

  @override
  String get selectZoomLevel => 'Pilih tingkat zoom';

  @override
  String get goToPage => 'Pergi ke halaman';

  @override
  String get go => 'Pergi';

  @override
  String get savePdfAs => 'Simpan PDF sebagai';

  @override
  String get incorrectPassword => 'Kata sandi salah';

  @override
  String get saveFailed => 'Gagal menyimpan';

  @override
  String savedTo(String path) {
    return 'Disimpan ke: $path';
  }

  @override
  String get noOriginalPdfStored => 'Tidak ada PDF asli tersimpan';

  @override
  String get waitingForFolderPermission => 'Menunggu izin akses folder...';

  @override
  String get deleteButtonLabel => 'Hapus';

  @override
  String get deleteButtonTooltip => 'Hapus objek yang dipilih';

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

  @override
  String get dragToReorder => 'Drag to reorder';
}
