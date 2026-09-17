// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get openPdf => 'PDF phwint';

  @override
  String get selectPdf => 'PDF rwe';

  @override
  String get recentFiles => 'Makhawkamhar file myar';

  @override
  String get removeFromList => 'Saryin hma hpyout';

  @override
  String get openedNow => 'Achu phwint lite';

  @override
  String openedMinutesAgo(int count) {
    return 'Minit $count u gar phwint';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Nari $count u gar phwint';
  }

  @override
  String get openedYesterday => 'Mahnekaun phwint';

  @override
  String openedDaysAgo(int count) {
    return 'Rout $count u gar phwint';
  }

  @override
  String get fileNotFound => 'File mar shi';

  @override
  String get fileAccessDenied => 'Win khwint mar rhi';

  @override
  String get clearRecentFiles => 'Makhawkamhar file myar ko shot';

  @override
  String get cancel => 'Pyet';

  @override
  String get confirm => 'Atint pyuu';

  @override
  String get error => 'Arhar';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'ဖိုင်';

  @override
  String get menuOpen => 'Phwint...';

  @override
  String get menuOpenRecent => 'Makhawkamhar phwint';

  @override
  String get menuNoRecentFiles => 'Makhawkamhar file myar mar rhi';

  @override
  String get menuClearMenu => 'Menu ko shot';

  @override
  String get menuSave => 'Thein';

  @override
  String get menuSaveAs => 'Aloat thein...';

  @override
  String get menuSaveAll => 'အားလုံးသိမ်းဆည်းပါ';

  @override
  String get menuShare => 'Mhway vway...';

  @override
  String get menuCloseWindow => 'Window peit';

  @override
  String get menuCloseAll => 'အားလုံးပိတ်ရန်';

  @override
  String get menuEdit => 'တည်းဖြတ်';

  @override
  String get menuDelete => 'ဖျက်';

  @override
  String get menuView => 'ကြည့်ရှုမှု';

  @override
  String goToPagePrompt(int total) {
    return 'စာမျက်နှာနံပါတ် ထည့်ပါ (1–$total):';
  }

  @override
  String get goToPageHint => 'စာမျက်နှာနံပါတ်';

  @override
  String get goToPageInvalid => 'မှန်ကန်သော ဂဏန်း ထည့်ပါ';

  @override
  String goToPageOutOfRange(int total) {
    return 'စာမျက်နှာသည် 1 နှင့် $total အကြား ဖြစ်ရမည်';
  }

  @override
  String get menuRotateLeft => 'ဘယ်ဘက်လှည့်';

  @override
  String get menuRotateRight => 'ညာဘက်လှည့်';

  @override
  String get menuCut => 'ဖြတ်';

  @override
  String get menuCopy => 'ကူးယူ';

  @override
  String get menuPaste => 'ကပ်';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'မထည့်နိုင်ပါ - ပုံ $count ခုသည် $limit ထက် ကြီးသည်';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'မထည့်နိုင်ပါ - ပုံ $count ခုသည် $limit ပစ်ဆယ်ထက် ကြီးသည်';
  }

  @override
  String imagesNotAdded(int count) {
    return 'မထည့်နိုင်ပါ - ပုံ $count ခု';
  }

  @override
  String get clipboardUnavailable => 'ကလစ်ဘုတ် ကို အသုံးမပြုနိုင်ပါ';

  @override
  String get pasteImageFailed => 'ဤပုံကို ထည့်၍ မရပါ';

  @override
  String get menuQuit => 'PDFSign မှထွက်ရန်';

  @override
  String get closeAllDialogTitle => 'ပြောင်းလဲမှုများသိမ်းမလား?';

  @override
  String closeAllDialogMessage(int count) {
    return 'မပိတ်မီ စာရွက်စာတမ်း $count ခုတွင် ပြောင်းလဲမှုများကို သိမ်းဆည်းလိုပါသလား?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'မပိတ်မီ စာရွက်စာတမ်း 1 ခုတွင် ပြောင်းလဲမှုများကို သိမ်းဆည်းလိုပါသလား?';

  @override
  String get closeAllDialogSaveAll => 'အားလုံးသိမ်းရန်';

  @override
  String get closeAllDialogDontSave => 'မသိမ်းပါ';

  @override
  String get closeAllDialogCancel => 'ပယ်ဖျက်ရန်';

  @override
  String get saveFailedDialogTitle => 'သိမ်းဆည်းခြင်း မအောင်မြင်ပါ';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count စာရွက်စာတမ်း သိမ်းဆည်းခြင်း မအောင်မြင်ပါ။ ဘာပဲဖြစ်ဖြစ် ပိတ်မလား?';
  }

  @override
  String get saveFailedDialogClose => 'ဘာပဲဖြစ်ဖြစ် ပိတ်ပါ';

  @override
  String get saveChangesTitle => 'Pyaunglevmhuu thein malar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Mapeitmhin \"$fileName\" hta pyaunglevmhuu thein larmalar?';
  }

  @override
  String get saveButton => 'Thein';

  @override
  String get discardButton => 'Ma thein';

  @override
  String get documentEdited => 'Pyifjyifpyi';

  @override
  String get documentSaved => 'Thein pyi';

  @override
  String get menuSettings => 'Setting myar...';

  @override
  String get menuWindow => 'ဝင်းဒိုး';

  @override
  String get menuMinimize => 'ချုံ့ရန်';

  @override
  String get menuZoom => 'ချဲ့ရန်';

  @override
  String get menuBringAllToFront => 'အားလုံးကိုရှေ့သို့ယူလာရန်';

  @override
  String get settingsTitle => 'Setting myar';

  @override
  String get settingsLanguage => 'Bhashar zagar';

  @override
  String get settingsLanguageSystem => 'System mhuu run';

  @override
  String get settingsUnits => 'Tinetunit myar';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'ဘာသာစကား ရှာရန်...';

  @override
  String get settingsGeneral => 'အထွေထွေ';

  @override
  String get addImage => 'ပုံထည့်ရန်';

  @override
  String get selectImages => 'ပုံများရွေးရန်';

  @override
  String get zoomFitWidth => 'အကျယ်နဲ့ကိုက်ညီအောင်';

  @override
  String get zoomIn => 'ချဲ့ကြည့်ရန်';

  @override
  String get zoomOut => 'ချုံ့ကြည့်ရန်';

  @override
  String get selectZoomLevel => 'ချဲ့/ချုံ့အဆင့်ရွေးရန်';

  @override
  String get goToPage => 'စာမျက်နှာသို့သွားရန်';

  @override
  String get go => 'သွားရန်';

  @override
  String get savePdfAs => 'PDF အဖြစ်သိမ်းရန်';

  @override
  String get incorrectPassword => 'စကားဝှက်မှားနေသည်';

  @override
  String get saveFailed => 'သိမ်းဆည်းမှုမအောင်မြင်ပါ';

  @override
  String savedTo(String path) {
    return 'သိမ်းဆည်းပြီး: $path';
  }

  @override
  String get noOriginalPdfStored => 'မူရင်း PDF မသိမ်းရသေးပါ';

  @override
  String get waitingForFolderPermission =>
      'ဖိုင်တွဲဝင်ရောက်ခွင့်အတွက်စောင့်ဆိုင်းနေသည်...';

  @override
  String get deleteButtonLabel => 'ဖျက်ရန်';

  @override
  String get deleteButtonTooltip => 'ရွေးချယ်ထားသော အရာဝတ္ထုကို ဖျက်ရန်';

  @override
  String get documentProtectedTitle => 'ဤစာရွက်စာတမ်းကို ကာကွယ်ထားသည်';

  @override
  String get documentProtectedBody => 'ဖွင့်ရန် စကားဝှက် ထည့်ပါ။';

  @override
  String get passwordFieldLabel => 'စကားဝှက်';

  @override
  String get openDocumentButton => 'ဖွင့်';

  @override
  String get documentReadOnlyTitle => 'ဤစာရွက်စာတမ်းသည် ပြင်ဆင်ခွင့် မပေးပါ';

  @override
  String get documentReadOnlyBody =>
      'ဖတ်ရှုနိုင်၊ ပုံနှိပ်နိုင်သော်လည်း ပိုင်ရှင်က ပြင်ဆင်ခွင့် မပေးထားပါ။ တည်းဖြတ်ရန် ပိုင်ရှင်၏ စကားဝှက်ကို ထည့်ပါ။';

  @override
  String get enterOwnerPassword => 'ပိုင်ရှင်၏ စကားဝှက် ထည့်ပါ';

  @override
  String get ownerPasswordFieldLabel => 'ပိုင်ရှင်၏ စကားဝှက်';

  @override
  String get menuPrint => 'ပုံနှိပ်…';

  @override
  String get menuPrintCurrentPage => 'လက်ရှိစာမျက်နှာ ပုံနှိပ်';

  @override
  String get printingIsTheOwnersTitle =>
      'ဤစာရွက်စာတမ်းကို ပိုင်ရှင်သာ ပုံနှိပ်နိုင်သည်';

  @override
  String get printingNotAllowed => 'ဤစာရွက်စာတမ်းသည် ပုံနှိပ်ခွင့် မပေးပါ။';

  @override
  String get printingFailed => 'စာရွက်စာတမ်းကို ပုံနှိပ်၍ မရပါ။';

  @override
  String get protectionIsTheOwnersTitle =>
      'ဤစာရွက်စာတမ်း၏ ကာကွယ်မှုကို ပိုင်ရှင်သာ ပြောင်းနိုင်သည်';

  @override
  String get continueButton => 'ဆက်လက်';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'ကာကွယ်ထားသော စာရွက်စာတမ်းကို မှတ်ဉာဏ်မှ ပြသပြီး ဤဖိုင်၏ အရွယ်အစားမှာ $size ဖြစ်သည်။ ဖွင့်ရန် ထိုမျှလောက် မှတ်ဉာဏ် သုံးမည်။';
  }

  @override
  String get shareProtectedNotice =>
      'မျှဝေထားသော မိတ္တူသည် စာရွက်စာတမ်း၏ စကားဝှက်ကို ဆက်လက်ထားရှိသည်။';

  @override
  String get unsupportedProtection =>
      'ဤစာရွက်စာတမ်း၏ ကာကွယ်မှုကို မပံ့ပိုးပါ။ PDFSign သည် စကားဝှက်ဖြင့် ကာကွယ်ထားသော ဖိုင်များကို ဖွင့်ပြီး လက်မှတ်ဖြင့် ကာကွယ်ထားသည်များကို မဖွင့်နိုင်ပါ။';

  @override
  String get menuBringToFront => 'ရှေ့ဆုံးသို့ ရွှေ့';

  @override
  String get menuBringForward => 'ရှေ့သို့ ရွှေ့';

  @override
  String get menuSendBackward => 'နောက်သို့ ရွှေ့';

  @override
  String get menuSendToBack => 'နောက်ဆုံးသို့ ရွှေ့';

  @override
  String get zOrderGroupLabel => 'စီစဉ်';

  @override
  String get menuUndo => 'နောက်ပြန်';

  @override
  String get menuRedo => 'ပြန်လုပ်';

  @override
  String get dragToReorder => 'အစီအစဉ် ပြောင်းရန် ဆွဲပါ';

  @override
  String get protectDocumentTitle => 'စာရွက်စာတမ်း ကာကွယ်ရန်';

  @override
  String get requirePasswordToOpen => 'စာရွက်စာတမ်း ဖွင့်ရန် စကားဝှက် တောင်းပါ';

  @override
  String get verifyFieldLabel => 'အတည်ပြုချက်';

  @override
  String get permissionsHeading => 'ခွင့်ပြုချက်များ';

  @override
  String get permissionsNote =>
      'ပိုင်ရှင်၏ စကားဝှက် မထည့်ဘဲ အောက်ပါ ပြင်ဆင်မှုများကို ခွင့်ပြုပါ။';

  @override
  String get permissionPrinting => 'ပုံနှိပ်ခြင်း';

  @override
  String get permissionCopying => 'စာသား သို့မဟုတ် ဂရပ်ဖစ် ကူးယူခြင်း';

  @override
  String get permissionPageAssembly =>
      'စာမျက်နှာ ထည့်ခြင်း၊ ဖျက်ခြင်းနှင့် လှည့်ခြင်း';

  @override
  String get permissionAnnotations => 'မှတ်ချက် သို့မဟုတ် လက်မှတ် ထည့်ခြင်း';

  @override
  String get permissionChangingContent => 'စာရွက်စာတမ်း ပြင်ဆင်ခြင်း';

  @override
  String get permissionFormFilling => 'ရှိပြီးသား ဖောင်အကွက်များ ဖြည့်ခြင်း';

  @override
  String get changingContentIncludes =>
      'စာရွက်စာတမ်း ပြင်ဆင်ခြင်းတွင် မှတ်ချက်ပေးခြင်းနှင့် ဖောင်ဖြည့်ခြင်းလည်း ပါဝင်ပြီး ၎င်းတို့ကိုလည်း အတူတကွ ခွင့်ပြုသည်။';

  @override
  String get ownerPasswordHeading => 'ပိုင်ရှင်၏ စကားဝှက်';

  @override
  String get removeProtection => 'ကာကွယ်မှု ဖယ်ရှား';

  @override
  String get applyButton => 'အသုံးပြု';

  @override
  String get passwordsDoNotMatch => 'စကားဝှက်များ မကိုက်ညီပါ';

  @override
  String get passwordCannotBeEmpty => 'စကားဝှက် ထည့်ပါ';

  @override
  String get restrictionsNeedOwnerPassword =>
      'ကန့်သတ်ချက်များအတွက် ပိုင်ရှင်၏ စကားဝှက် လိုအပ်သည်။ ၎င်းမရှိလျှင် မည်သူမဆို ဖယ်ရှားနိုင်သည်။';

  @override
  String get signingNeedsChangingContent =>
      '“စာရွက်စာတမ်း ပြင်ဆင်ခြင်း” မပါလျှင် ပိုင်ရှင်၏ စကားဝှက်မရှိဘဲ ဤဖိုင်ကို ဤနေရာတွင် ထပ်မံ လက်မှတ်ထိုး၍ မရပါ။';

  @override
  String get menuProtectDocument => 'စာရွက်စာတမ်း ကာကွယ်ရန်…';

  @override
  String get protectButtonLabel => 'ကာကွယ်';

  @override
  String get protectButtonTooltip =>
      'ဤစာရွက်စာတမ်း၏ စကားဝှက်များနှင့် ခွင့်ပြုချက်များကို သတ်မှတ်ပါ';
}
