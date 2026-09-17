// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Khmer Central Khmer (`km`).
class AppLocalizationsKm extends AppLocalizations {
  AppLocalizationsKm([String locale = 'km']) : super(locale);

  @override
  String get openPdf => 'Berk PDF';

  @override
  String get selectPdf => 'Chreuh PDF';

  @override
  String get recentFiles => 'Aeksaa tmey';

  @override
  String get removeFromList => 'Loub chenh pi banchhi';

  @override
  String get openedNow => 'Trov ban berk';

  @override
  String openedMinutesAgo(int count) {
    return 'Berk $count neatii muon';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Berk $count maong muon';
  }

  @override
  String get openedYesterday => 'Berk mselminhh';

  @override
  String openedDaysAgo(int count) {
    return 'Berk $count thngai muon';
  }

  @override
  String get fileNotFound => 'Rork min kheunh aeksaa';

  @override
  String get fileAccessDenied => 'Kar choul dak min trov ban anunhhat';

  @override
  String get clearRecentFiles => 'Somat aeksaa tmey';

  @override
  String get cancel => 'Loeuk leng';

  @override
  String get confirm => 'Banghanh';

  @override
  String get error => 'Khoh';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Aeksaa';

  @override
  String get menuOpen => 'Berk...';

  @override
  String get menuOpenRecent => 'Berk tmey';

  @override
  String get menuNoRecentFiles => 'Kmean aeksaa tmey';

  @override
  String get menuClearMenu => 'Somat menu';

  @override
  String get menuSave => 'Tuktuk';

  @override
  String get menuSaveAs => 'Tuktuk chea...';

  @override
  String get menuSaveAll => 'រក្សាទុកទាំងអស់';

  @override
  String get menuShare => 'Chek ruum...';

  @override
  String get menuCloseWindow => 'But baong aas';

  @override
  String get menuCloseAll => 'បិទទាំងអស់';

  @override
  String get menuEdit => 'កែសម្រួល';

  @override
  String get menuDelete => 'លុប';

  @override
  String get menuView => 'ទិដ្ឋភាព';

  @override
  String goToPagePrompt(int total) {
    return 'បញ្ចូលលេខទំព័រ (1–$total):';
  }

  @override
  String get goToPageHint => 'លេខទំព័រ';

  @override
  String get goToPageInvalid => 'សូមបញ្ចូលលេខត្រឹមត្រូវ';

  @override
  String goToPageOutOfRange(int total) {
    return 'ទំព័រត្រូវស្ថិតនៅចន្លោះ 1 និង $total';
  }

  @override
  String get menuRotateLeft => 'បង្វិលទៅឆ្វេង';

  @override
  String get menuRotateRight => 'បង្វិលទៅស្តាំ';

  @override
  String get menuCut => 'កាត់';

  @override
  String get menuCopy => 'ចម្លង';

