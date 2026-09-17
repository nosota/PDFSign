// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Serbian (`sr`).
class AppLocalizationsSr extends AppLocalizations {
  AppLocalizationsSr([String locale = 'sr']) : super(locale);

  @override
  String get openPdf => 'Отвори PDF';

  @override
  String get selectPdf => 'Изабери PDF';

  @override
  String get recentFiles => 'Недавне датотеке';

  @override
  String get removeFromList => 'Уклони са листе';

  @override
  String get openedNow => 'Управо отворено';

  @override
  String openedMinutesAgo(int count) {
    return 'Отворено пре $count минута';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Отворено пре $count сати';
  }

  @override
  String get openedYesterday => 'Отворено јуче';

  @override
  String openedDaysAgo(int count) {
    return 'Отворено пре $count дана';
  }

  @override
  String get fileNotFound => 'Датотека није пронађена';

  @override
  String get fileAccessDenied => 'Приступ одбијен';

  @override
  String get clearRecentFiles => 'Обриши недавне датотеке';

  @override
  String get cancel => 'Откажи';

  @override
  String get confirm => 'Потврди';

  @override
  String get error => 'Грешка';

  @override
  String get ok => 'У реду';

  @override
  String get menuFile => 'Датотека';

  @override
  String get menuOpen => 'Отвори...';

  @override
  String get menuOpenRecent => 'Отвори недавне';

  @override
  String get menuNoRecentFiles => 'Нема недавних датотека';

  @override
  String get menuClearMenu => 'Обриши мени';

  @override
  String get menuSave => 'Сачувај';

  @override
  String get menuSaveAs => 'Сачувај као...';

  @override
  String get menuSaveAll => 'Сачувај све';

  @override
  String get menuShare => 'Подели...';

  @override
  String get menuCloseWindow => 'Затвори прозор';

  @override
  String get menuCloseAll => 'Затвори све';

  @override
  String get menuEdit => 'Уређивање';

  @override
  String get menuDelete => 'Обриши';

  @override
  String get menuView => 'Приказ';

  @override
  String goToPagePrompt(int total) {
    return 'Унесите број странице (1–$total):';
  }

  @override
  String get goToPageHint => 'Број странице';

  @override
  String get goToPageInvalid => 'Унесите исправан број';

  @override
  String goToPageOutOfRange(int total) {
    return 'Страница мора бити између 1 и $total';
  }

  @override
  String get menuRotateLeft => 'Ротирај улево';

  @override
  String get menuRotateRight => 'Ротирај удесно';

  @override
  String get menuCut => 'Исеци';

  @override
  String get menuCopy => 'Копирај';

