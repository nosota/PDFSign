// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Mongolian (`mn`).
class AppLocalizationsMn extends AppLocalizations {
  AppLocalizationsMn([String locale = 'mn']) : super(locale);

  @override
  String get openPdf => 'PDF neekh';

  @override
  String get selectPdf => 'PDF songokh';

  @override
  String get recentFiles => 'Suuliin failuud';

  @override
  String get removeFromList => 'Jisneesee ustgakh';

  @override
  String get openedNow => 'Doorond neegdsen';

  @override
  String openedMinutesAgo(int count) {
    return '$count minut umnuh neegdsen';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count tsag umnuh neegdsen';
  }

  @override
  String get openedYesterday => 'Uchidar neegdsen';

  @override
  String openedDaysAgo(int count) {
    return '$count udur umnuh neegdsen';
  }

  @override
  String get fileNotFound => 'Fail oldsongui';

  @override
  String get fileAccessDenied => 'Nevtrekh khorigdson';

  @override
  String get clearRecentFiles => 'Suuliin failuudig tsooglokh';

  @override
  String get cancel => 'Tsooglokh';

  @override
  String get confirm => 'Batalgaajulakh';

  @override
  String get error => 'Aldaa';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fail';

  @override
  String get menuOpen => 'Neekh...';

  @override
  String get menuOpenRecent => 'Suuliiniig neekh';

  @override
  String get menuNoRecentFiles => 'Suuliin failuud baihgui';

  @override
  String get menuClearMenu => 'Tsesiig tsooglokh';

  @override
  String get menuSave => 'Khadgalakh';

  @override
  String get menuSaveAs => 'Uur nereeer khadgalakh...';

  @override
  String get menuSaveAll => 'Бүгдийг хадгалах';

  @override
  String get menuShare => 'Khuvaaltsakh...';

  @override
  String get menuCloseWindow => 'Tsonkhig khakh';

  @override
  String get menuCloseAll => 'Бүгдийг хаах';

  @override
  String get menuEdit => 'Засварлах';

  @override
  String get menuDelete => 'Устгах';

  @override
  String get menuView => 'Харах';

  @override
  String goToPagePrompt(int total) {
    return 'Хуудасны дугаарыг оруулна уу (1–$total):';
  }

  @override
  String get goToPageHint => 'Хуудасны дугаар';

  @override
  String get goToPageInvalid => 'Зөв тоо оруулна уу';

  @override
  String goToPageOutOfRange(int total) {
    return 'Хуудас 1-ээс $total хооронд байх ёстой';
  }

  @override
  String get menuRotateLeft => 'Зүүн тийш эргүүлэх';

  @override
  String get menuRotateRight => 'Баруун тийш эргүүлэх';

  @override
  String get menuCut => 'Таслах';

  @override
  String get menuCopy => 'Хуулах';

