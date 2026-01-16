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
  String get menuShare => 'اشتراک‌گذاری...';

  @override
  String get menuCloseWindow => 'بستن پنجره';

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
}
