// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get openPdf => 'Відкрити PDF';

  @override
  String get selectPdf => 'Вибрати PDF';

  @override
  String get recentFiles => 'Нещодавні файли';

  @override
  String get removeFromList => 'Видалити зі списку';

  @override
  String get openedNow => 'Щойно відкрито';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'хвилин',
      many: 'хвилин',
      few: 'хвилини',
      one: 'хвилину',
    );
    return 'Відкрито $count $_temp0 тому';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'годин',
      many: 'годин',
      few: 'години',
      one: 'годину',
    );
    return 'Відкрито $count $_temp0 тому';
  }

  @override
  String get openedYesterday => 'Відкрито вчора';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'днів',
      many: 'днів',
      few: 'дні',
      one: 'день',
    );
    return 'Відкрито $count $_temp0 тому';
  }

  @override
  String get fileNotFound => 'Файл не знайдено';

  @override
  String get fileAccessDenied => 'Доступ заборонено';

  @override
  String get clearRecentFiles => 'Очистити нещодавні файли';

  @override
  String get cancel => 'Скасувати';

  @override
  String get confirm => 'Підтвердити';

  @override
  String get error => 'Помилка';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Файл';

  @override
  String get menuOpen => 'Відкрити...';

  @override
  String get menuOpenRecent => 'Відкрити нещодавні';

  @override
  String get menuNoRecentFiles => 'Немає нещодавніх файлів';

  @override
  String get menuClearMenu => 'Очистити меню';

  @override
  String get menuSave => 'Зберегти';

  @override
  String get menuSaveAs => 'Зберегти як...';

  @override
  String get menuSaveAll => 'Зберегти все';

  @override
  String get menuShare => 'Поділитися...';

  @override
  String get menuCloseWindow => 'Закрити вікно';

  @override
  String get menuCloseAll => 'Закрити все';

  @override
  String get menuEdit => 'Редагування';

  @override
  String get menuDelete => 'Видалити';

  @override
  String get menuView => 'Вигляд';

  @override
  String goToPagePrompt(int total) {
    return 'Введіть номер сторінки (1–$total):';
  }

  @override
  String get goToPageHint => 'Номер сторінки';

  @override
  String get goToPageInvalid => 'Введіть правильне число';

  @override
  String goToPageOutOfRange(int total) {
    return 'Сторінка має бути від 1 до $total';
  }

  @override
  String get menuRotateLeft => 'Повернути ліворуч';

  @override
  String get menuRotateRight => 'Повернути праворуч';

  @override
  String get menuCut => 'Вирізати';

  @override
  String get menuCopy => 'Копіювати';

  @override
  String get menuPaste => 'Вставити';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Не додано зображень: $count — розмір перевищує $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Не додано зображень: $count — розмір перевищує $limit пікселів';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Не додано зображень: $count';
  }

  @override
  String get clipboardUnavailable => 'Буфер обміну недоступний';

  @override
  String get pasteImageFailed => 'Не вдалося додати зображення';

  @override
  String get menuQuit => 'Вийти з PDFSign';

  @override
  String get closeAllDialogTitle => 'Зберегти зміни?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Бажаєте зберегти зміни у $count документах перед закриттям?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Бажаєте зберегти зміни у 1 документі перед закриттям?';

  @override
  String get closeAllDialogSaveAll => 'Зберегти все';

  @override
  String get closeAllDialogDontSave => 'Не зберігати';

  @override
  String get closeAllDialogCancel => 'Скасувати';

  @override
  String get saveFailedDialogTitle => 'Помилка збереження';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Не вдалося зберегти $count документ(ів). Все одно закрити?';
  }

  @override
  String get saveFailedDialogClose => 'Все одно закрити';

  @override
  String get saveChangesTitle => 'Зберегти зміни?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Бажаєте зберегти зміни у \"$fileName\" перед закриттям?';
  }

  @override
  String get saveButton => 'Зберегти';

  @override
  String get discardButton => 'Не зберігати';

  @override
  String get documentEdited => 'Змінено';

  @override
  String get documentSaved => 'Збережено';

  @override
  String get menuSettings => 'Налаштування...';

  @override
  String get menuWindow => 'Вікно';

  @override
  String get menuMinimize => 'Згорнути';

  @override
  String get menuZoom => 'Масштаб';

  @override
  String get menuBringAllToFront => 'Усі вікна наперед';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get settingsLanguage => 'Мова';

  @override
  String get settingsLanguageSystem => 'Системна за замовчуванням';

  @override
  String get settingsUnits => 'Одиниці';

  @override
  String get settingsUnitsCentimeters => 'Сантиметри';

  @override
  String get settingsUnitsInches => 'Дюйми';

  @override
  String get settingsSearchLanguages => 'Пошук мов...';

  @override
  String get settingsGeneral => 'Загальні';

  @override
  String get addImage => 'Додати зображення';

  @override
  String get selectImages => 'Вибрати зображення';

  @override
  String get zoomFitWidth => 'За шириною';

  @override
  String get zoomIn => 'Збільшити';

  @override
  String get zoomOut => 'Зменшити';

  @override
  String get selectZoomLevel => 'Вибрати масштаб';

  @override
  String get goToPage => 'Перейти до сторінки';

  @override
  String get go => 'Перейти';

  @override
  String get savePdfAs => 'Зберегти PDF як';

  @override
  String get incorrectPassword => 'Невірний пароль';

  @override
  String get saveFailed => 'Помилка збереження';

  @override
  String savedTo(String path) {
    return 'Збережено: $path';
  }

  @override
  String get noOriginalPdfStored => 'Оригінальний PDF не знайдено';

  @override
  String get waitingForFolderPermission =>
      'Очікування дозволу на доступ до папки...';

  @override
  String get deleteButtonLabel => 'Видалити';

  @override
  String get deleteButtonTooltip => 'Видалити вибраний об\'єкт';

  @override
  String get documentProtectedTitle => 'Документ захищено';

  @override
  String get documentProtectedBody => 'Введіть пароль, щоб відкрити його.';

  @override
  String get passwordFieldLabel => 'Пароль';

  @override
  String get openDocumentButton => 'Відкрити';

  @override
  String get documentReadOnlyTitle => 'Документ не дозволяє змін';

  @override
  String get documentReadOnlyBody =>
      'Його можна читати й друкувати, але власник не дозволив вносити зміни. Введіть пароль власника, щоб редагувати документ.';

  @override
  String get enterOwnerPassword => 'Ввести пароль власника';

  @override
  String get ownerPasswordFieldLabel => 'Пароль власника';

  @override
  String get menuPrint => 'Друк…';

  @override
  String get menuPrintCurrentPage => 'Друк поточної сторінки';

  @override
  String get printingIsTheOwnersTitle =>
      'Друкувати цей документ може лише власник';

  @override
  String get printingNotAllowed => 'Документ не дозволяє друк.';

  @override
  String get printingFailed => 'Не вдалося надрукувати документ.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Змінити захист документа може лише власник';

  @override
  String get continueButton => 'Продовжити';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Захищений документ показується з пам’яті, а його обсяг — $size. Відкриття займе приблизно стільки ж.';
  }

  @override
  String get shareProtectedNotice =>
      'Надіслана копія зберігає пароль документа.';

  @override
  String get unsupportedProtection =>
      'Такий вид захисту не підтримується. PDFSign відкриває документи, захищені паролем, але не сертифікатом.';

  @override
  String get menuBringToFront => 'На передній план';

  @override
  String get menuBringForward => 'Перемістити вперед';

  @override
  String get menuSendBackward => 'Перемістити назад';

  @override
  String get menuSendToBack => 'На задній план';

  @override
  String get zOrderGroupLabel => 'Порядок';

  @override
  String get menuUndo => 'Скасувати дію';

  @override
  String get menuRedo => 'Повторити дію';

  @override
  String get dragToReorder => 'Перетягніть, щоб змінити порядок';

  @override
  String get protectDocumentTitle => 'Захист документа';

  @override
  String get requirePasswordToOpen =>
      'Запитувати пароль під час відкриття документа';

  @override
  String get verifyFieldLabel => 'Підтвердження';

  @override
  String get permissionsHeading => 'Дозволи';

  @override
  String get permissionsNote =>
      'Дозволити наведені дії без введення пароля власника.';

  @override
  String get permissionPrinting => 'Друк';

  @override
  String get permissionCopying => 'Копіювання тексту та графіки';

  @override
  String get permissionPageAssembly =>
      'Вставлення, видалення та повертання сторінок';

  @override
  String get permissionAnnotations => 'Додавання анотацій і підписів';

  @override
  String get permissionChangingContent => 'Змінювання документа';

  @override
  String get permissionFormFilling => 'Заповнення наявних полів форм';

  @override
  String get changingContentIncludes =>
      'Змінювання документа охоплює анотування та заповнення форм — вони дозволяються разом із ним.';

  @override
  String get ownerPasswordHeading => 'Пароль власника';

  @override
  String get removeProtection => 'Зняти захист';

  @override
  String get applyButton => 'Застосувати';

  @override
  String get passwordsDoNotMatch => 'Паролі не збігаються';

  @override
  String get passwordCannotBeEmpty => 'Введіть пароль';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Для обмежень потрібен пароль власника. Без нього їх може зняти будь-хто.';

  @override
  String get signingNeedsChangingContent =>
      'Без пункту „Змінювання документа“ цей файл не можна буде підписати тут знову, якщо не ввести пароль власника.';

  @override
  String get menuProtectDocument => 'Захистити документ…';

  @override
  String get protectButtonLabel => 'Захист';

  @override
  String get protectButtonTooltip => 'Задати паролі та дозволи документа';
}
