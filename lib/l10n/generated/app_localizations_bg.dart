// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class AppLocalizationsBg extends AppLocalizations {
  AppLocalizationsBg([String locale = 'bg']) : super(locale);

  @override
  String get openPdf => 'Отвори PDF';

  @override
  String get selectPdf => 'Избери PDF';

  @override
  String get recentFiles => 'Скорошни файлове';

  @override
  String get removeFromList => 'Премахни от списъка';

  @override
  String get openedNow => 'Току-що отворен';

  @override
  String openedMinutesAgo(int count) {
    return 'Отворен преди $count минути';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Отворен преди $count часа';
  }

  @override
  String get openedYesterday => 'Отворен вчера';

  @override
  String openedDaysAgo(int count) {
    return 'Отворен преди $count дни';
  }

  @override
  String get fileNotFound => 'Файлът не е намерен';

  @override
  String get fileAccessDenied => 'Достъпът е отказан';

  @override
  String get clearRecentFiles => 'Изчисти скорошните файлове';

  @override
  String get cancel => 'Отказ';

  @override
  String get confirm => 'Потвърди';

  @override
  String get error => 'Грешка';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Файл';

  @override
  String get menuOpen => 'Отвори...';

  @override
  String get menuOpenRecent => 'Отвори скорошни';

  @override
  String get menuNoRecentFiles => 'Няма скорошни файлове';

  @override
  String get menuClearMenu => 'Изчисти менюто';

  @override
  String get menuSave => 'Запази';

  @override
  String get menuSaveAs => 'Запази като...';

  @override
  String get menuSaveAll => 'Запази всички';

  @override
  String get menuShare => 'Сподели...';

  @override
  String get menuCloseWindow => 'Затвори прозореца';

  @override
  String get menuCloseAll => 'Затвори всички';

  @override
  String get menuEdit => 'Редактиране';

  @override
  String get menuDelete => 'Изтриване';

  @override
  String get menuView => 'Изглед';

  @override
  String goToPagePrompt(int total) {
    return 'Въведете номер на страница (1–$total):';
  }

  @override
  String get goToPageHint => 'Номер на страница';

  @override
  String get goToPageInvalid => 'Въведете валидно число';

  @override
  String goToPageOutOfRange(int total) {
    return 'Страницата трябва да е между 1 и $total';
  }

  @override
  String get menuRotateLeft => 'Завъртане наляво';

  @override
  String get menuRotateRight => 'Завъртане надясно';

  @override
  String get menuCut => 'Изрязване';

  @override
  String get menuCopy => 'Копиране';

  @override
  String get menuPaste => 'Поставяне';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Не са добавени изображения: $count — надхвърлят $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Не са добавени изображения: $count — надхвърлят $limit пиксела';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Не са добавени изображения: $count';
  }

  @override
  String get clipboardUnavailable => 'Клипбордът не е наличен';

  @override
  String get pasteImageFailed => 'Това изображение не можа да бъде добавено';

  @override
  String get menuQuit => 'Изход от PDFSign';

  @override
  String get closeAllDialogTitle => 'Запази промените?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Искате ли да запазите промените в $count документа преди затваряне?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Искате ли да запазите промените в 1 документ преди затваряне?';

  @override
  String get closeAllDialogSaveAll => 'Запази всички';

  @override
  String get closeAllDialogDontSave => 'Не запазвай';

  @override
  String get closeAllDialogCancel => 'Отказ';

  @override
  String get saveFailedDialogTitle => 'Неуспешно запазване';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Неуспешно запазване на $count документ(а). Да се затвори въпреки това?';
  }

  @override
  String get saveFailedDialogClose => 'Затвори въпреки това';

  @override
  String get saveChangesTitle => 'Запази промените?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Искате ли да запазите промените в \"$fileName\" преди затваряне?';
  }

  @override
  String get saveButton => 'Запази';

  @override
  String get discardButton => 'Не запазвай';

  @override
  String get documentEdited => 'Редактиран';

  @override
  String get documentSaved => 'Запазен';

  @override
  String get menuSettings => 'Настройки...';

  @override
  String get menuWindow => 'Прозорец';

  @override
  String get menuMinimize => 'Минимизирай';

  @override
  String get menuZoom => 'Увеличи';

  @override
  String get menuBringAllToFront => 'Покажи всички отпред';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Език';

  @override
  String get settingsLanguageSystem => 'Системен по подразбиране';

  @override
  String get settingsUnits => 'Единици';

  @override
  String get settingsUnitsCentimeters => 'Сантиметри';

  @override
  String get settingsUnitsInches => 'Инчове';

  @override
  String get settingsSearchLanguages => 'Търсене на езици...';

  @override
  String get settingsGeneral => 'Общи';

  @override
  String get addImage => 'Добави изображение';

  @override
  String get selectImages => 'Избери изображения';

  @override
  String get zoomFitWidth => 'По ширина';

  @override
  String get zoomIn => 'Увеличи';

  @override
  String get zoomOut => 'Намали';

  @override
  String get selectZoomLevel => 'Избери ниво на мащабиране';

  @override
  String get goToPage => 'Отиди на страница';

  @override
  String get go => 'Отиди';

  @override
  String get savePdfAs => 'Запази PDF като';

  @override
  String get incorrectPassword => 'Грешна парола';

  @override
  String get saveFailed => 'Неуспешно запазване';

  @override
  String savedTo(String path) {
    return 'Запазено в: $path';
  }

  @override
  String get noOriginalPdfStored => 'Няма запазен оригинален PDF';

  @override
  String get waitingForFolderPermission =>
      'Изчакване на разрешение за достъп до папката...';

  @override
  String get deleteButtonLabel => 'Изтрий';

  @override
  String get deleteButtonTooltip => 'Изтриване на избрания обект';

  @override
  String get documentProtectedTitle => 'Този документ е защитен';

  @override
  String get documentProtectedBody => 'Въведете паролата, за да го отворите.';

  @override
  String get passwordFieldLabel => 'Парола';

  @override
  String get openDocumentButton => 'Отваряне';

  @override
  String get documentReadOnlyTitle => 'Този документ не позволява промени';

  @override
  String get documentReadOnlyBody =>
      'Може да се чете и отпечатва, но собственикът не е разрешил промени. Въведете паролата на собственика, за да го редактирате.';

  @override
  String get enterOwnerPassword => 'Въведете паролата на собственика';

  @override
  String get ownerPasswordFieldLabel => 'Парола на собственика';

  @override
  String get menuPrint => 'Печат…';

  @override
  String get menuPrintCurrentPage => 'Печат на текущата страница';

  @override
  String get printingIsTheOwnersTitle =>
      'Само собственикът може да отпечата този документ';

  @override
  String get printingNotAllowed => 'Този документ не позволява печат.';

  @override
  String get printingFailed => 'Документът не можа да бъде отпечатан.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Само собственикът може да промени защитата на този документ';

  @override
  String get continueButton => 'Продължаване';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Защитеният документ се показва от паметта, а този заема $size. Отварянето му ще използва приблизително толкова.';
  }

  @override
  String get shareProtectedNotice =>
      'Споделеното копие запазва паролата на документа.';

  @override
  String get unsupportedProtection =>
      'Защитата на този документ не се поддържа. PDFSign отваря документи, защитени с парола, но не и защитените със сертификат.';

  @override
  String get menuBringToFront => 'Най-отпред';

  @override
  String get menuBringForward => 'Напред';

  @override
  String get menuSendBackward => 'Назад';

  @override
  String get menuSendToBack => 'Най-отзад';

  @override
  String get zOrderGroupLabel => 'Подреждане';

  @override
  String get menuUndo => 'Отмяна';

  @override
  String get menuRedo => 'Повторение';

  @override
  String get dragToReorder => 'Плъзнете, за да промените реда';

  @override
  String get protectDocumentTitle => 'Защита на документа';

  @override
  String get requirePasswordToOpen =>
      'Изискване на парола за отваряне на документа';

  @override
  String get verifyFieldLabel => 'Потвърждение';

  @override
  String get permissionsHeading => 'Разрешения';

  @override
  String get permissionsNote =>
      'Разрешаване на следните промени без въвеждане на паролата на собственика.';

  @override
  String get permissionPrinting => 'Печат';

  @override
  String get permissionCopying => 'Копиране на текст или графика';

  @override
  String get permissionPageAssembly =>
      'Вмъкване, изтриване и завъртане на страници';

  @override
  String get permissionAnnotations => 'Добавяне на анотации и подписи';

  @override
  String get permissionChangingContent => 'Промяна на документа';

  @override
  String get permissionFormFilling =>
      'Попълване на съществуващи полета във формуляри';

  @override
  String get changingContentIncludes =>
      'Промяната на документа включва анотиране и попълване на формуляри — те се разрешават заедно с нея.';

  @override
  String get ownerPasswordHeading => 'Парола на собственика';

  @override
  String get removeProtection => 'Премахване на защитата';

  @override
  String get applyButton => 'Прилагане';

  @override
  String get passwordsDoNotMatch => 'Паролите не съвпадат';

  @override
  String get passwordCannotBeEmpty => 'Въведете парола';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Ограниченията изискват парола на собственика. Без нея всеки може да ги премахне.';

  @override
  String get signingNeedsChangingContent =>
      'Без „Промяна на документа“ този файл няма да може да бъде подписан тук отново без паролата на собственика.';

  @override
  String get menuProtectDocument => 'Защита на документа…';

  @override
  String get protectButtonLabel => 'Защита';

  @override
  String get protectButtonTooltip =>
      'Задайте паролите и разрешенията на този документ';
}
