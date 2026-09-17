// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get openPdf => 'Открыть PDF';

  @override
  String get selectPdf => 'Выбрать PDF';

  @override
  String get recentFiles => 'Недавние файлы';

  @override
  String get removeFromList => 'Удалить из списка';

  @override
  String get openedNow => 'Открыт только что';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'минут',
      many: 'минут',
      few: 'минуты',
      one: 'минуту',
    );
    return 'Открыт $count $_temp0 назад';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'часа',
      many: 'часов',
      few: 'часа',
      one: 'час',
    );
    return 'Открыт $count $_temp0 назад';
  }

  @override
  String get openedYesterday => 'Открыт вчера';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'дней',
      many: 'дней',
      few: 'дня',
      one: 'день',
    );
    return 'Открыт $count $_temp0 назад';
  }

  @override
  String get fileNotFound => 'Файл не найден';

  @override
  String get fileAccessDenied => 'Доступ запрещён';

  @override
  String get clearRecentFiles => 'Очистить недавние файлы';

  @override
  String get cancel => 'Отмена';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get error => 'Ошибка';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Файл';

  @override
  String get menuOpen => 'Открыть...';

  @override
  String get menuOpenRecent => 'Открыть недавние';

  @override
  String get menuNoRecentFiles => 'Нет недавних файлов';

  @override
  String get menuClearMenu => 'Очистить меню';

  @override
  String get menuSave => 'Сохранить';

  @override
  String get menuSaveAs => 'Сохранить как...';

  @override
  String get menuSaveAll => 'Сохранить все';

  @override
  String get menuShare => 'Поделиться...';

  @override
  String get menuCloseWindow => 'Закрыть окно';

  @override
  String get menuCloseAll => 'Закрыть все';

  @override
  String get menuEdit => 'Редактирование';

  @override
  String get menuDelete => 'Удалить';

  @override
  String get menuView => 'Вид';

  @override
  String goToPagePrompt(int total) {
    return 'Введите номер страницы (1-$total):';
  }

  @override
  String get goToPageHint => 'Номер страницы';

  @override
  String get goToPageInvalid => 'Введите число';

  @override
  String goToPageOutOfRange(int total) {
    return 'Страница должна быть от 1 до $total';
  }

  @override
  String get menuRotateLeft => 'Повернуть влево';

  @override
  String get menuRotateRight => 'Повернуть вправо';

  @override
  String get menuCut => 'Вырезать';

  @override
  String get menuCopy => 'Копировать';

  @override
  String get menuPaste => 'Вставить';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Не добавлено: $count изображени(я) больше $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Не добавлено: $count изображени(я) больше $limit пикселей';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Не добавлено изображений: $count';
  }

  @override
  String get clipboardUnavailable => 'Буфер обмена недоступен';

  @override
  String get pasteImageFailed => 'Не удалось добавить изображение';

  @override
  String get menuQuit => 'Выход из PDFSign';

  @override
  String get closeAllDialogTitle => 'Сохранить изменения?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Хотите сохранить изменения в $count документах перед закрытием?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Хотите сохранить изменения в 1 документе перед закрытием?';

  @override
  String get closeAllDialogSaveAll => 'Сохранить все';

  @override
  String get closeAllDialogDontSave => 'Не сохранять';

  @override
  String get closeAllDialogCancel => 'Отмена';

  @override
  String get saveFailedDialogTitle => 'Ошибка сохранения';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Не удалось сохранить $count документ(ов). Всё равно закрыть?';
  }

  @override
  String get saveFailedDialogClose => 'Всё равно закрыть';

  @override
  String get saveChangesTitle => 'Сохранить изменения?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Сохранить изменения в «$fileName» перед закрытием?';
  }

  @override
  String get saveButton => 'Сохранить';

  @override
  String get discardButton => 'Не сохранять';

  @override
  String get documentEdited => 'Изменён';

  @override
  String get documentSaved => 'Сохранён';

  @override
  String get menuSettings => 'Настройки...';

  @override
  String get menuWindow => 'Окно';

  @override
  String get menuMinimize => 'Свернуть';

  @override
  String get menuZoom => 'Изменить масштаб';

  @override
  String get menuBringAllToFront => 'Все окна — на передний план';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageSystem => 'Системный по умолчанию';

  @override
  String get settingsUnits => 'Единицы';

  @override
  String get settingsUnitsCentimeters => 'Сантиметры';

  @override
  String get settingsUnitsInches => 'Дюймы';

  @override
  String get settingsSearchLanguages => 'Поиск языков...';

  @override
  String get settingsGeneral => 'Основные';

  @override
  String get addImage => 'Добавить изображение';

  @override
  String get selectImages => 'Выбрать изображения';

  @override
  String get zoomFitWidth => 'По ширине';

  @override
  String get zoomIn => 'Увеличить';

  @override
  String get zoomOut => 'Уменьшить';

  @override
  String get selectZoomLevel => 'Выбрать масштаб';

  @override
  String get goToPage => 'Перейти к странице';

  @override
  String get go => 'Перейти';

  @override
  String get savePdfAs => 'Сохранить PDF как';

  @override
  String get incorrectPassword => 'Неверный пароль';

  @override
  String get saveFailed => 'Ошибка сохранения';

  @override
  String savedTo(String path) {
    return 'Сохранено: $path';
  }

  @override
  String get noOriginalPdfStored => 'Исходный PDF не найден';

  @override
  String get waitingForFolderPermission =>
      'Ожидание разрешения на доступ к папке...';

  @override
  String get deleteButtonLabel => 'Удалить';

  @override
  String get deleteButtonTooltip => 'Удалить выбранный объект';

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

  @override
  String get dragToReorder => 'Drag to reorder';

  @override
  String get protectDocumentTitle => 'Protect Document';

  @override
  String get requirePasswordToOpen => 'Require Password To Open Document';

  @override
  String get verifyFieldLabel => 'Verify';

  @override
  String get permissionsHeading => 'Permissions';

  @override
  String get permissionsNote =>
      'Allow the following changes to be made without entering the owner password.';

  @override
  String get permissionPrinting => 'Printing';

  @override
  String get permissionCopying => 'Copying Text or Graphics';

  @override
  String get permissionPageAssembly => 'Inserting, Deleting, or Rotating Pages';

  @override
  String get permissionAnnotations => 'Adding Annotations or Signatures';

  @override
  String get permissionChangingContent => 'Changing the Document';

  @override
  String get permissionFormFilling => 'Filling Existing Form Fields';

  @override
  String get changingContentIncludes =>
      'Changing the document includes annotating and filling in forms, so those are granted with it.';

  @override
  String get ownerPasswordHeading => 'Owner Password';

  @override
  String get removeProtection => 'Remove Protection';

  @override
  String get applyButton => 'Apply';

  @override
  String get passwordsDoNotMatch => 'The passwords do not match';

  @override
  String get passwordCannotBeEmpty => 'Enter a password';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Restrictions need an owner password. Without one, anyone can lift them.';

  @override
  String get signingNeedsChangingContent =>
      'Without “Changing the Document”, this file cannot be signed here again unless the owner password is given.';

  @override
  String get menuProtectDocument => 'Protect Document…';

  @override
  String get protectButtonLabel => 'Protect';

  @override
  String get protectButtonTooltip =>
      'Set this document\'s passwords and permissions';
}
