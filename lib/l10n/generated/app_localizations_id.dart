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
  String get menuView => 'Tampilan';

  @override
  String goToPagePrompt(int total) {
    return 'Masukkan nomor halaman (1–$total):';
  }

  @override
  String get goToPageHint => 'Nomor halaman';

  @override
  String get goToPageInvalid => 'Masukkan angka yang valid';

  @override
  String goToPageOutOfRange(int total) {
    return 'Halaman harus antara 1 dan $total';
  }

  @override
  String get menuRotateLeft => 'Putar ke kiri';

  @override
  String get menuRotateRight => 'Putar ke kanan';

  @override
  String get menuCut => 'Potong';

  @override
  String get menuCopy => 'Salin';

  @override
  String get menuPaste => 'Tempel';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Tidak ditambahkan: $count gambar melebihi $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Tidak ditambahkan: $count gambar melebihi $limit piksel';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Tidak ditambahkan: $count gambar';
  }

  @override
  String get clipboardUnavailable => 'Papan klip tidak tersedia';

  @override
  String get pasteImageFailed => 'Gambar ini tidak dapat ditambahkan';

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
  String get documentProtectedTitle => 'Dokumen ini dilindungi';

  @override
  String get documentProtectedBody =>
      'Masukkan kata sandinya untuk membuka dokumen.';

  @override
  String get passwordFieldLabel => 'Kata sandi';

  @override
  String get openDocumentButton => 'Buka';

  @override
  String get documentReadOnlyTitle => 'Dokumen ini tidak mengizinkan perubahan';

  @override
  String get documentReadOnlyBody =>
      'Dokumen dapat dibaca dan dicetak, tetapi pemiliknya tidak mengizinkan perubahan. Masukkan kata sandi pemilik untuk menyuntingnya.';

  @override
  String get enterOwnerPassword => 'Masukkan kata sandi pemilik';

  @override
  String get ownerPasswordFieldLabel => 'Kata sandi pemilik';

  @override
  String get menuPrint => 'Cetak…';

  @override
  String get menuPrintCurrentPage => 'Cetak halaman saat ini';

  @override
  String get printingIsTheOwnersTitle =>
      'Hanya pemilik yang boleh mencetak dokumen ini';

  @override
  String get printingNotAllowed => 'Dokumen ini tidak mengizinkan pencetakan.';

  @override
  String get printingFailed => 'Dokumen tidak dapat dicetak.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Hanya pemilik yang boleh mengubah perlindungan dokumen ini';

  @override
  String get continueButton => 'Lanjutkan';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Dokumen yang dilindungi ditampilkan dari memori, dan ukuran dokumen ini $size. Membukanya akan memakai memori kira-kira sebanyak itu.';
  }

  @override
  String get shareProtectedNotice =>
      'Salinan yang dibagikan tetap mempertahankan kata sandi dokumen.';

  @override
  String get unsupportedProtection =>
      'Perlindungan dokumen ini tidak didukung. PDFSign membuka dokumen yang dilindungi kata sandi, bukan yang dilindungi sertifikat.';

  @override
  String get menuBringToFront => 'Bawa ke depan';

  @override
  String get menuBringForward => 'Majukan';

  @override
  String get menuSendBackward => 'Mundurkan';

  @override
  String get menuSendToBack => 'Kirim ke belakang';

  @override
  String get zOrderGroupLabel => 'Atur';

  @override
  String get menuUndo => 'Urungkan';

  @override
  String get menuRedo => 'Ulangi';

  @override
  String get dragToReorder => 'Seret untuk mengubah urutan';

  @override
  String get protectDocumentTitle => 'Lindungi dokumen';

  @override
  String get requirePasswordToOpen => 'Minta kata sandi untuk membuka dokumen';

  @override
  String get verifyFieldLabel => 'Konfirmasi';

  @override
  String get permissionsHeading => 'Izin';

  @override
  String get permissionsNote =>
      'Izinkan perubahan berikut tanpa memasukkan kata sandi pemilik.';

  @override
  String get permissionPrinting => 'Pencetakan';

  @override
  String get permissionCopying => 'Penyalinan teks atau grafik';

  @override
  String get permissionPageAssembly =>
      'Penyisipan, penghapusan, dan pemutaran halaman';

  @override
  String get permissionAnnotations => 'Penambahan anotasi atau tanda tangan';

  @override
  String get permissionChangingContent => 'Perubahan dokumen';

  @override
  String get permissionFormFilling => 'Pengisian bidang formulir yang ada';

  @override
  String get changingContentIncludes =>
      'Perubahan dokumen mencakup pemberian anotasi dan pengisian formulir — keduanya diizinkan bersamanya.';

  @override
  String get ownerPasswordHeading => 'Kata sandi pemilik';

  @override
  String get removeProtection => 'Hapus perlindungan';

  @override
  String get applyButton => 'Terapkan';

  @override
  String get passwordsDoNotMatch => 'Kata sandi tidak cocok';

  @override
  String get passwordCannotBeEmpty => 'Masukkan kata sandi';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Pembatasan memerlukan kata sandi pemilik. Tanpa kata sandi itu, siapa pun dapat mencabutnya.';

  @override
  String get signingNeedsChangingContent =>
      'Tanpa “Perubahan dokumen”, berkas ini tidak dapat ditandatangani lagi di sini tanpa kata sandi pemilik.';

  @override
  String get menuProtectDocument => 'Lindungi dokumen…';

  @override
  String get protectButtonLabel => 'Lindungi';

  @override
  String get protectButtonTooltip => 'Tetapkan kata sandi dan izin dokumen ini';
}
