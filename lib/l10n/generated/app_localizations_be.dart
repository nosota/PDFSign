// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Belarusian (`be`).
class AppLocalizationsBe extends AppLocalizations {
  AppLocalizationsBe([String locale = 'be']) : super(locale);

  @override
  String get openPdf => 'Адкрыць PDF';

  @override
  String get selectPdf => 'Выбраць PDF';

  @override
  String get recentFiles => 'Нядаўнія файлы';

  @override
  String get removeFromList => 'Выдаліць са спісу';

  @override
  String get openedNow => 'Толькі што адкрыта';

  @override
  String openedMinutesAgo(int count) {
    return 'Адкрыта $count хвілін таму';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Адкрыта $count гадзін таму';
  }

  @override
  String get openedYesterday => 'Адкрыта ўчора';

  @override
  String openedDaysAgo(int count) {
    return 'Адкрыта $count дзён таму';
  }

  @override
  String get fileNotFound => 'Файл не знойдзены';

  @override
  String get fileAccessDenied => 'Доступ забаронены';

  @override
  String get clearRecentFiles => 'Ачысціць нядаўнія файлы';

  @override
  String get cancel => 'Скасаваць';

  @override
  String get confirm => 'Пацвердзіць';

  @override
  String get error => 'Памылка';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Файл';

  @override
  String get menuOpen => 'Адкрыць...';

  @override
  String get menuOpenRecent => 'Адкрыць нядаўнія';

  @override
  String get menuNoRecentFiles => 'Няма нядаўніх файлаў';

  @override
  String get menuClearMenu => 'Ачысціць меню';

  @override
  String get menuSave => 'Захаваць';

  @override
  String get menuSaveAs => 'Захаваць як...';

  @override
  String get menuShare => 'Падзяліцца...';

  @override
  String get menuCloseWindow => 'Закрыць акно';

  @override
  String get saveChangesTitle => 'Захаваць змены?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Хочаце захаваць змены ў \"$fileName\" перад закрыццём?';
  }

  @override
  String get saveButton => 'Захаваць';

  @override
  String get discardButton => 'Не захоўваць';

  @override
  String get documentEdited => 'Зменены';

  @override
  String get documentSaved => 'Захаваны';

  @override
  String get menuSettings => 'Налады...';

  @override
  String get settingsTitle => 'Налады';

  @override
  String get settingsLanguage => 'Мова';

  @override
  String get settingsLanguageSystem => 'Сістэмная па змаўчанні';

  @override
  String get settingsUnits => 'Адзінкі';

  @override
  String get settingsUnitsCentimeters => 'Сантыметры';

  @override
  String get settingsUnitsInches => 'Цалі';

  @override
  String get settingsSearchLanguages => 'Пошук моў...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Add Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get zoomFitWidth => 'Fit Width';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get selectZoomLevel => 'Select zoom level';

  @override
  String get goToPage => 'Go to Page';

  @override
  String get go => 'Go';

  @override
  String get savePdfAs => 'Save PDF As';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get saveFailed => 'Save failed';

  @override
  String savedTo(String path) {
    return 'Saved to: $path';
  }

  @override
  String get noOriginalPdfStored => 'No original PDF stored';
}
