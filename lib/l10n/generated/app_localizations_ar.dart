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
  String get menuSaveAll => 'حفظ الكل';

  @override
  String get menuShare => 'مشاركة...';

  @override
  String get menuCloseWindow => 'إغلاق النافذة';

  @override
  String get menuCloseAll => 'إغلاق الكل';

  @override
  String get menuEdit => 'تحرير';

  @override
  String get menuDelete => 'حذف';

  @override
  String get menuView => 'عرض';

  @override
  String goToPagePrompt(int total) {
    return 'أدخل رقم الصفحة (1–$total):';
  }

  @override
  String get goToPageHint => 'رقم الصفحة';

  @override
  String get goToPageInvalid => 'أدخل رقمًا صحيحًا';

  @override
  String goToPageOutOfRange(int total) {
    return 'يجب أن تكون الصفحة بين 1 و$total';
  }

  @override
  String get menuRotateLeft => 'تدوير لليسار';

  @override
  String get menuRotateRight => 'تدوير لليمين';

  @override
  String get menuCut => 'قص';

  @override
  String get menuCopy => 'نسخ';

  @override
  String get menuPaste => 'لصق';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'لم تُضَف صور: $count — تتجاوز $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'لم تُضَف صور: $count — تتجاوز $limit بكسل';
  }

  @override
  String imagesNotAdded(int count) {
    return 'لم تُضَف صور: $count';
  }

  @override
  String get clipboardUnavailable => 'الحافظة غير متاحة';

  @override
  String get pasteImageFailed => 'تعذّرت إضافة هذه الصورة';

  @override
  String get menuQuit => 'إنهاء PDFSign';

  @override
  String get closeAllDialogTitle => 'حفظ التغييرات؟';

  @override
  String closeAllDialogMessage(int count) {
    return 'هل تريد حفظ التغييرات في $count مستند قبل الإغلاق؟';
  }

  @override
  String get closeAllDialogMessageOne =>
      'هل تريد حفظ التغييرات في مستند واحد قبل الإغلاق؟';

  @override
  String get closeAllDialogSaveAll => 'حفظ الكل';

  @override
  String get closeAllDialogDontSave => 'عدم الحفظ';

  @override
  String get closeAllDialogCancel => 'إلغاء';

  @override
  String get saveFailedDialogTitle => 'فشل الحفظ';

  @override
  String saveFailedDialogMessage(int count) {
    return 'فشل حفظ $count مستند(مستندات). هل تريد الإغلاق على أي حال؟';
  }

  @override
  String get saveFailedDialogClose => 'إغلاق على أي حال';

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
  String get menuWindow => 'نافذة';

  @override
  String get menuMinimize => 'تصغير';

  @override
  String get menuZoom => 'تكبير/تصغير';

  @override
  String get menuBringAllToFront => 'إظهار الكل في المقدمة';

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

  @override
  String get settingsGeneral => 'عام';

  @override
  String get addImage => 'إضافة صورة';

  @override
  String get selectImages => 'اختيار الصور';

  @override
  String get zoomFitWidth => 'ملاءمة العرض';

  @override
  String get zoomIn => 'تكبير';

  @override
  String get zoomOut => 'تصغير';

  @override
  String get selectZoomLevel => 'اختر مستوى التكبير';

  @override
  String get goToPage => 'الانتقال إلى صفحة';

  @override
  String get go => 'انتقال';

  @override
  String get savePdfAs => 'حفظ PDF باسم';

  @override
  String get incorrectPassword => 'كلمة المرور غير صحيحة';

  @override
  String get saveFailed => 'فشل الحفظ';

  @override
  String savedTo(String path) {
    return 'تم الحفظ في: $path';
  }

  @override
  String get noOriginalPdfStored => 'لا يوجد ملف PDF أصلي محفوظ';

  @override
  String get waitingForFolderPermission => 'في انتظار إذن الوصول إلى المجلد...';

  @override
  String get deleteButtonLabel => 'حذف';

  @override
  String get deleteButtonTooltip => 'حذف العنصر المحدد';

  @override
  String get documentProtectedTitle => 'هذا المستند محمي';

  @override
  String get documentProtectedBody => 'أدخل كلمة السر لفتحه.';

  @override
  String get passwordFieldLabel => 'كلمة السر';

  @override
  String get openDocumentButton => 'فتح';

  @override
  String get documentReadOnlyTitle => 'لا يسمح هذا المستند بالتعديل';

  @override
  String get documentReadOnlyBody =>
      'يمكن قراءته وطباعته، لكن مالكه لم يسمح بتعديله. أدخل كلمة سر المالك لتحريره.';

  @override
  String get enterOwnerPassword => 'إدخال كلمة سر المالك';

  @override
  String get ownerPasswordFieldLabel => 'كلمة سر المالك';

  @override
  String get menuPrint => 'طباعة…';

  @override
  String get menuPrintCurrentPage => 'طباعة الصفحة الحالية';

  @override
  String get printingIsTheOwnersTitle => 'لا يجوز طباعة هذا المستند إلا للمالك';

  @override
  String get printingNotAllowed => 'لا يسمح هذا المستند بالطباعة.';

  @override
  String get printingFailed => 'تعذّرت طباعة المستند.';

  @override
  String get protectionIsTheOwnersTitle =>
      'لا يجوز تغيير حماية هذا المستند إلا للمالك';

  @override
  String get continueButton => 'متابعة';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'يُعرض المستند المحمي من الذاكرة، وحجم هذا المستند $size. سيستهلك فتحه قدرًا مماثلًا تقريبًا.';
  }

  @override
  String get shareProtectedNotice => 'تحتفظ النسخة المشتركة بكلمة سر المستند.';

  @override
  String get unsupportedProtection =>
      'حماية هذا المستند غير مدعومة. يفتح PDFSign المستندات المحمية بكلمة سر، لا المحمية بشهادة.';

  @override
  String get menuBringToFront => 'إحضار إلى المقدمة';

  @override
  String get menuBringForward => 'تقديم خطوة';

  @override
  String get menuSendBackward => 'تأخير خطوة';

  @override
  String get menuSendToBack => 'إرسال إلى الخلف';

  @override
  String get zOrderGroupLabel => 'ترتيب';

  @override
  String get menuUndo => 'تراجع';

  @override
  String get menuRedo => 'إعادة';

  @override
  String get dragToReorder => 'اسحب لتغيير الترتيب';

  @override
  String get protectDocumentTitle => 'حماية المستند';

  @override
  String get requirePasswordToOpen => 'طلب كلمة سر لفتح المستند';

  @override
  String get verifyFieldLabel => 'التأكيد';

  @override
  String get permissionsHeading => 'الأذونات';

  @override
  String get permissionsNote =>
      'السماح بالتغييرات التالية دون إدخال كلمة سر المالك.';

  @override
  String get permissionPrinting => 'الطباعة';

  @override
  String get permissionCopying => 'نسخ النص أو الرسومات';

  @override
  String get permissionPageAssembly => 'إدراج الصفحات وحذفها وتدويرها';

  @override
  String get permissionAnnotations => 'إضافة التعليقات والتوقيعات';

  @override
  String get permissionChangingContent => 'تغيير المستند';

  @override
  String get permissionFormFilling => 'تعبئة حقول النماذج الموجودة';

  @override
  String get changingContentIncludes =>
      'يشمل تغيير المستند التعليق وتعبئة النماذج، وهما مسموحان معه.';

  @override
  String get ownerPasswordHeading => 'كلمة سر المالك';

  @override
  String get removeProtection => 'إزالة الحماية';

  @override
  String get applyButton => 'تطبيق';

  @override
  String get passwordsDoNotMatch => 'كلمتا السر غير متطابقتين';

  @override
  String get passwordCannotBeEmpty => 'أدخل كلمة سر';

  @override
  String get restrictionsNeedOwnerPassword =>
      'تتطلب القيود كلمة سر للمالك. فبدونها يستطيع أي شخص رفعها.';

  @override
  String get signingNeedsChangingContent =>
      'بدون «تغيير المستند» لن يمكن توقيع هذا الملف هنا مرة أخرى دون كلمة سر المالك.';

  @override
  String get menuProtectDocument => 'حماية المستند…';

  @override
  String get protectButtonLabel => 'حماية';

  @override
  String get protectButtonTooltip => 'حدّد كلمات سر هذا المستند وأذوناته';
}
