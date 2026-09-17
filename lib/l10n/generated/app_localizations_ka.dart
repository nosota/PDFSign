// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Georgian (`ka`).
class AppLocalizationsKa extends AppLocalizations {
  AppLocalizationsKa([String locale = 'ka']) : super(locale);

  @override
  String get openPdf => 'PDF-is gakhsna';

  @override
  String get selectPdf => 'PDF-is archeeva';

  @override
  String get recentFiles => 'bolodroindfeli failebi';

  @override
  String get removeFromList => 'siidan amoshla';

  @override
  String get openedNow => 'akhla gakhsnili';

  @override
  String openedMinutesAgo(int count) {
    return 'gakhsnili $count tsutis tsin';
  }

  @override
  String openedHoursAgo(int count) {
    return 'gakhsnili $count saatis tsin';
  }

  @override
  String get openedYesterday => 'gakhsnili gushin';

  @override
  String openedDaysAgo(int count) {
    return 'gakhsnili $count dghis tsin';
  }

  @override
  String get fileNotFound => 'faili ver moidzebna';

  @override
  String get fileAccessDenied => 'tsvrda akridzalulia';

  @override
  String get clearRecentFiles => 'bolodroindfeli failebis gasuptaveba';

  @override
  String get cancel => 'gaukmeba';

  @override
  String get confirm => 'dadastureba';

  @override
  String get error => 'shecdoma';

  @override
  String get ok => 'karghi';

  @override
  String get menuFile => 'Faili';

  @override
  String get menuOpen => 'Gakhsna...';

  @override
  String get menuOpenRecent => 'Bolodroindfeli';

  @override
  String get menuNoRecentFiles => 'Ar aris bolodroindfeli failebi';

  @override
  String get menuClearMenu => 'Meniuis gasuptaveba';

  @override
  String get menuSave => 'Shenakhva';

  @override
  String get menuSaveAs => 'Shenakhva rogorc...';

  @override
  String get menuSaveAll => 'ყველას შენახვა';

  @override
  String get menuShare => 'Gaziareba...';

  @override
  String get menuCloseWindow => 'Panjeris dakhetva';

  @override
  String get menuCloseAll => 'ყველას დახურვა';

  @override
  String get menuEdit => 'რედაქტირება';

  @override
  String get menuDelete => 'წაშლა';

  @override
  String get menuView => 'ხედი';

  @override
  String goToPagePrompt(int total) {
    return 'შეიყვანეთ გვერდის ნომერი (1–$total):';
  }

  @override
  String get goToPageHint => 'გვერდის ნომერი';

  @override
  String get goToPageInvalid => 'შეიყვანეთ სწორი რიცხვი';

  @override
  String goToPageOutOfRange(int total) {
    return 'გვერდი უნდა იყოს 1-სა და $total-ს შორის';
  }

  @override
  String get menuRotateLeft => 'მარცხნივ შემობრუნება';

  @override
  String get menuRotateRight => 'მარჯვნივ შემობრუნება';

  @override
  String get menuCut => 'ამოჭრა';

  @override
  String get menuCopy => 'კოპირება';