  @override
  String get menuPaste => 'Налепи';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Није додато слика: $count — прелазе $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Није додато слика: $count — прелазе $limit пиксела';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Није додато слика: $count';
  }

  @override
  String get clipboardUnavailable => 'Оставa није доступна';

  @override
  String get pasteImageFailed => 'Ту слику није било могуће додати';

  @override
  String get menuQuit => 'Изађи из PDFSign';

  @override
  String get closeAllDialogTitle => 'Сачувај измене?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Желите ли да сачувате измене у $count документа пре затварања?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Желите ли да сачувате измене у 1 документу пре затварања?';

  @override
  String get closeAllDialogSaveAll => 'Сачувај све';

  @override
  String get closeAllDialogDontSave => 'Не сачувај';

  @override
  String get closeAllDialogCancel => 'Откажи';

  @override
  String get saveFailedDialogTitle => 'Чување није успело';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Није успело чување $count документа. Ипак затворити?';
  }

  @override
  String get saveFailedDialogClose => 'Ипак затвори';

  @override
  String get saveChangesTitle => 'Сачувај измене?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Желите ли да сачувате измене у \"$fileName\" пре затварања?';
  }

  @override
  String get saveButton => 'Сачувај';

  @override
  String get discardButton => 'Не сачувај';

  @override
  String get documentEdited => 'Измењено';

  @override
  String get documentSaved => 'Сачувано';

  @override
  String get menuSettings => 'Подешавања...';

  @override
  String get menuWindow => 'Прозор';

  @override
  String get menuMinimize => 'Минимизуј';

  @override
  String get menuZoom => 'Увећај';

  @override
  String get menuBringAllToFront => 'Стави све напред';

  @override
  String get settingsTitle => 'Подешавања';

  @override
  String get settingsLanguage => 'Језик';

  @override
  String get settingsLanguageSystem => 'Подразумевано система';

  @override
  String get settingsUnits => 'Јединице';

  @override
  String get settingsUnitsCentimeters => 'Центиметри';

  @override
  String get settingsUnitsInches => 'Инчи';

  @override
  String get settingsSearchLanguages => 'Претражи језике...';

  @override
  String get settingsGeneral => 'Опште';

  @override
  String get addImage => 'Додај слику';

  @override
  String get selectImages => 'Изабери слике';

  @override
  String get zoomFitWidth => 'Прилагоди ширини';

  @override
  String get zoomIn => 'Увећај';

  @override
  String get zoomOut => 'Умањи';

  @override
  String get selectZoomLevel => 'Изабери ниво зумирања';

  @override
  String get goToPage => 'Иди на страницу';

  @override
  String get go => 'Иди';

  @override
  String get savePdfAs => 'Сачувај PDF као';

  @override
  String get incorrectPassword => 'Погрешна лозинка';

  @override
  String get saveFailed => 'Чување није успело';

  @override
  String savedTo(String path) {
    return 'Сачувано у: $path';
  }

  @override
  String get noOriginalPdfStored => 'Нема сачуваног оригиналног PDF-а';

  @override
  String get waitingForFolderPermission =>
      'Чекање дозволе за приступ фасцикли...';

  @override
  String get deleteButtonLabel => 'Обриши';

  @override
  String get deleteButtonTooltip => 'Обриши изабрани објекат';

  @override
  String get documentProtectedTitle => 'Овај документ је заштићен';

  @override
  String get documentProtectedBody => 'Унесите лозинку да бисте га отворили.';

  @override
  String get passwordFieldLabel => 'Лозинка';

  @override
  String get openDocumentButton => 'Отвори';

  @override
  String get documentReadOnlyTitle => 'Овај документ не дозвољава измене';

  @override
  String get documentReadOnlyBody =>
      'Може се читати и штампати, али власник није дозволио измене. Унесите власникову лозинку да бисте га уређивали.';

  @override
  String get enterOwnerPassword => 'Унесите власникову лозинку';

  @override
  String get ownerPasswordFieldLabel => 'Власникова лозинка';

  @override
  String get menuPrint => 'Штампај…';

  @override
  String get menuPrintCurrentPage => 'Штампај тренутну страницу';

  @override
  String get printingIsTheOwnersTitle =>
      'Овај документ може да штампа само власник';

  @override
  String get printingNotAllowed => 'Овај документ не дозвољава штампање.';

  @override
  String get printingFailed => 'Документ није било могуће одштампати.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Заштиту овог документа може да промени само власник';

  @override
  String get continueButton => 'Настави';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Заштићени документ приказује се из меморије, а овај заузима $size. Отварање ће потрошити отприлике толико меморије.';
  }

  @override
  String get shareProtectedNotice =>
      'Подељена копија задржава лозинку документа.';

  @override
  String get unsupportedProtection =>
      'Заштита овог документа није подржана. PDFSign отвара документе заштићене лозинком, али не и оне заштићене сертификатом.';

  @override
  String get menuBringToFront => 'Постави скроз напред';

  @override
  String get menuBringForward => 'Помери напред';

  @override
  String get menuSendBackward => 'Помери назад';

  @override
  String get menuSendToBack => 'Постави скроз назад';

  @override
  String get zOrderGroupLabel => 'Распореди';

  @override
  String get menuUndo => 'Опозови';

  @override
  String get menuRedo => 'Понови';

  @override
  String get dragToReorder => 'Превуците да промените редослед';

  @override
  String get protectDocumentTitle => 'Заштита документа';

  @override
  String get requirePasswordToOpen => 'Захтевај лозинку за отварање документа';

  @override
  String get verifyFieldLabel => 'Потврда';

  @override
  String get permissionsHeading => 'Дозволе';

  @override
  String get permissionsNote =>
      'Дозволи следеће измене без уноса власникове лозинке.';

  @override
  String get permissionPrinting => 'Штампање';

  @override
  String get permissionCopying => 'Копирање текста или графике';

  @override
  String get permissionPageAssembly => 'Уметање, брисање и ротирање страница';

  @override
  String get permissionAnnotations => 'Додавање напомена и потписа';

  @override
  String get permissionChangingContent => 'Измена документа';

  @override
  String get permissionFormFilling => 'Попуњавање постојећих поља образаца';

  @override
  String get changingContentIncludes =>
      'Измена документа обухвата напомене и попуњавање образаца — дозвољени су заједно с њом.';

  @override
  String get ownerPasswordHeading => 'Власникова лозинка';

  @override
  String get removeProtection => 'Уклони заштиту';

  @override
  String get applyButton => 'Примени';

  @override
  String get passwordsDoNotMatch => 'Лозинке се не подударају';

  @override
  String get passwordCannotBeEmpty => 'Унесите лозинку';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Ограничења захтевају власникову лозинку. Без ње их свако може уклонити.';

  @override
  String get signingNeedsChangingContent =>
      'Без ставке „Измена документа“ овај фајл овде неће моћи поново да се потпише без власникове лозинке.';

  @override
  String get menuProtectDocument => 'Заштити документ…';

  @override
  String get protectButtonLabel => 'Заштити';

  @override
  String get protectButtonTooltip =>
      'Подесите лозинке и дозволе овог документа';
}