  @override
  String get menuPaste => 'បិទភ្ជាប់';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'មិនបានបន្ថែម៖ រូបភាព $count ធំជាង $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'មិនបានបន្ថែម៖ រូបភាព $count ធំជាង $limit ភីកសែល';
  }

  @override
  String imagesNotAdded(int count) {
    return 'មិនបានបន្ថែម៖ រូបភាព $count';
  }

  @override
  String get clipboardUnavailable => 'មិនអាចប្រើក្តារតម្បៀតខ្ទាស់បានទេ';

  @override
  String get pasteImageFailed => 'មិនអាចបន្ថែមរូបភាពនេះបានទេ';

  @override
  String get menuQuit => 'ចាកចេញពី PDFSign';

  @override
  String get closeAllDialogTitle => 'រក្សាទុកការផ្លាស់ប្តូរ?';

  @override
  String closeAllDialogMessage(int count) {
    return 'តើអ្នកចង់រក្សាទុកការផ្លាស់ប្តូរក្នុងឯកសារ $count មុនពេលបិទទេ?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'តើអ្នកចង់រក្សាទុកការផ្លាស់ប្តូរក្នុងឯកសារ 1 មុនពេលបិទទេ?';

  @override
  String get closeAllDialogSaveAll => 'រក្សាទុកទាំងអស់';

  @override
  String get closeAllDialogDontSave => 'កុំរក្សាទុក';

  @override
  String get closeAllDialogCancel => 'បោះបង់';

  @override
  String get saveFailedDialogTitle => 'រក្សាទុកបរាជ័យ';

  @override
  String saveFailedDialogMessage(int count) {
    return 'បរាជ័យក្នុងការរក្សាទុក $count ឯកសារ។ បិទទោះយ៉ាងណា?';
  }

  @override
  String get saveFailedDialogClose => 'បិទទោះយ៉ាងណា';

  @override
  String get saveChangesTitle => 'Tuktuk kar phlash phder?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Tae anak chong tuktuk kar phlash phder knong \"$fileName\" muon pel but?';
  }

  @override
  String get saveButton => 'Tuktuk';

  @override
  String get discardButton => 'Kum tuktuk';

  @override
  String get documentEdited => 'Kae samruel';

  @override
  String get documentSaved => 'Trov ban tuktuk';

  @override
  String get menuSettings => 'Kar kat tong...';

  @override
  String get menuWindow => 'បង្អួច';

  @override
  String get menuMinimize => 'បង្រួម';

  @override
  String get menuZoom => 'ពង្រីក';

  @override
  String get menuBringAllToFront => 'នាំទាំងអស់មកមុខ';

  @override
  String get settingsTitle => 'Kar kat tong';

  @override
  String get settingsLanguage => 'Pheasaa';

  @override
  String get settingsLanguageSystem => 'Propanh robos brapon';

  @override
  String get settingsUnits => 'Akhphmaan';

  @override
  String get settingsUnitsCentimeters => 'Saangtimaet';

  @override
  String get settingsUnitsInches => 'Aengh';

  @override
  String get settingsSearchLanguages => 'ស្វែងរកភាសា...';

  @override
  String get settingsGeneral => 'ទូទៅ';

  @override
  String get addImage => 'បន្ថែមរូបភាព';

  @override
  String get selectImages => 'ជ្រើសរើសរូបភាព';

  @override
  String get zoomFitWidth => 'សម្រួលតាមទទឹង';

  @override
  String get zoomIn => 'ពង្រីក';

  @override
  String get zoomOut => 'បង្រួម';

  @override
  String get selectZoomLevel => 'ជ្រើសរើសកម្រិតពង្រីក';

  @override
  String get goToPage => 'ទៅទំព័រ';

  @override
  String get go => 'ទៅ';

  @override
  String get savePdfAs => 'រក្សាទុក PDF ជា';

  @override
  String get incorrectPassword => 'ពាក្យសម្ងាត់មិនត្រឹមត្រូវ';

  @override
  String get saveFailed => 'រក្សាទុកបរាជ័យ';

  @override
  String savedTo(String path) {
    return 'បានរក្សាទុកនៅ: $path';
  }

  @override
  String get noOriginalPdfStored => 'គ្មាន PDF ដើមត្រូវបានរក្សាទុក';

  @override
  String get waitingForFolderPermission => 'កំពុងរង់ចាំការអនុញ្ញាតចូលប្រើថត...';

  @override
  String get deleteButtonLabel => 'លុប';

  @override
  String get deleteButtonTooltip => 'លុបវត្ថុដែលបានជ្រើសរើស';

  @override
  String get documentProtectedTitle => 'ឯកសារនេះត្រូវបានការពារ';

  @override
  String get documentProtectedBody => 'សូមបញ្ចូលពាក្យសម្ងាត់ដើម្បីបើកវា។';

  @override
  String get passwordFieldLabel => 'ពាក្យសម្ងាត់';

  @override
  String get openDocumentButton => 'បើក';

  @override
  String get documentReadOnlyTitle => 'ឯកសារនេះមិនអនុញ្ញាតឱ្យកែប្រែទេ';

  @override
  String get documentReadOnlyBody =>
      'អាចអាននិងបោះពុម្ពបាន ប៉ុន្តែម្ចាស់មិនបានអនុញ្ញាតឱ្យកែប្រែទេ។ សូមបញ្ចូលពាក្យសម្ងាត់របស់ម្ចាស់ដើម្បីកែសម្រួល។';

  @override
  String get enterOwnerPassword => 'បញ្ចូលពាក្យសម្ងាត់របស់ម្ចាស់';

  @override
  String get ownerPasswordFieldLabel => 'ពាក្យសម្ងាត់របស់ម្ចាស់';

  @override
  String get menuPrint => 'បោះពុម្ព…';

  @override
  String get menuPrintCurrentPage => 'បោះពុម្ពទំព័រនេះ';

  @override
  String get printingIsTheOwnersTitle =>
      'មានតែម្ចាស់ប៉ុណ្ណោះដែលអាចបោះពុម្ពឯកសារនេះ';

  @override
  String get printingNotAllowed => 'ឯកសារនេះមិនអនុញ្ញាតឱ្យបោះពុម្ពទេ។';

  @override
  String get printingFailed => 'មិនអាចបោះពុម្ពឯកសារបានទេ។';

  @override
  String get protectionIsTheOwnersTitle =>
      'មានតែម្ចាស់ប៉ុណ្ណោះដែលអាចប្ដូរការការពាររបស់ឯកសារនេះ';

  @override
  String get continueButton => 'បន្ត';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'ឯកសារដែលបានការពារត្រូវបង្ហាញពីអង្គចងចាំ ហើយឯកសារនេះមានទំហំ $size។ ការបើកវានឹងប្រើអង្គចងចាំប្រហែលប៉ុណ្ណឹង។';
  }

  @override
  String get shareProtectedNotice =>
      'ច្បាប់ចម្លងដែលបានចែករំលែករក្សាពាក្យសម្ងាត់របស់ឯកសារ។';

  @override
  String get unsupportedProtection =>
      'ការការពាររបស់ឯកសារនេះមិនត្រូវបានគាំទ្រទេ។ PDFSign បើកឯកសារដែលការពារដោយពាក្យសម្ងាត់ មិនមែនឯកសារដែលការពារដោយវិញ្ញាបនបត្រទេ។';

  @override
  String get menuBringToFront => 'នាំទៅមុខគេ';

  @override
  String get menuBringForward => 'នាំទៅមុខ';

  @override
  String get menuSendBackward => 'បញ្ជូនទៅក្រោយ';

  @override
  String get menuSendToBack => 'បញ្ជូនទៅក្រោយគេ';

  @override
  String get zOrderGroupLabel => 'រៀបចំ';

  @override
  String get menuUndo => 'មិនធ្វើវិញ';

  @override
  String get menuRedo => 'ធ្វើវិញ';

  @override
  String get dragToReorder => 'អូសដើម្បីប្ដូរលំដាប់';

  @override
  String get protectDocumentTitle => 'ការពារឯកសារ';

  @override
  String get requirePasswordToOpen => 'ទាមទារពាក្យសម្ងាត់ដើម្បីបើកឯកសារ';

  @override
  String get verifyFieldLabel => 'បញ្ជាក់';

  @override
  String get permissionsHeading => 'សិទ្ធិ';

  @override
  String get permissionsNote =>
      'អនុញ្ញាតការកែប្រែខាងក្រោមដោយមិនបាច់បញ្ចូលពាក្យសម្ងាត់របស់ម្ចាស់។';

  @override
  String get permissionPrinting => 'ការបោះពុម្ព';

  @override
  String get permissionCopying => 'ការចម្លងអត្ថបទ ឬក្រាហ្វិក';

  @override
  String get permissionPageAssembly => 'ការបញ្ចូល លុប និងបង្វិលទំព័រ';

  @override
  String get permissionAnnotations => 'ការបន្ថែមចំណាំ ឬហត្ថលេខា';

  @override
  String get permissionChangingContent => 'ការកែប្រែឯកសារ';

  @override
  String get permissionFormFilling => 'ការបំពេញវាលទម្រង់ដែលមានស្រាប់';

  @override
  String get changingContentIncludes =>
      'ការកែប្រែឯកសាររួមបញ្ចូលការចំណាំ និងការបំពេញទម្រង់ — ទាំងនោះត្រូវបានអនុញ្ញាតជាមួយវា។';

  @override
  String get ownerPasswordHeading => 'ពាក្យសម្ងាត់របស់ម្ចាស់';

  @override
  String get removeProtection => 'ដកការការពារចេញ';

  @override
  String get applyButton => 'អនុវត្ត';

  @override
  String get passwordsDoNotMatch => 'ពាក្យសម្ងាត់មិនត្រូវគ្នាទេ';

  @override
  String get passwordCannotBeEmpty => 'សូមបញ្ចូលពាក្យសម្ងាត់';

  @override
  String get restrictionsNeedOwnerPassword =>
      'ការរឹតបន្តឹងត្រូវការពាក្យសម្ងាត់របស់ម្ចាស់។ បើគ្មានវា អ្នកណាក៏អាចដករបស់ទាំងនោះចេញបាន។';

  @override
  String get signingNeedsChangingContent =>
      'បើគ្មាន «ការកែប្រែឯកសារ» ទេ ឯកសារនេះនឹងមិនអាចចុះហត្ថលេខាឡើងវិញនៅទីនេះបានទេ បើគ្មានពាក្យសម្ងាត់របស់ម្ចាស់។';

  @override
  String get menuProtectDocument => 'ការពារឯកសារ…';

  @override
  String get protectButtonLabel => 'ការពារ';

  @override
  String get protectButtonTooltip => 'កំណត់ពាក្យសម្ងាត់ និងសិទ្ធិរបស់ឯកសារនេះ';
}
