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
  String get menuShare => 'Поделиться...';

  @override
  String get menuCloseWindow => 'Закрыть окно';

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
}
