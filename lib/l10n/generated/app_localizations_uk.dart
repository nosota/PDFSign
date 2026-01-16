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
  String get menuShare => 'Поділитися...';

  @override
  String get menuCloseWindow => 'Закрити вікно';

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
}
