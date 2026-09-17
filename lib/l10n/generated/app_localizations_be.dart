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
  String get menuSaveAll => 'Захаваць усё';

  @override
  String get menuShare => 'Падзяліцца...';

  @override
  String get menuCloseWindow => 'Закрыць акно';

  @override
  String get menuCloseAll => 'Закрыць усе';

  @override
  String get menuEdit => 'Рэдагаванне';

  @override
  String get menuDelete => 'Выдаліць';

  @override
  String get menuView => 'Выгляд';

  @override
  String goToPagePrompt(int total) {
    return 'Увядзіце нумар старонкі (1–$total):';
  }

  @override
  String get goToPageHint => 'Нумар старонкі';

  @override
  String get goToPageInvalid => 'Увядзіце правільны лік';

  @override
  String goToPageOutOfRange(int total) {
    return 'Старонка мусіць быць ад 1 да $total';
  }

  @override
  String get menuRotateLeft => 'Павярнуць улева';

  @override
  String get menuRotateRight => 'Павярнуць управа';

  @override
  String get menuCut => 'Выразаць';

  @override
  String get menuCopy => 'Капіяваць';

  @override
  String get menuPaste => 'Уставіць';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Не дададзена выяў: $count — памер перавышае $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Не дададзена выяў: $count — памер перавышае $limit пікселяў';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Не дададзена выяў: $count';
  }

  @override
  String get clipboardUnavailable => 'Буфер абмену недаступны';

  @override
  String get pasteImageFailed => 'Не ўдалося дадаць выяву';

  @override
  String get menuQuit => 'Выхад з PDFSign';

  @override
  String get closeAllDialogTitle => 'Захаваць змены?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Хочаце захаваць змены ў $count дакументах перад закрыццём?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Хочаце захаваць змены ў 1 дакуменце перад закрыццём?';

  @override
  String get closeAllDialogSaveAll => 'Захаваць усе';

  @override
  String get closeAllDialogDontSave => 'Не захоўваць';

  @override
  String get closeAllDialogCancel => 'Скасаваць';

  @override
  String get saveFailedDialogTitle => 'Памылка захавання';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Не ўдалося захаваць $count дакумент(аў). Усё роўна закрыць?';
  }

  @override
  String get saveFailedDialogClose => 'Усё роўна закрыць';

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
  String get menuWindow => 'Акно';

  @override
  String get menuMinimize => 'Згарнуць';

  @override
  String get menuZoom => 'Маштабаванне';

  @override
  String get menuBringAllToFront => 'Усе акны наперад';

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
  String get settingsGeneral => 'Агульныя';

  @override
  String get addImage => 'Дадаць выяву';

  @override
  String get selectImages => 'Выбраць выявы';

  @override
  String get zoomFitWidth => 'Па шырыні';

  @override
  String get zoomIn => 'Павялічыць';

  @override
  String get zoomOut => 'Паменшыць';

  @override
  String get selectZoomLevel => 'Выбраць маштаб';

  @override
  String get goToPage => 'Перайсці да старонкі';

  @override
  String get go => 'Перайсці';

  @override
  String get savePdfAs => 'Захаваць PDF як';

  @override
  String get incorrectPassword => 'Няправільны пароль';

  @override
  String get saveFailed => 'Памылка захавання';

  @override
  String savedTo(String path) {
    return 'Захавана: $path';
  }

  @override
  String get noOriginalPdfStored => 'Арыгінальны PDF не знойдзены';

  @override
  String get waitingForFolderPermission =>
      'Чаканне дазволу на доступ да папкі...';

  @override
  String get deleteButtonLabel => 'Выдаліць';

  @override
  String get deleteButtonTooltip => 'Выдаліць выбраны аб\'ект';

  @override
  String get documentProtectedTitle => 'Дакумент абаронены';

  @override
  String get documentProtectedBody => 'Увядзіце пароль, каб адкрыць яго.';

  @override
  String get passwordFieldLabel => 'Пароль';

  @override
  String get openDocumentButton => 'Адкрыць';

  @override
  String get documentReadOnlyTitle => 'Дакумент не дазваляе зменаў';

  @override
  String get documentReadOnlyBody =>
      'Яго можна чытаць і друкаваць, але ўладальнік не дазволіў уносіць змены. Увядзіце пароль уладальніка, каб рэдагаваць дакумент.';

  @override
  String get enterOwnerPassword => 'Увесці пароль уладальніка';

  @override
  String get ownerPasswordFieldLabel => 'Пароль уладальніка';

  @override
  String get menuPrint => 'Друк…';

  @override
  String get menuPrintCurrentPage => 'Друк бягучай старонкі';

  @override
  String get printingIsTheOwnersTitle =>
      'Друкаваць гэты дакумент можа толькі ўладальнік';

  @override
  String get printingNotAllowed => 'Дакумент не дазваляе друк.';

  @override
  String get printingFailed => 'Не ўдалося надрукаваць дакумент.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Змяніць абарону дакумента можа толькі ўладальнік';

  @override
  String get continueButton => 'Працягнуць';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Абаронены дакумент паказваецца з памяці, а яго памер — $size. Адкрыццё зойме прыкладна столькі ж.';
  }

  @override
  String get shareProtectedNotice =>
      'Дасланая копія захоўвае пароль дакумента.';

  @override
  String get unsupportedProtection =>
      'Такі від абароны не падтрымліваецца. PDFSign адкрывае дакументы, абароненыя паролем, але не сертыфікатам.';

  @override
  String get menuBringToFront => 'На пярэдні план';

  @override
  String get menuBringForward => 'Перамясціць наперад';

  @override
  String get menuSendBackward => 'Перамясціць назад';

  @override
  String get menuSendToBack => 'На задні план';

  @override
  String get zOrderGroupLabel => 'Парадак';

  @override
  String get menuUndo => 'Адмяніць';

  @override
  String get menuRedo => 'Паўтарыць';

  @override
  String get dragToReorder => 'Перацягніце, каб змяніць парадак';

  @override
  String get protectDocumentTitle => 'Абарона дакумента';

  @override
  String get requirePasswordToOpen => 'Запытваць пароль пры адкрыцці дакумента';

  @override
  String get verifyFieldLabel => 'Пацвярджэнне';

  @override
  String get permissionsHeading => 'Дазволы';

  @override
  String get permissionsNote =>
      'Дазволіць наступныя дзеянні без уводу пароля ўладальніка.';

  @override
  String get permissionPrinting => 'Друк';

  @override
  String get permissionCopying => 'Капіяванне тэксту і графікі';

  @override
  String get permissionPageAssembly => 'Устаўка, выдаленне і паварот старонак';

  @override
  String get permissionAnnotations => 'Даданне анатацый і подпісаў';

  @override
  String get permissionChangingContent => 'Змяненне дакумента';

  @override
  String get permissionFormFilling => 'Запаўненне наяўных палёў формаў';

  @override
  String get changingContentIncludes =>
      'Змяненне дакумента ўключае анатаванне і запаўненне формаў — яны дазваляюцца разам з ім.';

  @override
  String get ownerPasswordHeading => 'Пароль уладальніка';

  @override
  String get removeProtection => 'Зняць абарону';

  @override
  String get applyButton => 'Ужыць';

  @override
  String get passwordsDoNotMatch => 'Паролі не супадаюць';

  @override
  String get passwordCannotBeEmpty => 'Увядзіце пароль';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Для абмежаванняў патрэбны пароль уладальніка. Без яго іх можа зняць хто заўгодна.';

  @override
  String get signingNeedsChangingContent =>
      'Без пункта „Змяненне дакумента“ гэты файл нельга будзе падпісаць тут зноў, калі не ўвесці пароль уладальніка.';

  @override
  String get menuProtectDocument => 'Абараніць дакумент…';

  @override
  String get protectButtonLabel => 'Абарона';

  @override
  String get protectButtonTooltip => 'Задаць паролі і дазволы дакумента';
}