  @override
  String get menuPaste => 'Буулгах';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Нэмэгдээгүй зураг: $count — $limit-аас том байна';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Нэмэгдээгүй зураг: $count — $limit пикселээс том байна';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Нэмэгдээгүй зураг: $count';
  }

  @override
  String get clipboardUnavailable => 'Санах ойн хавтас боломжгүй байна';

  @override
  String get pasteImageFailed => 'Энэ зургийг нэмж чадсангүй';

  @override
  String get menuQuit => 'PDFSign-аас гарах';

  @override
  String get closeAllDialogTitle => 'Өөрчлөлтүүдийг хадгалах уу?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Хаахаас өмнө $count баримт бичигт өөрчлөлтүүдийг хадгалах уу?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Хаахаас өмнө 1 баримт бичигт өөрчлөлтүүдийг хадгалах уу?';

  @override
  String get closeAllDialogSaveAll => 'Бүгдийг хадгалах';

  @override
  String get closeAllDialogDontSave => 'Хадгалахгүй';

  @override
  String get closeAllDialogCancel => 'Цуцлах';

  @override
  String get saveFailedDialogTitle => 'Хадгалах амжилтгүй';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count баримт бичгийг хадгалж чадсангүй. Гэсэн хэдий ч хаах уу?';
  }

  @override
  String get saveFailedDialogClose => 'Гэсэн хэдий ч хаах';

  @override
  String get saveChangesTitle => 'Uurchlultiig khadgalakh uu?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ta \"$fileName\" failliin uurchlultiig khakhaskhan umnuh khadgalakh uu?';
  }

  @override
  String get saveButton => 'Khadgalakh';

  @override
  String get discardButton => 'Ustgakh';

  @override
  String get documentEdited => 'Uurchilsen';

  @override
  String get documentSaved => 'Khadgalagdsan';

  @override
  String get menuSettings => 'Tohirgoo...';

  @override
  String get menuWindow => 'Цонх';

  @override
  String get menuMinimize => 'Багасгах';

  @override
  String get menuZoom => 'Масштаб';

  @override
  String get menuBringAllToFront => 'Бүгдийг урд авчрах';

  @override
  String get settingsTitle => 'Tohirgoo';

  @override
  String get settingsLanguage => 'Khel';

  @override
  String get settingsLanguageSystem => 'Sistemiin suuri';

  @override
  String get settingsUnits => 'Khemjeekh neghj';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'Хэл хайх...';

  @override
  String get settingsGeneral => 'Ерөнхий';

  @override
  String get addImage => 'Зураг нэмэх';

  @override
  String get selectImages => 'Зураг сонгох';

  @override
  String get zoomFitWidth => 'Өргөнд тохируулах';

  @override
  String get zoomIn => 'Томруулах';

  @override
  String get zoomOut => 'Жижигрүүлэх';

  @override
  String get selectZoomLevel => 'Томруулах түвшин сонгох';

  @override
  String get goToPage => 'Хуудас руу очих';

  @override
  String get go => 'Очих';

  @override
  String get savePdfAs => 'PDF болгон хадгалах';

  @override
  String get incorrectPassword => 'Буруу нууц үг';

  @override
  String get saveFailed => 'Хадгалалт амжилтгүй';

  @override
  String savedTo(String path) {
    return 'Хадгалагдсан: $path';
  }

  @override
  String get noOriginalPdfStored => 'Эх PDF хадгалагдаагүй';

  @override
  String get waitingForFolderPermission =>
      'Хавтас руу нэвтрэх зөвшөөрөл хүлээж байна...';

  @override
  String get deleteButtonLabel => 'Устгах';

  @override
  String get deleteButtonTooltip => 'Сонгосон объектыг устгах';

  @override
  String get documentProtectedTitle => 'Энэ баримт хамгаалагдсан';

  @override
  String get documentProtectedBody => 'Нээхийн тулд нууц үгээ оруулна уу.';

  @override
  String get passwordFieldLabel => 'Нууц үг';

  @override
  String get openDocumentButton => 'Нээх';

  @override
  String get documentReadOnlyTitle =>
      'Энэ баримт өөрчлөлт хийхийг зөвшөөрдөггүй';

  @override
  String get documentReadOnlyBody =>
      'Үүнийг уншиж, хэвлэж болно, гэвч эзэмшигч нь өөрчлөхийг зөвшөөрөөгүй. Засварлахын тулд эзэмшигчийн нууц үгийг оруулна уу.';

  @override
  String get enterOwnerPassword => 'Эзэмшигчийн нууц үгийг оруулах';

  @override
  String get ownerPasswordFieldLabel => 'Эзэмшигчийн нууц үг';

  @override
  String get menuPrint => 'Хэвлэх…';

  @override
  String get menuPrintCurrentPage => 'Одоогийн хуудсыг хэвлэх';

  @override
  String get printingIsTheOwnersTitle =>
      'Энэ баримтыг зөвхөн эзэмшигч нь хэвлэж чадна';

  @override
  String get printingNotAllowed => 'Энэ баримт хэвлэхийг зөвшөөрдөггүй.';

  @override
  String get printingFailed => 'Баримтыг хэвлэж чадсангүй.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Энэ баримтын хамгаалалтыг зөвхөн эзэмшигч нь өөрчилж чадна';

  @override
  String get continueButton => 'Үргэлжлүүлэх';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Хамгаалагдсан баримтыг санах ойноос харуулдаг бөгөөд энэ нь $size хэмжээтэй. Нээхэд ойролцоогоор төдий хэмжээний санах ой зарцуулагдана.';
  }

  @override
  String get shareProtectedNotice =>
      'Хуваалцсан хувь нь баримтын нууц үгийг хадгална.';

  @override
  String get unsupportedProtection =>
      'Энэ баримтын хамгаалалтыг дэмждэггүй. PDFSign нууц үгээр хамгаалагдсан баримтуудыг нээдэг бол гэрчилгээгээр хамгаалагдсаныг нээдэггүй.';

  @override
  String get menuBringToFront => 'Хамгийн урд гаргах';

  @override
  String get menuBringForward => 'Урагш шилжүүлэх';

  @override
  String get menuSendBackward => 'Хойш шилжүүлэх';

  @override
  String get menuSendToBack => 'Хамгийн ард илгээх';

  @override
  String get zOrderGroupLabel => 'Эрэмбэлэх';

  @override
  String get menuUndo => 'Буцаах';

  @override
  String get menuRedo => 'Дахин хийх';

  @override
  String get dragToReorder => 'Дарааллыг өөрчлөхийн тулд чирнэ үү';

  @override
  String get protectDocumentTitle => 'Баримтыг хамгаалах';

  @override
  String get requirePasswordToOpen => 'Баримтыг нээхэд нууц үг шаардах';

  @override
  String get verifyFieldLabel => 'Баталгаажуулалт';

  @override
  String get permissionsHeading => 'Зөвшөөрлүүд';

  @override
  String get permissionsNote =>
      'Эзэмшигчийн нууц үг оруулахгүйгээр дараах өөрчлөлтүүдийг зөвшөөрөх.';

  @override
  String get permissionPrinting => 'Хэвлэх';

  @override
  String get permissionCopying => 'Текст болон график хуулах';

  @override
  String get permissionPageAssembly => 'Хуудас оруулах, устгах, эргүүлэх';

  @override
  String get permissionAnnotations => 'Тайлбар, гарын үсэг нэмэх';

  @override
  String get permissionChangingContent => 'Баримтыг өөрчлөх';

  @override
  String get permissionFormFilling => 'Байгаа маягтын талбаруудыг бөглөх';

  @override
  String get changingContentIncludes =>
      'Баримтыг өөрчлөх нь тайлбар хийх, маягт бөглөхийг багтаадаг — тэдгээр нь үүнтэй хамт зөвшөөрөгдөнө.';

  @override
  String get ownerPasswordHeading => 'Эзэмшигчийн нууц үг';

  @override
  String get removeProtection => 'Хамгаалалтыг арилгах';

  @override
  String get applyButton => 'Хэрэглэх';

  @override
  String get passwordsDoNotMatch => 'Нууц үгүүд таарахгүй байна';

  @override
  String get passwordCannotBeEmpty => 'Нууц үг оруулна уу';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Хязгаарлалтад эзэмшигчийн нууц үг шаардлагатай. Үүнгүйгээр хэн ч тэдгээрийг арилгаж чадна.';

  @override
  String get signingNeedsChangingContent =>
      '«Баримтыг өөрчлөх» зөвшөөрөлгүйгээр эзэмшигчийн нууц үггүйгээр энэ файлд энд дахин гарын үсэг зурах боломжгүй.';

  @override
  String get menuProtectDocument => 'Баримтыг хамгаалах…';

  @override
  String get protectButtonLabel => 'Хамгаалах';

  @override
  String get protectButtonTooltip =>
      'Энэ баримтын нууц үг, зөвшөөрлийг тохируулна уу';
}
