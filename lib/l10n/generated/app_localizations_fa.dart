// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get openPdf => 'باز کردن PDF';

  @override
  String get selectPdf => 'انتخاب PDF';

  @override
  String get recentFiles => 'فایل‌های اخیر';

  @override
  String get removeFromList => 'حذف از لیست';

  @override
  String get openedNow => 'همین الان باز شد';

  @override
  String openedMinutesAgo(int count) {
    return '$count دقیقه پیش باز شد';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count ساعت پیش باز شد';
  }

  @override
  String get openedYesterday => 'دیروز باز شد';

  @override
  String openedDaysAgo(int count) {
    return '$count روز پیش باز شد';
  }

  @override
  String get fileNotFound => 'فایل یافت نشد';

  @override
  String get fileAccessDenied => 'دسترسی رد شد';

  @override
  String get clearRecentFiles => 'پاک کردن فایل‌های اخیر';

  @override
  String get cancel => 'لغو';

  @override
  String get confirm => 'تایید';

  @override
  String get error => 'خطا';

  @override
  String get ok => 'باشه';

  @override
  String get menuFile => 'فایل';

  @override
  String get menuOpen => 'باز کردن...';

  @override
  String get menuOpenRecent => 'باز کردن اخیر';

  @override
  String get menuNoRecentFiles => 'فایل اخیری وجود ندارد';

  @override
  String get menuClearMenu => 'پاک کردن منو';

  @override
  String get menuSave => 'ذخیره';

  @override
  String get menuSaveAs => 'ذخیره به عنوان...';

  @override
  String get menuSaveAll => 'ذخیره همه';

  @override
  String get menuShare => 'اشتراک‌گذاری...';

  @override
  String get menuCloseWindow => 'بستن پنجره';

  @override
  String get menuCloseAll => 'بستن همه';

  @override
  String get menuEdit => 'ویرایش';

  @override
  String get menuDelete => 'حذف';

  @override
  String get menuView => 'نما';

  @override
  String goToPagePrompt(int total) {
    return 'شمارهٔ صفحه را وارد کنید (۱–$total):';
  }

  @override
  String get goToPageHint => 'شمارهٔ صفحه';

  @override
  String get goToPageInvalid => 'عدد معتبری وارد کنید';

  @override
  String goToPageOutOfRange(int total) {
    return 'صفحه باید بین ۱ و $total باشد';
  }

  @override
  String get menuRotateLeft => 'چرخش به چپ';

  @override
  String get menuRotateRight => 'چرخش به راست';

  @override
  String get menuCut => 'برش';

  @override
  String get menuCopy => 'رونوشت';

  @override
  String get menuPaste => 'چسباندن';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'افزوده نشد: $count تصویر بزرگ‌تر از $limit است';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'افزوده نشد: $count تصویر بزرگ‌تر از $limit پیکسل است';
  }

  @override
  String imagesNotAdded(int count) {
    return 'افزوده نشد: $count تصویر';
  }

  @override
  String get clipboardUnavailable => 'حافظهٔ موقت در دسترس نیست';

  @override
  String get pasteImageFailed => 'افزودن این تصویر ممکن نشد';

  @override
  String get menuQuit => 'خروج از PDFSign';

  @override
  String get closeAllDialogTitle => 'ذخیره تغییرات؟';

  @override
  String closeAllDialogMessage(int count) {
    return 'آیا می‌خواهید تغییرات در $count سند را قبل از بستن ذخیره کنید؟';
  }

  @override
  String get closeAllDialogMessageOne =>
      'آیا می‌خواهید تغییرات در 1 سند را قبل از بستن ذخیره کنید؟';

  @override
  String get closeAllDialogSaveAll => 'ذخیره همه';

  @override
  String get closeAllDialogDontSave => 'ذخیره نکن';

  @override
  String get closeAllDialogCancel => 'لغو';

  @override
  String get saveFailedDialogTitle => 'ذخیره ناموفق';

  @override
  String saveFailedDialogMessage(int count) {
    return 'ذخیره $count سند ناموفق بود. به هر حال ببندید؟';
  }

  @override
  String get saveFailedDialogClose => 'به هر حال ببند';

  @override
  String get saveChangesTitle => 'ذخیره تغییرات؟';

  @override
  String saveChangesMessage(String fileName) {
    return 'آیا می‌خواهید تغییرات در \"$fileName\" را قبل از بستن ذخیره کنید؟';
  }

  @override
  String get saveButton => 'ذخیره';

  @override
  String get discardButton => 'ذخیره نکن';

  @override
  String get documentEdited => 'ویرایش شده';

  @override
  String get documentSaved => 'ذخیره شد';

  @override
  String get menuSettings => 'تنظیمات...';

  @override
  String get menuWindow => 'پنجره';

  @override
  String get menuMinimize => 'کوچک‌سازی';

  @override
  String get menuZoom => 'بزرگ‌نمایی';

  @override
  String get menuBringAllToFront => 'همه را جلو بیاور';

  @override
  String get settingsTitle => 'تنظیمات';

  @override
  String get settingsLanguage => 'زبان';

  @override
  String get settingsLanguageSystem => 'پیش‌فرض سیستم';

  @override
  String get settingsUnits => 'واحدها';

  @override
  String get settingsUnitsCentimeters => 'سانتی‌متر';

  @override
  String get settingsUnitsInches => 'اینچ';

  @override
  String get settingsSearchLanguages => 'جستجوی زبان‌ها...';

  @override
  String get settingsGeneral => 'عمومی';

  @override
  String get addImage => 'افزودن تصویر';

  @override
  String get selectImages => 'انتخاب تصاویر';

  @override
  String get zoomFitWidth => 'تناسب با عرض';

  @override
  String get zoomIn => 'بزرگنمایی';

  @override
  String get zoomOut => 'کوچک‌نمایی';

  @override
  String get selectZoomLevel => 'انتخاب سطح بزرگنمایی';

  @override
  String get goToPage => 'رفتن به صفحه';

  @override
  String get go => 'برو';

  @override
  String get savePdfAs => 'ذخیره PDF به عنوان';

  @override
  String get incorrectPassword => 'رمز عبور نادرست';

  @override
  String get saveFailed => 'ذخیره ناموفق';

  @override
  String savedTo(String path) {
    return 'ذخیره شده در: $path';
  }

  @override
  String get noOriginalPdfStored => 'PDF اصلی ذخیره نشده است';

  @override
  String get waitingForFolderPermission => 'در انتظار اجازه دسترسی به پوشه...';

  @override
  String get deleteButtonLabel => 'حذف';

  @override
  String get deleteButtonTooltip => 'حذف شیء انتخاب شده';

  @override
  String get documentProtectedTitle => 'این سند محافظت‌شده است';

  @override
  String get documentProtectedBody => 'برای باز کردن آن گذرواژه را وارد کنید.';

  @override
  String get passwordFieldLabel => 'گذرواژه';

  @override
  String get openDocumentButton => 'باز کردن';

  @override
  String get documentReadOnlyTitle => 'این سند اجازهٔ تغییر نمی‌دهد';

  @override
  String get documentReadOnlyBody =>
      'می‌توان آن را خواند و چاپ کرد، اما مالک اجازهٔ تغییر نداده است. برای ویرایش، گذرواژهٔ مالک را وارد کنید.';

  @override
  String get enterOwnerPassword => 'وارد کردن گذرواژهٔ مالک';

  @override
  String get ownerPasswordFieldLabel => 'گذرواژهٔ مالک';

  @override
  String get menuPrint => 'چاپ…';

  @override
  String get menuPrintCurrentPage => 'چاپ صفحهٔ جاری';

  @override
  String get printingIsTheOwnersTitle =>
      'تنها مالک می‌تواند این سند را چاپ کند';

  @override
  String get printingNotAllowed => 'این سند اجازهٔ چاپ نمی‌دهد.';

  @override
  String get printingFailed => 'چاپ سند ممکن نشد.';

  @override
  String get protectionIsTheOwnersTitle =>
      'تنها مالک می‌تواند محافظت این سند را تغییر دهد';

  @override
  String get continueButton => 'ادامه';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'سند محافظت‌شده از حافظه نمایش داده می‌شود و اندازهٔ این سند $size است. باز کردن آن تقریباً همین اندازه حافظه مصرف می‌کند.';
  }

  @override
  String get shareProtectedNotice =>
      'نسخهٔ هم‌رسانی‌شده گذرواژهٔ سند را نگه می‌دارد.';

  @override
  String get unsupportedProtection =>
      'محافظت این سند پشتیبانی نمی‌شود. PDFSign اسناد محافظت‌شده با گذرواژه را باز می‌کند، نه اسناد محافظت‌شده با گواهی.';

  @override
  String get menuBringToFront => 'انتقال به جلو';

  @override
  String get menuBringForward => 'یک لایه جلوتر';

  @override
  String get menuSendBackward => 'یک لایه عقب‌تر';

  @override
  String get menuSendToBack => 'انتقال به عقب';

  @override
  String get zOrderGroupLabel => 'چیدمان';

  @override
  String get menuUndo => 'واگرد';

  @override
  String get menuRedo => 'ازنو';

  @override
  String get dragToReorder => 'برای تغییر ترتیب بکشید';

  @override
  String get protectDocumentTitle => 'محافظت از سند';

  @override
  String get requirePasswordToOpen => 'درخواست گذرواژه برای باز کردن سند';

  @override
  String get verifyFieldLabel => 'تأیید';

  @override
  String get permissionsHeading => 'مجوزها';

  @override
  String get permissionsNote =>
      'اجازهٔ تغییرات زیر بدون وارد کردن گذرواژهٔ مالک.';

  @override
  String get permissionPrinting => 'چاپ';

  @override
  String get permissionCopying => 'رونوشت متن یا گرافیک';

  @override
  String get permissionPageAssembly => 'درج، حذف و چرخش صفحه‌ها';

  @override
  String get permissionAnnotations => 'افزودن یادداشت و امضا';

  @override
  String get permissionChangingContent => 'تغییر سند';

  @override
  String get permissionFormFilling => 'پر کردن فیلدهای موجود فرم';

  @override
  String get changingContentIncludes =>
      'تغییر سند شامل یادداشت‌گذاری و پر کردن فرم‌هاست و این‌ها همراه با آن مجاز می‌شوند.';

  @override
  String get ownerPasswordHeading => 'گذرواژهٔ مالک';

  @override
  String get removeProtection => 'برداشتن محافظت';

  @override
  String get applyButton => 'اعمال';

  @override
  String get passwordsDoNotMatch => 'گذرواژه‌ها یکسان نیستند';

  @override
  String get passwordCannotBeEmpty => 'گذرواژه‌ای وارد کنید';

  @override
  String get restrictionsNeedOwnerPassword =>
      'محدودیت‌ها به گذرواژهٔ مالک نیاز دارند. بدون آن هر کسی می‌تواند آن‌ها را بردارد.';

  @override
  String get signingNeedsChangingContent =>
      'بدون «تغییر سند» این پرونده دیگر بدون گذرواژهٔ مالک در اینجا امضا نخواهد شد.';

  @override
  String get menuProtectDocument => 'محافظت از سند…';

  @override
  String get protectButtonLabel => 'محافظت';

  @override
  String get protectButtonTooltip =>
      'گذرواژه‌ها و مجوزهای این سند را تعیین کنید';
}
