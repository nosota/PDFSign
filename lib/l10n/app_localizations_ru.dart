// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'PDFSign';

  @override
  String get welcomeTitle => 'Добро пожаловать в PDFSign';

  @override
  String get openPdf => 'Открыть PDF';

  @override
  String get recentFiles => 'Недавние файлы';

  @override
  String get noRecentFiles => 'Нет недавних файлов';

  @override
  String get selectPdf => 'Выбрать PDF';

  @override
  String get file => 'Файл';

  @override
  String get edit => 'Правка';

  @override
  String get view => 'Вид';

  @override
  String get help => 'Справка';

  @override
  String get save => 'Сохранить';

  @override
  String get saveAs => 'Сохранить как...';

  @override
  String get close => 'Закрыть';

  @override
  String get quit => 'Выход';

  @override
  String get undo => 'Отменить';

  @override
  String get redo => 'Повторить';

  @override
  String get delete => 'Удалить';

  @override
  String get deleteSelected => 'Удалить выделенное';

  @override
  String get zoomIn => 'Увеличить';

  @override
  String get zoomOut => 'Уменьшить';

  @override
  String get actualSize => 'Реальный размер';

  @override
  String get fitToScreen => 'По размеру экрана';

  @override
  String get fullScreen => 'Полный экран';

  @override
  String get signatures => 'Подписи';

  @override
  String get stamps => 'Печати';

  @override
  String get addSignature => 'Добавить подпись';

  @override
  String get addStamp => 'Добавить печать';

  @override
  String get add => 'Добавить';

  @override
  String get editLabel => 'Редактировать название';

  @override
  String get deleteItem => 'Удалить элемент';

  @override
  String get rotate5Left => 'Повернуть на 5° влево';

  @override
  String get rotate5Right => 'Повернуть на 5° вправо';

  @override
  String get rotate90 => 'Повернуть на 90°';

  @override
  String get scaleUp => 'Увеличить на 5%';

  @override
  String get scaleDown => 'Уменьшить на 5%';

  @override
  String get bringToFront => 'На передний план';

  @override
  String get bringForward => 'Переместить вперед';

  @override
  String get sendBackward => 'Переместить назад';

  @override
  String get sendToBack => 'На задний план';

  @override
  String pageIndicator(int current, int total) {
    return 'Страница $current из $total';
  }

  @override
  String get passwordRequired => 'Требуется пароль';

  @override
  String get enterPassword => 'Введите пароль для открытия PDF';

  @override
  String get password => 'Пароль';

  @override
  String get cancel => 'Отмена';

  @override
  String get ok => 'ОК';

  @override
  String get retry => 'Повторить';

  @override
  String attemptsRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Осталось $count попыток',
      few: 'Осталось $count попытки',
      one: 'Осталась 1 попытка',
    );
    return '$_temp0';
  }

  @override
  String get errorFileNotFound => 'Выбранный файл не найден.';

  @override
  String get errorAccessDenied =>
      'Доступ запрещен. Проверьте права доступа к файлу.';

  @override
  String get errorInvalidFormat => 'Это не является корректным PDF документом.';

  @override
  String get errorFileTooLarge => 'Размер изображения превышает лимит в 100МБ.';

  @override
  String get errorResolutionTooHigh =>
      'Разрешение изображения превышает 4096x4096 пикселей.';

  @override
  String get errorCorruptedPdf => 'Этот PDF поврежден.';

  @override
  String get errorIncorrectPassword => 'Неверный пароль.';

  @override
  String get errorWriteProtected => 'Этот PDF защищен от изменений.';

  @override
  String get errorSaveFailed => 'Не удалось сохранить PDF.';

  @override
  String get errorInsufficientSpace =>
      'Недостаточно места на диске для сохранения файла.';

  @override
  String get errorReadOnlyLocation =>
      'Невозможно сохранить в локацию только для чтения.';

  @override
  String get errorOutOfMemory =>
      'Недостаточно памяти. Попробуйте закрыть другие приложения.';

  @override
  String get errorDatabaseError =>
      'Не удалось получить доступ к библиотеке подписей.';

  @override
  String get errorUnknown => 'Произошла неизвестная ошибка.';

  @override
  String get confirmDelete => 'Вы уверены, что хотите удалить этот элемент?';

  @override
  String get confirmDeleteTitle => 'Подтверждение удаления';

  @override
  String get deleteConfirmTitle => 'Confirm Delete';

  @override
  String get unsavedChanges =>
      'У вас есть несохраненные изменения. Сохранить перед закрытием?';

  @override
  String get unsavedChangesTitle => 'Несохраненные изменения';

  @override
  String get dontSave => 'Не сохранять';

  @override
  String get loading => 'Загрузка...';

  @override
  String get saving => 'Сохранение...';

  @override
  String get processing => 'Обработка...';

  @override
  String openedAgo(String time) {
    return 'Открыт $time назад';
  }

  @override
  String get aboutApp => 'О приложении PDFSign';

  @override
  String version(String version) {
    return 'Версия $version';
  }

  @override
  String get poweredBy => 'Использует Syncfusion Community License';

  @override
  String get settings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get signatureAdded => 'Подпись добавлена в библиотеку';

  @override
  String get stampAdded => 'Печать добавлена в библиотеку';

  @override
  String get itemDeleted => 'Элемент удален из библиотеки';

  @override
  String get pdfSaved => 'PDF успешно сохранен';

  @override
  String get copyToClipboard => 'Копировать в буфер обмена';

  @override
  String get duplicate => 'Дублировать';

  @override
  String get copiedToClipboard => 'Скопировано в буфер обмена';

  @override
  String get clipboardEmpty => 'Буфер обмена пуст';

  @override
  String get unsupportedImageFormat => 'Неподдерживаемый формат изображения';

  @override
  String get errorCopyFailed => 'Failed to copy to clipboard';

  @override
  String get errorNoImageInClipboard => 'No image in clipboard';

  @override
  String get errorReadingClipboard => 'Failed to read from clipboard';

  @override
  String get errorPasteFailed => 'Failed to paste from clipboard';

  @override
  String get addingImage => 'Adding image...';

  @override
  String get imageAdded => 'Image added to library';

  @override
  String get signature => 'Signature';

  @override
  String get stamp => 'Stamp';

  @override
  String get pasteImageTitle => 'Вставить изображение';

  @override
  String get pasteImageMessage => 'Where would you like to add this image?';

  @override
  String get pasteImagePreview => 'Предпросмотр';

  @override
  String get pasteImageName => 'Название';

  @override
  String get pasteImageNameHint => 'Введите название для изображения';

  @override
  String get addToSignatures => 'Добавить в подписи';

  @override
  String get addToStamps => 'Добавить в печати';

  @override
  String get dontAddToLibrary => 'Не добавлять в библиотеку';

  @override
  String get dontAskAgain => 'Больше не спрашивать';

  @override
  String get paste => 'Вставить';

  @override
  String get clipboardBehavior => 'Поведение буфера обмена';

  @override
  String get resetPastePreference =>
      'Сбросить настройку \"Больше не спрашивать\"';

  @override
  String get defaultPasteTarget => 'Место вставки по умолчанию';

  @override
  String get noSignatures => 'No signatures yet. Add one to get started.';

  @override
  String get noStamps => 'No stamps yet. Add one to get started.';

  @override
  String get selectImage => 'Select Image';

  @override
  String get fileSizeExceeded => 'File size exceeds the maximum limit';

  @override
  String get error => 'Error';

  @override
  String get page => 'page';

  @override
  String get pages => 'pages';

  @override
  String get removeFromRecent => 'Remove from Recent';

  @override
  String get removeFromRecentConfirm =>
      'Are you sure you want to remove this file from recent files?';

  @override
  String get remove => 'Remove';

  @override
  String get noPdfOpen => 'No PDF document open';

  @override
  String get openPdfToStart => 'Open a PDF to get started';

  @override
  String get deleteConfirmMessage =>
      'This item will be removed from your library. Placed instances in documents will not be affected.';
}
