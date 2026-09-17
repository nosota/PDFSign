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
  String get menuSaveAll => 'Simpan Semua';

  @override
  String get menuShare => 'Kongsi...';

  @override
  String get menuCloseWindow => 'Tutup tetingkap';

  @override
  String get menuCloseAll => 'Tutup semua';

  @override
  String get menuEdit => 'Edit';

  @override
  String get menuDelete => 'Padam';

  @override
  String get menuView => 'Paparan';

  @override
  String goToPagePrompt(int total) {
    return 'Masukkan nombor halaman (1–$total):';
  }

  @override
  String get goToPageHint => 'Nombor halaman';

  @override
  String get goToPageInvalid => 'Masukkan nombor yang sah';

  @override
  String goToPageOutOfRange(int total) {
    return 'Halaman mesti antara 1 dan $total';
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
  String get menuPaste => 'Tampal';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Tidak ditambah: $count imej melebihi $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Tidak ditambah: $count imej melebihi $limit piksel';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Tidak ditambah: $count imej';
  }

  @override
  String get clipboardUnavailable => 'Papan keratan tidak tersedia';

  @override
  String get pasteImageFailed => 'Imej ini tidak dapat ditambah';

  @override
  String get menuQuit => 'Keluar PDFSign';

  @override
  String get closeAllDialogTitle => 'Simpan perubahan?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Adakah anda ingin menyimpan perubahan dalam $count dokumen sebelum menutup?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Adakah anda ingin menyimpan perubahan dalam 1 dokumen sebelum menutup?';

  @override
  String get closeAllDialogSaveAll => 'Simpan semua';

  @override
  String get closeAllDialogDontSave => 'Jangan simpan';

  @override
  String get closeAllDialogCancel => 'Batal';

  @override
  String get saveFailedDialogTitle => 'Simpan Gagal';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Gagal menyimpan $count dokumen. Tutup juga?';
  }

  @override
  String get saveFailedDialogClose => 'Tutup Juga';

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
  String get menuWindow => 'Tetingkap';

  @override
  String get menuMinimize => 'Kecilkan';

  @override
  String get menuZoom => 'Zum';

  @override
  String get menuBringAllToFront => 'Bawa Semua ke Hadapan';

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

  @override
  String get settingsGeneral => 'Umum';

  @override
  String get addImage => 'Tambah imej';

  @override
  String get selectImages => 'Pilih imej';

  @override
  String get zoomFitWidth => 'Muat lebar';

  @override
  String get zoomIn => 'Zum masuk';

  @override
  String get zoomOut => 'Zum keluar';

  @override
  String get selectZoomLevel => 'Pilih tahap zum';

  @override
  String get goToPage => 'Pergi ke halaman';

  @override
  String get go => 'Pergi';

  @override
  String get savePdfAs => 'Simpan PDF sebagai';

  @override
  String get incorrectPassword => 'Kata laluan salah';

  @override
  String get saveFailed => 'Gagal menyimpan';

  @override
  String savedTo(String path) {
    return 'Disimpan ke: $path';
  }

  @override
  String get noOriginalPdfStored => 'Tiada PDF asal disimpan';

  @override
  String get waitingForFolderPermission => 'Menunggu kebenaran akses folder...';

  @override
  String get deleteButtonLabel => 'Padam';

  @override
  String get deleteButtonTooltip => 'Padam objek yang dipilih';

  @override
  String get documentProtectedTitle => 'Dokumen ini dilindungi';

  @override
  String get documentProtectedBody =>
      'Masukkan kata laluannya untuk membukanya.';

  @override
  String get passwordFieldLabel => 'Kata laluan';

  @override
  String get openDocumentButton => 'Buka';

  @override
  String get documentReadOnlyTitle => 'Dokumen ini tidak membenarkan perubahan';

  @override
  String get documentReadOnlyBody =>
      'Ia boleh dibaca dan dicetak, tetapi pemiliknya tidak membenarkan perubahan. Masukkan kata laluan pemilik untuk menyuntingnya.';

  @override
  String get enterOwnerPassword => 'Masukkan kata laluan pemilik';

  @override
  String get ownerPasswordFieldLabel => 'Kata laluan pemilik';

  @override
  String get menuPrint => 'Cetak…';

  @override
  String get menuPrintCurrentPage => 'Cetak halaman semasa';

  @override
  String get printingIsTheOwnersTitle =>
      'Hanya pemilik boleh mencetak dokumen ini';

  @override
  String get printingNotAllowed => 'Dokumen ini tidak membenarkan pencetakan.';

  @override
  String get printingFailed => 'Dokumen tidak dapat dicetak.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Hanya pemilik boleh mengubah perlindungan dokumen ini';

  @override
  String get continueButton => 'Teruskan';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Dokumen yang dilindungi dipaparkan daripada memori, dan saiz dokumen ini ialah $size. Membukanya akan menggunakan lebih kurang sebanyak itu.';
  }

  @override
  String get shareProtectedNotice =>
      'Salinan yang dikongsi mengekalkan kata laluan dokumen.';

  @override
  String get unsupportedProtection =>
      'Perlindungan dokumen ini tidak disokong. PDFSign membuka dokumen yang dilindungi kata laluan, bukan yang dilindungi sijil.';

  @override
  String get menuBringToFront => 'Bawa ke hadapan sekali';

  @override
  String get menuBringForward => 'Bawa ke hadapan';

  @override
  String get menuSendBackward => 'Hantar ke belakang';

  @override
  String get menuSendToBack => 'Hantar ke belakang sekali';

  @override
  String get zOrderGroupLabel => 'Susun';

  @override
  String get menuUndo => 'Buat asal';

  @override
  String get menuRedo => 'Buat semula';

  @override
  String get dragToReorder => 'Seret untuk menukar susunan';

  @override
  String get protectDocumentTitle => 'Lindungi dokumen';

  @override
  String get requirePasswordToOpen => 'Minta kata laluan untuk membuka dokumen';

  @override
  String get verifyFieldLabel => 'Pengesahan';

  @override
  String get permissionsHeading => 'Kebenaran';

  @override
  String get permissionsNote =>
      'Benarkan perubahan berikut tanpa memasukkan kata laluan pemilik.';

  @override
  String get permissionPrinting => 'Pencetakan';

  @override
  String get permissionCopying => 'Penyalinan teks atau grafik';

  @override
  String get permissionPageAssembly =>
      'Penyisipan, pemadaman dan pemutaran halaman';

  @override
  String get permissionAnnotations => 'Penambahan anotasi atau tandatangan';

  @override
  String get permissionChangingContent => 'Perubahan dokumen';

  @override
  String get permissionFormFilling => 'Pengisian medan borang sedia ada';

  @override
  String get changingContentIncludes =>
      'Perubahan dokumen merangkumi anotasi dan pengisian borang — kedua-duanya dibenarkan bersamanya.';

  @override
  String get ownerPasswordHeading => 'Kata laluan pemilik';

  @override
  String get removeProtection => 'Buang perlindungan';

  @override
  String get applyButton => 'Guna';

  @override
  String get passwordsDoNotMatch => 'Kata laluan tidak sepadan';

  @override
  String get passwordCannotBeEmpty => 'Masukkan kata laluan';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Sekatan memerlukan kata laluan pemilik. Tanpanya, sesiapa sahaja boleh menanggalkannya.';

  @override
  String get signingNeedsChangingContent =>
      'Tanpa “Perubahan dokumen”, fail ini tidak boleh ditandatangani semula di sini tanpa kata laluan pemilik.';

  @override
  String get menuProtectDocument => 'Lindungi dokumen…';

  @override
  String get protectButtonLabel => 'Lindungi';

  @override
  String get protectButtonTooltip =>
      'Tetapkan kata laluan dan kebenaran dokumen ini';
}
