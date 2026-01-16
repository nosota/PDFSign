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
  String get menuShare => 'Подели...';

  @override
  String get menuCloseWindow => 'Затвори прозор';

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
}