  @override
  String get menuPaste => 'ჩასმა';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'არ დაემატა: $count სურათი აღემატება $limit-ს';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'არ დაემატა: $count სურათი აღემატება $limit პიქსელს';
  }

  @override
  String imagesNotAdded(int count) {
    return 'არ დაემატა: $count სურათი';
  }

  @override
  String get clipboardUnavailable => 'ბუფერი მიუწვდომელია';

  @override
  String get pasteImageFailed => 'ამ სურათის დამატება ვერ მოხერხდა';

  @override
  String get menuQuit => 'გასვლა PDFSign-დან';

  @override
  String get closeAllDialogTitle => 'ცვლილებების შენახვა?';

  @override
  String closeAllDialogMessage(int count) {
    return 'გსურთ შეინახოთ ცვლილებები $count დოკუმენტში დახურვამდე?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'გსურთ შეინახოთ ცვლილებები 1 დოკუმენტში დახურვამდე?';

  @override
  String get closeAllDialogSaveAll => 'ყველას შენახვა';

  @override
  String get closeAllDialogDontSave => 'არ შეინახო';

  @override
  String get closeAllDialogCancel => 'გაუქმება';

  @override
  String get saveFailedDialogTitle => 'შენახვა ვერ მოხერხდა';

  @override
  String saveFailedDialogMessage(int count) {
    return 'ვერ მოხერხდა $count დოკუმენტის შენახვა. მაინც დაიხუროს?';
  }

  @override
  String get saveFailedDialogClose => 'მაინც დახურვა';

  @override
  String get saveChangesTitle => 'Cvlilebebis shenakhva?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Gindakht shenakhat cvlilebebi \"$fileName\"-shi dakhetvamdfe?';
  }

  @override
  String get saveButton => 'Shenakhva';

  @override
  String get discardButton => 'Gaukmeba';

  @override
  String get documentEdited => 'Redaktrebuli';

  @override
  String get documentSaved => 'Shenakhuli';

  @override
  String get menuSettings => 'Parametrebi...';

  @override
  String get menuWindow => 'ფანჯარა';

  @override
  String get menuMinimize => 'შემცირება';

  @override
  String get menuZoom => 'მასშტაბირება';

  @override
  String get menuBringAllToFront => 'ყველას წინ მოტანა';

  @override
  String get settingsTitle => 'Parametrebi';

  @override
  String get settingsLanguage => 'Ena';

  @override
  String get settingsLanguageSystem => 'Sistemis nagulistseti';

  @override
  String get settingsUnits => 'Erteuelebi';

  @override
  String get settingsUnitsCentimeters => 'Santimetrebi';

  @override
  String get settingsUnitsInches => 'Diumebi';

  @override
  String get settingsSearchLanguages => 'ენების ძიება...';

  @override
  String get settingsGeneral => 'ზოგადი';

  @override
  String get addImage => 'სურათის დამატება';

  @override
  String get selectImages => 'სურათების არჩევა';

  @override
  String get zoomFitWidth => 'სიგანეზე მორგება';

  @override
  String get zoomIn => 'გადიდება';

  @override
  String get zoomOut => 'შემცირება';

  @override
  String get selectZoomLevel => 'მასშტაბის არჩევა';

  @override
  String get goToPage => 'გვერდზე გადასვლა';

  @override
  String get go => 'გადასვლა';

  @override
  String get savePdfAs => 'PDF-ის შენახვა როგორც';

  @override
  String get incorrectPassword => 'არასწორი პაროლი';

  @override
  String get saveFailed => 'შენახვა ვერ მოხერხდა';

  @override
  String savedTo(String path) {
    return 'შენახულია: $path';
  }

  @override
  String get noOriginalPdfStored => 'ორიგინალი PDF არ არის შენახული';

  @override
  String get waitingForFolderPermission =>
      'საქაღალდეზე წვდომის ნებართვის მოლოდინი...';

  @override
  String get deleteButtonLabel => 'წაშლა';

  @override
  String get deleteButtonTooltip => 'არჩეული ობიექტის წაშლა';

  @override
  String get documentProtectedTitle => 'ეს დოკუმენტი დაცულია';

  @override
  String get documentProtectedBody => 'გასახსნელად შეიყვანეთ პაროლი.';

  @override
  String get passwordFieldLabel => 'პაროლი';

  @override
  String get openDocumentButton => 'გახსნა';

  @override
  String get documentReadOnlyTitle => 'ეს დოკუმენტი ცვლილებებს არ უშვებს';

  @override
  String get documentReadOnlyBody =>
      'მისი წაკითხვა და დაბეჭდვა შესაძლებელია, მაგრამ მფლობელს ცვლილებები არ დაუშვია. რედაქტირებისთვის შეიყვანეთ მფლობელის პაროლი.';

  @override
  String get enterOwnerPassword => 'მფლობელის პაროლის შეყვანა';

  @override
  String get ownerPasswordFieldLabel => 'მფლობელის პაროლი';

  @override
  String get menuPrint => 'ბეჭდვა…';

  @override
  String get menuPrintCurrentPage => 'მიმდინარე გვერდის ბეჭდვა';

  @override
  String get printingIsTheOwnersTitle =>
      'ამ დოკუმენტის დაბეჭდვა მხოლოდ მფლობელს შეუძლია';

  @override
  String get printingNotAllowed => 'ეს დოკუმენტი ბეჭდვას არ უშვებს.';

  @override
  String get printingFailed => 'დოკუმენტის დაბეჭდვა ვერ მოხერხდა.';

  @override
  String get protectionIsTheOwnersTitle =>
      'ამ დოკუმენტის დაცვის შეცვლა მხოლოდ მფლობელს შეუძლია';

  @override
  String get continueButton => 'გაგრძელება';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'დაცული დოკუმენტი მეხსიერებიდან ნაჩვენებია, ხოლო ამის ზომაა $size. მისი გახსნა დაახლოებით იმდენივე მეხსიერებას გამოიყენებს.';
  }

  @override
  String get shareProtectedNotice =>
      'გაზიარებული ასლი ინარჩუნებს დოკუმენტის პაროლს.';

  @override
  String get unsupportedProtection =>
      'ამ დოკუმენტის დაცვა მხარდაუჭერელია. PDFSign ხსნის პაროლით დაცულ დოკუმენტებს და არა სერტიფიკატით დაცულებს.';

  @override
  String get menuBringToFront => 'წინ წამოწევა';

  @override
  String get menuBringForward => 'წინ გადატანა';

  @override
  String get menuSendBackward => 'უკან გადატანა';

  @override
  String get menuSendToBack => 'ბოლოში გადატანა';

  @override
  String get zOrderGroupLabel => 'განლაგება';

  @override
  String get menuUndo => 'დაბრუნება';

  @override
  String get menuRedo => 'გამეორება';

  @override
  String get dragToReorder => 'გადაათრიეთ თანმიმდევრობის შესაცვლელად';

  @override
  String get protectDocumentTitle => 'დოკუმენტის დაცვა';

  @override
  String get requirePasswordToOpen => 'დოკუმენტის გასახსნელად პაროლის მოთხოვნა';

  @override
  String get verifyFieldLabel => 'დადასტურება';

  @override
  String get permissionsHeading => 'ნებართვები';

  @override
  String get permissionsNote =>
      'დაუშვით შემდეგი ცვლილებები მფლობელის პაროლის შეყვანის გარეშე.';

  @override
  String get permissionPrinting => 'ბეჭდვა';

  @override
  String get permissionCopying => 'ტექსტის ან გრაფიკის კოპირება';

  @override
  String get permissionPageAssembly => 'გვერდების ჩასმა, წაშლა და შემობრუნება';

  @override
  String get permissionAnnotations => 'შენიშვნებისა და ხელმოწერების დამატება';

  @override
  String get permissionChangingContent => 'დოკუმენტის შეცვლა';

  @override
  String get permissionFormFilling => 'არსებული ფორმის ველების შევსება';

  @override
  String get changingContentIncludes =>
      'დოკუმენტის შეცვლა მოიცავს შენიშვნებსა და ფორმების შევსებას — ისინი მასთან ერთად დაიშვება.';

  @override
  String get ownerPasswordHeading => 'მფლობელის პაროლი';

  @override
  String get removeProtection => 'დაცვის მოხსნა';

  @override
  String get applyButton => 'გამოყენება';

  @override
  String get passwordsDoNotMatch => 'პაროლები არ ემთხვევა';

  @override
  String get passwordCannotBeEmpty => 'შეიყვანეთ პაროლი';

  @override
  String get restrictionsNeedOwnerPassword =>
      'შეზღუდვებს სჭირდება მფლობელის პაროლი. მის გარეშე მათ ნებისმიერი მოხსნის.';

  @override
  String get signingNeedsChangingContent =>
      '„დოკუმენტის შეცვლის“ გარეშე ამ ფაილს აქ ხელახლა ვერ მოაწერთ ხელს მფლობელის პაროლის გარეშე.';

  @override
  String get menuProtectDocument => 'დოკუმენტის დაცვა…';

  @override
  String get protectButtonLabel => 'დაცვა';

  @override
  String get protectButtonTooltip =>
      'განსაზღვრეთ ამ დოკუმენტის პაროლები და ნებართვები';
}
