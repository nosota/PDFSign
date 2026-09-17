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
  String get menuSaveAll => 'Barchasini saqlash';

  @override
  String get menuShare => 'Ulashish...';

  @override
  String get menuCloseWindow => 'Oynani yopish';

  @override
  String get menuCloseAll => 'Barchasini yopish';

  @override
  String get menuEdit => 'Tahrirlash';

  @override
  String get menuDelete => 'O\'chirish';

  @override
  String get menuView => 'Ko‘rinish';

  @override
  String goToPagePrompt(int total) {
    return 'Sahifa raqamini kiriting (1–$total):';
  }

  @override
  String get goToPageHint => 'Sahifa raqami';

  @override
  String get goToPageInvalid => 'To‘g‘ri son kiriting';

  @override
  String goToPageOutOfRange(int total) {
    return 'Sahifa 1 bilan $total orasida bo‘lishi kerak';
  }

  @override
  String get menuRotateLeft => 'Chapga burish';

  @override
  String get menuRotateRight => 'O‘ngga burish';

  @override
  String get menuCut => 'Qirqib olish';

  @override
  String get menuCopy => 'Nusxalash';

  @override
  String get menuPaste => 'Qo‘yish';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Qo‘shilmadi: $count ta rasm $limit dan katta';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Qo‘shilmadi: $count ta rasm $limit pikseldan katta';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Qo‘shilmadi: $count ta rasm';
  }

  @override
  String get clipboardUnavailable => 'Almashish buferi mavjud emas';

  @override
  String get pasteImageFailed => 'Bu rasmni qo‘shib bo‘lmadi';

  @override
  String get menuQuit => 'PDFSign-dan chiqish';

  @override
  String get closeAllDialogTitle => 'O\'zgarishlarni saqlash?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Yopishdan oldin $count hujjatdagi o\'zgarishlarni saqlamoqchimisiz?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Yopishdan oldin 1 hujjatdagi o\'zgarishlarni saqlamoqchimisiz?';

  @override
  String get closeAllDialogSaveAll => 'Barchasini saqlash';

  @override
  String get closeAllDialogDontSave => 'Saqlamaslik';

  @override
  String get closeAllDialogCancel => 'Bekor qilish';

  @override
  String get saveFailedDialogTitle => 'Saqlash muvaffaqiyatsiz';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count ta hujjatni saqlash muvaffaqiyatsiz. Baribir yopilsinmi?';
  }

  @override
  String get saveFailedDialogClose => 'Baribir yopish';

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
  String get menuWindow => 'Oyna';

  @override
  String get menuMinimize => 'Kichiklashtirish';

  @override
  String get menuZoom => 'Masshtab';

  @override
  String get menuBringAllToFront => 'Barchasini oldinga olib kelish';

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
  String get settingsGeneral => 'Umumiy';

  @override
  String get addImage => 'Rasm qoʻshish';

  @override
  String get selectImages => 'Rasmlarni tanlash';

  @override
  String get zoomFitWidth => 'Kenglikka moslashtirish';

  @override
  String get zoomIn => 'Kattalashtirish';

  @override
  String get zoomOut => 'Kichiklashtirish';

  @override
  String get selectZoomLevel => 'Masshtab darajasini tanlash';

  @override
  String get goToPage => 'Sahifaga oʻtish';

  @override
  String get go => 'Oʻtish';

  @override
  String get savePdfAs => 'PDF sifatida saqlash';

  @override
  String get incorrectPassword => 'Notoʻgʻri parol';

  @override
  String get saveFailed => 'Saqlash muvaffaqiyatsiz';

  @override
  String savedTo(String path) {
    return 'Saqlandi: $path';
  }

  @override
  String get noOriginalPdfStored => 'Asl PDF saqlanmagan';

  @override
  String get waitingForFolderPermission =>
      'Jildga kirish ruxsati kutilmoqda...';

  @override
  String get deleteButtonLabel => 'O\'chirish';

  @override
  String get deleteButtonTooltip => 'Tanlangan obyektni o\'chirish';

  @override
  String get documentProtectedTitle => 'Bu hujjat himoyalangan';

  @override
  String get documentProtectedBody => 'Uni ochish uchun parolni kiriting.';

  @override
  String get passwordFieldLabel => 'Parol';

  @override
  String get openDocumentButton => 'Ochish';

  @override
  String get documentReadOnlyTitle =>
      'Bu hujjat o‘zgartirishga ruxsat bermaydi';

  @override
  String get documentReadOnlyBody =>
      'Uni o‘qish va chop etish mumkin, ammo egasi o‘zgartirishga ruxsat bermagan. Tahrirlash uchun egasining parolini kiriting.';

  @override
  String get enterOwnerPassword => 'Egasining parolini kiritish';

  @override
  String get ownerPasswordFieldLabel => 'Egasining paroli';

  @override
  String get menuPrint => 'Chop etish…';

  @override
  String get menuPrintCurrentPage => 'Joriy sahifani chop etish';

  @override
  String get printingIsTheOwnersTitle =>
      'Bu hujjatni faqat egasi chop eta oladi';

  @override
  String get printingNotAllowed => 'Bu hujjat chop etishga ruxsat bermaydi.';

  @override
  String get printingFailed => 'Hujjatni chop etib bo‘lmadi.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Bu hujjatning himoyasini faqat egasi o‘zgartira oladi';

  @override
  String get continueButton => 'Davom etish';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Himoyalangan hujjat xotiradan ko‘rsatiladi, bu hujjatning hajmi esa $size. Uni ochish taxminan shuncha xotira ishlatadi.';
  }

  @override
  String get shareProtectedNotice =>
      'Ulashilgan nusxa hujjat parolini saqlab qoladi.';

  @override
  String get unsupportedProtection =>
      'Bu hujjatning himoyasi qo‘llab-quvvatlanmaydi. PDFSign parol bilan himoyalangan hujjatlarni ochadi, sertifikat bilan himoyalanganlarini emas.';

  @override
  String get menuBringToFront => 'Eng oldinga';

  @override
  String get menuBringForward => 'Oldinga surish';

  @override
  String get menuSendBackward => 'Orqaga surish';

  @override
  String get menuSendToBack => 'Eng orqaga';

  @override
  String get zOrderGroupLabel => 'Tartiblash';

  @override
  String get menuUndo => 'Bekor qilish';

  @override
  String get menuRedo => 'Qaytarish';

  @override
  String get dragToReorder => 'Tartibni o‘zgartirish uchun torting';

  @override
  String get protectDocumentTitle => 'Hujjatni himoyalash';

  @override
  String get requirePasswordToOpen => 'Hujjatni ochish uchun parol so‘ralsin';

  @override
  String get verifyFieldLabel => 'Tasdiqlash';

  @override
  String get permissionsHeading => 'Ruxsatlar';

  @override
  String get permissionsNote =>
      'Quyidagi o‘zgarishlarga egasining parolisiz ruxsat berilsin.';

  @override
  String get permissionPrinting => 'Chop etish';

  @override
  String get permissionCopying => 'Matn yoki grafikadan nusxa olish';

  @override
  String get permissionPageAssembly =>
      'Sahifalarni qo‘shish, o‘chirish va burish';

  @override
  String get permissionAnnotations => 'Izoh va imzolar qo‘shish';

  @override
  String get permissionChangingContent => 'Hujjatni o‘zgartirish';

  @override
  String get permissionFormFilling => 'Mavjud shakl maydonlarini to‘ldirish';

  @override
  String get changingContentIncludes =>
      'Hujjatni o‘zgartirish izoh qoldirish va shakllarni to‘ldirishni ham qamrab oladi — ular u bilan birga ruxsat etiladi.';

  @override
  String get ownerPasswordHeading => 'Egasining paroli';

  @override
  String get removeProtection => 'Himoyani olib tashlash';

  @override
  String get applyButton => 'Qo‘llash';

  @override
  String get passwordsDoNotMatch => 'Parollar mos kelmadi';

  @override
  String get passwordCannotBeEmpty => 'Parol kiriting';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Cheklovlar uchun egasining paroli kerak. Usiz ularni istalgan kishi olib tashlashi mumkin.';

  @override
  String get signingNeedsChangingContent =>
      '“Hujjatni o‘zgartirish” bo‘lmasa, bu faylni egasining parolisiz bu yerda qayta imzolab bo‘lmaydi.';

  @override
  String get menuProtectDocument => 'Hujjatni himoyalash…';

  @override
  String get protectButtonLabel => 'Himoyalash';

  @override
  String get protectButtonTooltip =>
      'Bu hujjatning parollari va ruxsatlarini belgilang';
}
