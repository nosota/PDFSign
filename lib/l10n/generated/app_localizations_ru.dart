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
  String get documentProtectedTitle => 'Документ защищён';

  @override
  String get documentProtectedBody => 'Введите пароль, чтобы открыть его.';

  @override
  String get passwordFieldLabel => 'Пароль';

  @override
  String get openDocumentButton => 'Открыть';

  @override
  String get documentReadOnlyTitle => 'Документ не разрешает изменения';

  @override
  String get documentReadOnlyBody =>
      'Его можно читать и печатать, но владелец не разрешил вносить изменения. Введите пароль владельца, чтобы редактировать документ.';

  @override
  String get enterOwnerPassword => 'Ввести пароль владельца';

  @override
  String get ownerPasswordFieldLabel => 'Пароль владельца';

  @override
  String get menuPrint => 'Печать…';

  @override
  String get menuPrintCurrentPage => 'Печать текущей страницы';

  @override
  String get printingIsTheOwnersTitle =>
      'Печатать этот документ может только владелец';

  @override
  String get printingNotAllowed => 'Документ не разрешает печать.';

  @override
  String get printingFailed => 'Не удалось напечатать документ.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Изменить защиту документа может только владелец';

  @override
  String get continueButton => 'Продолжить';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Защищённый документ показывается из памяти, а его объём — $size. Открытие займёт примерно столько же.';
  }

  @override
  String get shareProtectedNotice =>
      'Отправленная копия сохраняет пароль документа.';

  @override
  String get unsupportedProtection =>
      'Такой вид защиты не поддерживается. PDFSign открывает документы, защищённые паролем, но не сертификатом.';

  @override
  String get menuBringToFront => 'На передний план';

  @override
  String get menuBringForward => 'Переместить вперёд';

  @override
  String get menuSendBackward => 'Переместить назад';

  @override
  String get menuSendToBack => 'На задний план';

  @override
  String get zOrderGroupLabel => 'Порядок';

  @override
  String get menuUndo => 'Отменить';

  @override
  String get menuRedo => 'Повторить';

  @override
  String get dragToReorder => 'Перетащите, чтобы изменить порядок';

  @override
  String get protectDocumentTitle => 'Защита документа';

  @override
  String get requirePasswordToOpen =>
      'Запрашивать пароль при открытии документа';

  @override
  String get verifyFieldLabel => 'Подтверждение';

  @override
  String get permissionsHeading => 'Разрешения';

  @override
  String get permissionsNote =>
      'Разрешить следующие действия без ввода пароля владельца.';

  @override
  String get permissionPrinting => 'Печать';

  @override
  String get permissionCopying => 'Копирование текста и графики';

  @override
  String get permissionPageAssembly => 'Вставка, удаление и поворот страниц';

  @override
  String get permissionAnnotations => 'Добавление аннотаций и подписей';

  @override
  String get permissionChangingContent => 'Изменение документа';

  @override
  String get permissionFormFilling => 'Заполнение существующих полей форм';

  @override
  String get changingContentIncludes =>
      'Изменение документа включает аннотирование и заполнение форм — они разрешаются вместе с ним.';

  @override
  String get ownerPasswordHeading => 'Пароль владельца';

  @override
  String get removeProtection => 'Снять защиту';

  @override
  String get applyButton => 'Применить';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get passwordCannotBeEmpty => 'Введите пароль';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Для ограничений нужен пароль владельца. Без него их может снять кто угодно.';

  @override
  String get signingNeedsChangingContent =>
      'Без пункта „Изменение документа“ этот файл нельзя будет подписать здесь снова, если не ввести пароль владельца.';

  @override
  String get menuProtectDocument => 'Защитить документ…';

  @override
  String get protectButtonLabel => 'Защита';

  @override
  String get protectButtonTooltip => 'Задать пароли и разрешения документа';
}
