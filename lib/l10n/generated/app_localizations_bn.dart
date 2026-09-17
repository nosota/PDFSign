// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get openPdf => 'PDF khulun';

  @override
  String get selectPdf => 'PDF bachun';

  @override
  String get recentFiles => 'Sompratik file';

  @override
  String get removeFromList => 'Taliqa theke mochun';

  @override
  String get openedNow => 'Ekhonoi khola hoyeche';

  @override
  String openedMinutesAgo(int count) {
    return '$count minute age khola hoyeche';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count ghonta age khola hoyeche';
  }

  @override
  String get openedYesterday => 'Gatokal khola hoyeche';

  @override
  String openedDaysAgo(int count) {
    return '$count din age khola hoyeche';
  }

  @override
  String get fileNotFound => 'File paoa jayni';

  @override
  String get fileAccessDenied => 'Probesh nishiddho';

  @override
  String get clearRecentFiles => 'Sompratik file mochun';

  @override
  String get cancel => 'Batal';

  @override
  String get confirm => 'Nischit';

  @override
  String get error => 'Truti';

  @override
  String get ok => 'Thik ache';

  @override
  String get menuFile => 'ফাইল';

  @override
  String get menuOpen => 'Khulun...';

  @override
  String get menuOpenRecent => 'Sompratik khulun';

  @override
  String get menuNoRecentFiles => 'Kono sompratik file nei';

  @override
  String get menuClearMenu => 'Menu mochun';

  @override
  String get menuSave => 'Sanchhoy korun';

  @override
  String get menuSaveAs => 'Erup sanchhoy korun...';

  @override
  String get menuSaveAll => 'সব সংরক্ষণ করুন';

  @override
  String get menuShare => 'Share korun...';

  @override
  String get menuCloseWindow => 'Janala bondho korun';

  @override
  String get menuCloseAll => 'সব বন্ধ করুন';

  @override
  String get menuEdit => 'সম্পাদনা';

  @override
  String get menuDelete => 'মুছুন';

  @override
  String get menuView => 'দৃশ্য';

  @override
  String goToPagePrompt(int total) {
    return 'পৃষ্ঠার নম্বর লিখুন (1–$total):';
  }

  @override
  String get goToPageHint => 'পৃষ্ঠার নম্বর';

  @override
  String get goToPageInvalid => 'বৈধ সংখ্যা লিখুন';

  @override
  String goToPageOutOfRange(int total) {
    return 'পৃষ্ঠা 1 থেকে $total-এর মধ্যে হতে হবে';
  }

  @override
  String get menuRotateLeft => 'বাঁ দিকে ঘোরান';

  @override
  String get menuRotateRight => 'ডান দিকে ঘোরান';

  @override
  String get menuCut => 'কাটুন';

  @override
  String get menuCopy => 'কপি করুন';

  @override
  String get menuPaste => 'পেস্ট করুন';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'যোগ করা হয়নি: $countটি ছবি $limit ছাড়িয়ে গেছে';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'যোগ করা হয়নি: $countটি ছবি $limit পিক্সেল ছাড়িয়ে গেছে';
  }

  @override
  String imagesNotAdded(int count) {
    return 'যোগ করা হয়নি: $countটি ছবি';
  }

  @override
  String get clipboardUnavailable => 'ক্লিপবোর্ড পাওয়া যাচ্ছে না';

  @override
  String get pasteImageFailed => 'এই ছবিটি যোগ করা যায়নি';

  @override
  String get menuQuit => 'PDFSign থেকে প্রস্থান';

  @override
  String get closeAllDialogTitle => 'পরিবর্তন সংরক্ষণ করবেন?';

  @override
  String closeAllDialogMessage(int count) {
    return 'বন্ধ করার আগে $countটি নথিতে পরিবর্তন সংরক্ষণ করতে চান?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'বন্ধ করার আগে 1টি নথিতে পরিবর্তন সংরক্ষণ করতে চান?';

  @override
  String get closeAllDialogSaveAll => 'সব সংরক্ষণ করুন';

  @override
  String get closeAllDialogDontSave => 'সংরক্ষণ করবেন না';

  @override
  String get closeAllDialogCancel => 'বাতিল';

  @override
  String get saveFailedDialogTitle => 'সংরক্ষণ ব্যর্থ';

  @override
  String saveFailedDialogMessage(int count) {
    return '$countটি নথি সংরক্ষণ করতে ব্যর্থ। যাইহোক বন্ধ করবেন?';
  }

  @override
  String get saveFailedDialogClose => 'যাইহোক বন্ধ করুন';

  @override
  String get saveChangesTitle => 'Paribartan sanchhoy korben?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Bondho korar age \"$fileName\" file-e paribartan sanchhoy korte chan?';
  }

  @override
  String get saveButton => 'Sanchhoy korun';

  @override
  String get discardButton => 'Bajay din';

  @override
  String get documentEdited => 'Sompadito';

  @override
  String get documentSaved => 'Sanchhoy hoyeche';

  @override
  String get menuSettings => 'Settingsh...';

  @override
  String get menuWindow => 'উইন্ডো';

  @override
  String get menuMinimize => 'ছোট করুন';

  @override
  String get menuZoom => 'জুম';

  @override
  String get menuBringAllToFront => 'সব সামনে আনুন';

  @override
  String get settingsTitle => 'Settingsh';

  @override
  String get settingsLanguage => 'Bhasha';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsUnits => 'Ekai';

  @override
  String get settingsUnitsCentimeters => 'Sentimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'ভাষা অনুসন্ধান...';

  @override
  String get settingsGeneral => 'সাধারণ';

  @override
  String get addImage => 'ছবি যোগ করুন';

  @override
  String get selectImages => 'ছবি নির্বাচন করুন';

  @override
  String get zoomFitWidth => 'প্রস্থে মানানসই';

  @override
  String get zoomIn => 'জুম ইন';

  @override
  String get zoomOut => 'জুম আউট';

  @override
  String get selectZoomLevel => 'জুম স্তর নির্বাচন করুন';

  @override
  String get goToPage => 'পৃষ্ঠায় যান';

  @override
  String get go => 'যান';

  @override
  String get savePdfAs => 'PDF হিসাবে সংরক্ষণ করুন';

  @override
  String get incorrectPassword => 'ভুল পাসওয়ার্ড';

  @override
  String get saveFailed => 'সংরক্ষণ ব্যর্থ';

  @override
  String savedTo(String path) {
    return 'সংরক্ষিত: $path';
  }

  @override
  String get noOriginalPdfStored => 'কোনো মূল PDF সংরক্ষিত নেই';

  @override
  String get waitingForFolderPermission =>
      'ফোল্ডার অ্যাক্সেস অনুমতির জন্য অপেক্ষা করা হচ্ছে...';

  @override
  String get deleteButtonLabel => 'মুছুন';

  @override
  String get deleteButtonTooltip => 'নির্বাচিত বস্তু মুছুন';

  @override
  String get documentProtectedTitle => 'এই নথিটি সুরক্ষিত';

  @override
  String get documentProtectedBody => 'এটি খুলতে পাসওয়ার্ড লিখুন।';

  @override
  String get passwordFieldLabel => 'পাসওয়ার্ড';

  @override
  String get openDocumentButton => 'খুলুন';

  @override
  String get documentReadOnlyTitle => 'এই নথিতে পরিবর্তনের অনুমতি নেই';

  @override
  String get documentReadOnlyBody =>
      'এটি পড়া ও মুদ্রণ করা যায়, তবে মালিক পরিবর্তনের অনুমতি দেননি। সম্পাদনা করতে মালিকের পাসওয়ার্ড লিখুন।';

  @override
  String get enterOwnerPassword => 'মালিকের পাসওয়ার্ড লিখুন';

  @override
  String get ownerPasswordFieldLabel => 'মালিকের পাসওয়ার্ড';

  @override
  String get menuPrint => 'মুদ্রণ…';

  @override
  String get menuPrintCurrentPage => 'বর্তমান পৃষ্ঠা মুদ্রণ করুন';

  @override
  String get printingIsTheOwnersTitle =>
      'এই নথিটি কেবল মালিকই মুদ্রণ করতে পারেন';

  @override
  String get printingNotAllowed => 'এই নথিতে মুদ্রণের অনুমতি নেই।';

  @override
  String get printingFailed => 'নথিটি মুদ্রণ করা যায়নি।';

  @override
  String get protectionIsTheOwnersTitle =>
      'এই নথির সুরক্ষা কেবল মালিকই পরিবর্তন করতে পারেন';

  @override
  String get continueButton => 'চালিয়ে যান';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'সুরক্ষিত নথি স্মৃতি থেকে দেখানো হয়, আর এটির আকার $size। এটি খুলতে প্রায় ততটাই স্মৃতি লাগবে।';
  }

  @override
  String get shareProtectedNotice =>
      'ভাগ করা অনুলিপিটি নথির পাসওয়ার্ড ধরে রাখে।';

  @override
  String get unsupportedProtection =>
      'এই নথির সুরক্ষা সমর্থিত নয়। PDFSign পাসওয়ার্ড দিয়ে সুরক্ষিত নথি খোলে, সনদ দিয়ে সুরক্ষিত নথি নয়।';

  @override
  String get menuBringToFront => 'সবার সামনে আনুন';

  @override
  String get menuBringForward => 'সামনে আনুন';

  @override
  String get menuSendBackward => 'পিছনে পাঠান';

  @override
  String get menuSendToBack => 'সবার পিছনে পাঠান';

  @override
  String get zOrderGroupLabel => 'সাজান';

  @override
  String get menuUndo => 'পূর্বাবস্থায় ফিরুন';

  @override
  String get menuRedo => 'পুনরায় করুন';

  @override
  String get dragToReorder => 'ক্রম বদলাতে টেনে আনুন';

  @override
  String get protectDocumentTitle => 'নথি সুরক্ষিত করুন';

  @override
  String get requirePasswordToOpen => 'নথি খুলতে পাসওয়ার্ড চাওয়া হোক';

  @override
  String get verifyFieldLabel => 'নিশ্চিতকরণ';

  @override
  String get permissionsHeading => 'অনুমতি';

  @override
  String get permissionsNote =>
      'মালিকের পাসওয়ার্ড না দিয়েই নিচের পরিবর্তনগুলির অনুমতি দিন।';

  @override
  String get permissionPrinting => 'মুদ্রণ';

  @override
  String get permissionCopying => 'লেখা বা ছবি কপি করা';

  @override
  String get permissionPageAssembly => 'পৃষ্ঠা যোগ, মুছে ফেলা ও ঘোরানো';

  @override
  String get permissionAnnotations => 'টীকা বা স্বাক্ষর যোগ করা';

  @override
  String get permissionChangingContent => 'নথি পরিবর্তন করা';

  @override
  String get permissionFormFilling => 'বিদ্যমান ফর্ম ক্ষেত্র পূরণ করা';

  @override
  String get changingContentIncludes =>
      'নথি পরিবর্তনের মধ্যে টীকা দেওয়া ও ফর্ম পূরণ করাও পড়ে — সেগুলিও একসঙ্গে অনুমোদিত হয়।';

  @override
  String get ownerPasswordHeading => 'মালিকের পাসওয়ার্ড';

  @override
  String get removeProtection => 'সুরক্ষা সরান';

  @override
  String get applyButton => 'প্রয়োগ করুন';

  @override
  String get passwordsDoNotMatch => 'পাসওয়ার্ড দুটি মিলছে না';

  @override
  String get passwordCannotBeEmpty => 'পাসওয়ার্ড লিখুন';

  @override
  String get restrictionsNeedOwnerPassword =>
      'বিধিনিষেধের জন্য মালিকের পাসওয়ার্ড দরকার। সেটি ছাড়া যে কেউ সেগুলি তুলে দিতে পারে।';

  @override
  String get signingNeedsChangingContent =>
      '“নথি পরিবর্তন করা” ছাড়া মালিকের পাসওয়ার্ড না দিলে এই ফাইলে এখানে আর স্বাক্ষর করা যাবে না।';

  @override
  String get menuProtectDocument => 'নথি সুরক্ষিত করুন…';

  @override
  String get protectButtonLabel => 'সুরক্ষা';

  @override
  String get protectButtonTooltip =>
      'এই নথির পাসওয়ার্ড ও অনুমতি নির্ধারণ করুন';
}
