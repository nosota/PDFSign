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
}
