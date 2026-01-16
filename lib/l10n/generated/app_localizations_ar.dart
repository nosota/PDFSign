// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get openPdf => 'فتح PDF';

  @override
  String get selectPdf => 'اختر PDF';

  @override
  String get recentFiles => 'الملفات الأخيرة';

  @override
  String get removeFromList => 'إزالة من القائمة';

  @override
  String get openedNow => 'فُتح للتو';

  @override
  String openedMinutesAgo(int count) {
    return 'فُتح منذ $count دقيقة';
  }

  @override
  String openedHoursAgo(int count) {
    return 'فُتح منذ $count ساعة';
  }

  @override
  String get openedYesterday => 'فُتح أمس';

  @override
  String openedDaysAgo(int count) {
    return 'فُتح منذ $count يوم';
  }

  @override
  String get fileNotFound => 'الملف غير موجود';

  @override
  String get fileAccessDenied => 'تم رفض الوصول';

  @override
  String get clearRecentFiles => 'مسح الملفات الأخيرة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get error => 'خطأ';

  @override
  String get ok => 'حسناً';

  @override
  String get menuFile => 'ملف';

  @override
  String get menuOpen => 'فتح...';

  @override
  String get menuOpenRecent => 'فتح الأخيرة';

  @override
  String get menuNoRecentFiles => 'لا توجد ملفات أخيرة';

  @override
  String get menuClearMenu => 'مسح القائمة';

  @override
  String get menuSave => 'حفظ';

  @override
  String get menuSaveAs => 'حفظ باسم...';

  @override
  String get menuShare => 'مشاركة...';

  @override
  String get menuCloseWindow => 'إغلاق النافذة';

  @override
  String get saveChangesTitle => 'حفظ التغييرات؟';

  @override
  String saveChangesMessage(String fileName) {
    return 'هل تريد حفظ التغييرات في \"$fileName\" قبل الإغلاق؟';
  }

  @override
  String get saveButton => 'حفظ';

  @override
  String get discardButton => 'عدم الحفظ';

  @override
  String get documentEdited => 'تم التحرير';

  @override
  String get documentSaved => 'تم الحفظ';

  @override
  String get menuSettings => 'الإعدادات...';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageSystem => 'افتراضي النظام';

  @override
  String get settingsUnits => 'الوحدات';

  @override
  String get settingsUnitsCentimeters => 'سنتيمتر';

  @override
  String get settingsUnitsInches => 'بوصة';

  @override
  String get settingsSearchLanguages => 'البحث عن اللغات...';
}
