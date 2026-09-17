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
  String get menuPrint => 'Print…';

  @override
  String get menuPrintCurrentPage => 'Print Current Page';

  @override
  String get printingIsTheOwnersTitle =>
      'Only the owner may print this document';

  @override
  String get printingNotAllowed => 'This document does not allow printing.';

  @override
  String get printingFailed => 'The document could not be printed.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Only the owner may change this document\'s protection';

  @override
  String get continueButton => 'Continue';

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

  @override
  String get protectDocumentTitle => 'Protect Document';

  @override
  String get requirePasswordToOpen => 'Require Password To Open Document';

  @override
  String get verifyFieldLabel => 'Verify';

  @override
  String get permissionsHeading => 'Permissions';

  @override
  String get permissionsNote =>
      'Allow the following changes to be made without entering the owner password.';

  @override
  String get permissionPrinting => 'Printing';

  @override
  String get permissionCopying => 'Copying Text or Graphics';

  @override
  String get permissionPageAssembly => 'Inserting, Deleting, or Rotating Pages';

  @override
  String get permissionAnnotations => 'Adding Annotations or Signatures';

  @override
  String get permissionChangingContent => 'Changing the Document';

  @override
  String get permissionFormFilling => 'Filling Existing Form Fields';

  @override
  String get changingContentIncludes =>
      'Changing the document includes annotating and filling in forms, so those are granted with it.';

  @override
  String get ownerPasswordHeading => 'Owner Password';

  @override
  String get removeProtection => 'Remove Protection';

  @override
  String get applyButton => 'Apply';

  @override
  String get passwordsDoNotMatch => 'The passwords do not match';

  @override
  String get passwordCannotBeEmpty => 'Enter a password';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Restrictions need an owner password. Without one, anyone can lift them.';

  @override
  String get signingNeedsChangingContent =>
      'Without “Changing the Document”, this file cannot be signed here again unless the owner password is given.';

  @override
  String get menuProtectDocument => 'Protect Document…';

  @override
  String get protectButtonLabel => 'Protect';

  @override
  String get protectButtonTooltip =>
      'Set this document\'s passwords and permissions';
}
