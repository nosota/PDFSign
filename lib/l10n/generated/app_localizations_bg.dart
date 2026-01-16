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
  String get menuShare => 'Сподели...';

  @override
  String get menuCloseWindow => 'Затвори прозореца';

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
}
