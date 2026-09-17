// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get openPdf => 'PDF kholein';

  @override
  String get selectPdf => 'PDF chunein';

  @override
  String get recentFiles => 'Haal ki failein';

  @override
  String get removeFromList => 'Suchi se hataein';

  @override
  String get openedNow => 'Abhi khola gaya';

  @override
  String openedMinutesAgo(int count) {
    return '$count minute pehle khola gaya';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count ghante pehle khola gaya';
  }

  @override
  String get openedYesterday => 'Kal khola gaya';

  @override
  String openedDaysAgo(int count) {
    return '$count din pehle khola gaya';
  }

  @override
  String get fileNotFound => 'File nahi mili';

  @override
  String get fileAccessDenied => 'Pahunch asvikriti';

  @override
  String get clearRecentFiles => 'Haal ki failein saaf karein';

  @override
  String get cancel => 'Radd karein';

  @override
  String get confirm => 'Pushti karein';

  @override
  String get error => 'Truti';

  @override
  String get ok => 'Theek hai';

  @override
  String get menuFile => 'फ़ाइल';

  @override
  String get menuOpen => 'Kholein...';

  @override
  String get menuOpenRecent => 'Haal ke kholein';

  @override
  String get menuNoRecentFiles => 'Koi haal ki file nahi';

  @override
  String get menuClearMenu => 'Menu saaf karein';

  @override
  String get menuSave => 'Sahejein';

  @override
  String get menuSaveAs => 'Is roop mein sahejein...';

  @override
  String get menuSaveAll => 'सभी सहेजें';

  @override
  String get menuShare => 'Sajha karein...';

  @override
  String get menuCloseWindow => 'Window band karein';

  @override
  String get menuCloseAll => 'सभी बंद करें';

  @override
  String get menuEdit => 'संपादित करें';

  @override
  String get menuDelete => 'हटाएं';

  @override
  String get menuView => 'दृश्य';

  @override
  String goToPagePrompt(int total) {
    return 'पृष्ठ संख्या दर्ज करें (1–$total):';
  }

  @override
  String get goToPageHint => 'पृष्ठ संख्या';

  @override
  String get goToPageInvalid => 'मान्य संख्या दर्ज करें';

  @override
  String goToPageOutOfRange(int total) {
    return 'पृष्ठ 1 और $total के बीच होना चाहिए';
  }

  @override
  String get menuRotateLeft => 'बाएँ घुमाएँ';

  @override
  String get menuRotateRight => 'दाएँ घुमाएँ';

  @override
  String get menuCut => 'काटें';

  @override
  String get menuCopy => 'कॉपी करें';

  @override
  String get menuPaste => 'पेस्ट करें';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'नहीं जोड़ी गईं: $count छवियाँ $limit से बड़ी हैं';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'नहीं जोड़ी गईं: $count छवियाँ $limit पिक्सेल से बड़ी हैं';
  }

  @override
  String imagesNotAdded(int count) {
    return 'नहीं जोड़ी गईं: $count छवियाँ';
  }

  @override
  String get clipboardUnavailable => 'क्लिपबोर्ड उपलब्ध नहीं है';

  @override
  String get pasteImageFailed => 'यह छवि नहीं जोड़ी जा सकी';

  @override
  String get menuQuit => 'PDFSign से बाहर निकलें';

  @override
  String get closeAllDialogTitle => 'परिवर्तन सहेजें?';

  @override
  String closeAllDialogMessage(int count) {
    return 'बंद करने से पहले $count दस्तावेजों में परिवर्तन सहेजना चाहते हैं?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'बंद करने से पहले 1 दस्तावेज में परिवर्तन सहेजना चाहते हैं?';

  @override
  String get closeAllDialogSaveAll => 'सभी सहेजें';

  @override
  String get closeAllDialogDontSave => 'न सहेजें';

  @override
  String get closeAllDialogCancel => 'रद्द करें';

  @override
  String get saveFailedDialogTitle => 'सहेजना विफल';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count दस्तावेज़ सहेजने में विफल। फिर भी बंद करें?';
  }

  @override
  String get saveFailedDialogClose => 'फिर भी बंद करें';

  @override
  String get saveChangesTitle => 'Parivartan sahejein?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Kya aap band karne se pehle \"$fileName\" mein parivartan sahejana chahte hain?';
  }

  @override
  String get saveButton => 'Sahejein';

  @override
  String get discardButton => 'Na sahejein';

  @override
  String get documentEdited => 'Sampadit';

  @override
  String get documentSaved => 'Saheja gaya';

  @override
  String get menuSettings => 'सेटिंग्ज़...';

  @override
  String get menuWindow => 'विंडो';

  @override
  String get menuMinimize => 'छोटा करें';

  @override
  String get menuZoom => 'ज़ूम';

  @override
  String get menuBringAllToFront => 'सभी को आगे लाएं';

  @override
  String get settingsTitle => 'सेटिंग्ज़';

  @override
  String get settingsLanguage => 'Bhasha';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsUnits => 'Ikaiyaan';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'भाषाएं खोजें...';

  @override
  String get settingsGeneral => 'सामान्य';

  @override
  String get addImage => 'छवि जोड़ें';

  @override
  String get selectImages => 'छवियां चुनें';

  @override
  String get zoomFitWidth => 'चौड़ाई में फ़िट करें';

  @override
  String get zoomIn => 'ज़ूम इन';

  @override
  String get zoomOut => 'ज़ूम आउट';

  @override
  String get selectZoomLevel => 'ज़ूम स्तर चुनें';

  @override
  String get goToPage => 'पृष्ठ पर जाएं';

  @override
  String get go => 'जाएं';

  @override
  String get savePdfAs => 'PDF के रूप में सहेजें';

  @override
  String get incorrectPassword => 'गलत पासवर्ड';

  @override
  String get saveFailed => 'सहेजना विफल';

  @override
  String savedTo(String path) {
    return 'इसमें सहेजा गया: $path';
  }

  @override
  String get noOriginalPdfStored => 'कोई मूल PDF संग्रहीत नहीं';

  @override
  String get waitingForFolderPermission =>
      'फ़ोल्डर एक्सेस अनुमति की प्रतीक्षा की जा रही है...';

  @override
  String get deleteButtonLabel => 'हटाएं';

  @override
  String get deleteButtonTooltip => 'चयनित ऑब्जेक्ट हटाएं';

  @override
  String get documentProtectedTitle => 'यह दस्तावेज़ सुरक्षित है';

  @override
  String get documentProtectedBody => 'इसे खोलने के लिए पासवर्ड दर्ज करें।';

  @override
  String get passwordFieldLabel => 'पासवर्ड';

  @override
  String get openDocumentButton => 'खोलें';

  @override
  String get documentReadOnlyTitle => 'यह दस्तावेज़ बदलाव की अनुमति नहीं देता';

  @override
  String get documentReadOnlyBody =>
      'इसे पढ़ा और मुद्रित किया जा सकता है, किंतु स्वामी ने बदलाव की अनुमति नहीं दी है। संपादित करने के लिए स्वामी का पासवर्ड दर्ज करें।';

  @override
  String get enterOwnerPassword => 'स्वामी का पासवर्ड दर्ज करें';

  @override
  String get ownerPasswordFieldLabel => 'स्वामी का पासवर्ड';

  @override
  String get menuPrint => 'प्रिंट करें…';

  @override
  String get menuPrintCurrentPage => 'वर्तमान पृष्ठ प्रिंट करें';

  @override
  String get printingIsTheOwnersTitle =>
      'इस दस्तावेज़ को केवल स्वामी ही प्रिंट कर सकता है';

  @override
  String get printingNotAllowed =>
      'यह दस्तावेज़ प्रिंट करने की अनुमति नहीं देता।';

  @override
  String get printingFailed => 'दस्तावेज़ प्रिंट नहीं किया जा सका।';

  @override
  String get protectionIsTheOwnersTitle =>
      'इस दस्तावेज़ की सुरक्षा केवल स्वामी ही बदल सकता है';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'सुरक्षित दस्तावेज़ स्मृति से दिखाया जाता है, और इसका आकार $size है। इसे खोलने में लगभग उतनी ही स्मृति लगेगी।';
  }

  @override
  String get shareProtectedNotice =>
      'साझा की गई प्रति दस्तावेज़ का पासवर्ड बनाए रखती है।';

  @override
  String get unsupportedProtection =>
      'इस दस्तावेज़ की सुरक्षा समर्थित नहीं है। PDFSign पासवर्ड से सुरक्षित दस्तावेज़ खोलता है, प्रमाणपत्र से सुरक्षित नहीं।';

  @override
  String get menuBringToFront => 'सबसे आगे लाएँ';

  @override
  String get menuBringForward => 'आगे लाएँ';

  @override
  String get menuSendBackward => 'पीछे भेजें';

  @override
  String get menuSendToBack => 'सबसे पीछे भेजें';

  @override
  String get zOrderGroupLabel => 'क्रम';

  @override
  String get menuUndo => 'पूर्ववत करें';

  @override
  String get menuRedo => 'पुनः करें';

  @override
  String get dragToReorder => 'क्रम बदलने के लिए खींचें';

  @override
  String get protectDocumentTitle => 'दस्तावेज़ सुरक्षित करें';

  @override
  String get requirePasswordToOpen => 'दस्तावेज़ खोलने के लिए पासवर्ड माँगें';

  @override
  String get verifyFieldLabel => 'पुष्टि';

  @override
  String get permissionsHeading => 'अनुमतियाँ';

  @override
  String get permissionsNote =>
      'स्वामी का पासवर्ड दर्ज किए बिना निम्नलिखित बदलावों की अनुमति दें।';

  @override
  String get permissionPrinting => 'प्रिंट करना';

  @override
  String get permissionCopying => 'पाठ या ग्राफ़िक्स की कॉपी करना';

  @override
  String get permissionPageAssembly => 'पृष्ठ जोड़ना, हटाना और घुमाना';

  @override
  String get permissionAnnotations => 'टिप्पणियाँ या हस्ताक्षर जोड़ना';

  @override
  String get permissionChangingContent => 'दस्तावेज़ बदलना';

  @override
  String get permissionFormFilling => 'मौजूदा फ़ॉर्म फ़ील्ड भरना';

  @override
  String get changingContentIncludes =>
      'दस्तावेज़ बदलने में टिप्पणी करना और फ़ॉर्म भरना शामिल है — ये उसके साथ ही अनुमत हो जाते हैं।';

  @override
  String get ownerPasswordHeading => 'स्वामी का पासवर्ड';

  @override
  String get removeProtection => 'सुरक्षा हटाएँ';

  @override
  String get applyButton => 'लागू करें';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get passwordCannotBeEmpty => 'पासवर्ड दर्ज करें';

  @override
  String get restrictionsNeedOwnerPassword =>
      'प्रतिबंधों के लिए स्वामी का पासवर्ड आवश्यक है। उसके बिना कोई भी उन्हें हटा सकता है।';

  @override
  String get signingNeedsChangingContent =>
      '“दस्तावेज़ बदलना” के बिना, स्वामी के पासवर्ड के बगैर इस फ़ाइल पर यहाँ दोबारा हस्ताक्षर नहीं किए जा सकेंगे।';

  @override
  String get menuProtectDocument => 'दस्तावेज़ सुरक्षित करें…';

  @override
  String get protectButtonLabel => 'सुरक्षित करें';

  @override
  String get protectButtonTooltip =>
      'इस दस्तावेज़ के पासवर्ड और अनुमतियाँ निर्धारित करें';
}
