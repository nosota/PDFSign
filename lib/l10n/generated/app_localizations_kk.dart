// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get openPdf => 'PDF ashu';

  @override
  String get selectPdf => 'PDF tandau';

  @override
  String get recentFiles => 'Songhy fayldar';

  @override
  String get removeFromList => 'Tizimnen oshiru';

  @override
  String get openedNow => 'Kazir ashyldy';

  @override
  String openedMinutesAgo(int count) {
    return '$count minut buryn ashyldy';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count saghat buryn ashyldy';
  }

  @override
  String get openedYesterday => 'Keshe ashyldy';

  @override
  String openedDaysAgo(int count) {
    return '$count kun buryn ashyldy';
  }

  @override
  String get fileNotFound => 'Fayl tabylmady';

  @override
  String get fileAccessDenied => 'Kiru tyiym salyndy';

  @override
  String get clearRecentFiles => 'Songhy fayldardy tazalau';

  @override
  String get cancel => 'Boldyrmai';

  @override
  String get confirm => 'Rastau';

  @override
  String get error => 'Qate';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Ashu...';

  @override
  String get menuOpenRecent => 'Songhylardy ashu';

  @override
  String get menuNoRecentFiles => 'Songhy fayldar zhoq';

  @override
  String get menuClearMenu => 'Menudi tazalau';

  @override
  String get menuSave => 'Saqtau';

  @override
  String get menuSaveAs => 'Basqasha saqtau...';

  @override
  String get menuSaveAll => 'Барлығын сақтау';

  @override
  String get menuShare => 'Bolisu...';

  @override
  String get menuCloseWindow => 'Terezeni zhabu';

  @override
  String get menuCloseAll => 'Барлығын жабу';

  @override
  String get menuEdit => 'Өңдеу';

  @override
  String get menuDelete => 'Жою';

  @override
  String get menuView => 'Көрініс';

  @override
  String goToPagePrompt(int total) {
    return 'Бет нөмірін енгізіңіз (1–$total):';
  }

  @override
  String get goToPageHint => 'Бет нөмірі';

  @override
  String get goToPageInvalid => 'Жарамды сан енгізіңіз';

  @override
  String goToPageOutOfRange(int total) {
    return 'Бет 1 мен $total аралығында болуы тиіс';
  }

  @override
  String get menuRotateLeft => 'Солға бұру';

  @override
  String get menuRotateRight => 'Оңға бұру';

  @override
  String get menuCut => 'Қиып алу';

  @override
  String get menuCopy => 'Көшіру';

  @override
  String get menuPaste => 'Қою';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Қосылмаған суреттер: $count — $limit шамасынан асады';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Қосылмаған суреттер: $count — $limit пикселден асады';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Қосылмаған суреттер: $count';
  }

  @override
  String get clipboardUnavailable => 'Алмасу буфері қолжетімсіз';

  @override
  String get pasteImageFailed => 'Бұл суретті қосу мүмкін болмады';

  @override
  String get menuQuit => 'PDFSign-нан шығу';

  @override
  String get closeAllDialogTitle => 'Өзгерістерді сақтау керек пе?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Жабу алдында $count құжаттағы өзгерістерді сақтағыңыз келе ме?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Жабу алдында 1 құжаттағы өзгерістерді сақтағыңыз келе ме?';

  @override
  String get closeAllDialogSaveAll => 'Барлығын сақтау';

  @override
  String get closeAllDialogDontSave => 'Сақтамау';

  @override
  String get closeAllDialogCancel => 'Болдырмау';

  @override
  String get saveFailedDialogTitle => 'Сақтау сәтсіз аяқталды';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count құжатты сақтау сәтсіз. Бәрібір жабу керек пе?';
  }

  @override
  String get saveFailedDialogClose => 'Бәрібір жабу';

  @override
  String get saveChangesTitle => 'Ozgeristerdi saqtau?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Zhabardyn aldynda \"$fileName\" faylyndaghy ozgeristerdi saqtaunu qalaisyz ba?';
  }

  @override
  String get saveButton => 'Saqtau';

  @override
  String get discardButton => 'Saqtamau';

  @override
  String get documentEdited => 'Ozgertildi';

  @override
  String get documentSaved => 'Saqtaldy';

  @override
  String get menuSettings => 'Parametrler...';

  @override
  String get menuWindow => 'Терезе';

  @override
  String get menuMinimize => 'Кішірейту';

  @override
  String get menuZoom => 'Масштаб';

  @override
  String get menuBringAllToFront => 'Барлығын алдыға әкелу';

  @override
  String get settingsTitle => 'Parametrler';

  @override
  String get settingsLanguage => 'Til';

  @override
  String get settingsLanguageSystem => 'Zhyie adepki';

  @override
  String get settingsUnits => 'Olshem birlkteri';

  @override
  String get settingsUnitsCentimeters => 'Santimetr';

  @override
  String get settingsUnitsInches => 'Diuym';

  @override
  String get settingsSearchLanguages => 'Тілдерді іздеу...';

  @override
  String get settingsGeneral => 'Жалпы';

  @override
  String get addImage => 'Сурет қосу';

  @override
  String get selectImages => 'Суреттерді таңдау';

  @override
  String get zoomFitWidth => 'Енге сәйкестендіру';

  @override
  String get zoomIn => 'Үлкейту';

  @override
  String get zoomOut => 'Кішірейту';

  @override
  String get selectZoomLevel => 'Масштаб деңгейін таңдау';

  @override
  String get goToPage => 'Бетке өту';

  @override
  String get go => 'Өту';

  @override
  String get savePdfAs => 'PDF ретінде сақтау';

  @override
  String get incorrectPassword => 'Құпия сөз қате';

  @override
  String get saveFailed => 'Сақтау сәтсіз';

  @override
  String savedTo(String path) {
    return 'Сақталды: $path';
  }

  @override
  String get noOriginalPdfStored => 'Түпнұсқа PDF сақталмаған';

  @override
  String get waitingForFolderPermission => 'Қалтаға кіру рұқсатын күтуде...';

  @override
  String get deleteButtonLabel => 'Жою';

  @override
  String get deleteButtonTooltip => 'Таңдалған нысанды жою';

  @override
  String get documentProtectedTitle => 'Бұл құжат қорғалған';

  @override
  String get documentProtectedBody => 'Оны ашу үшін құпия сөзді енгізіңіз.';

  @override
  String get passwordFieldLabel => 'Құпия сөз';

  @override
  String get openDocumentButton => 'Ашу';

  @override
  String get documentReadOnlyTitle => 'Бұл құжат өзгертуге рұқсат бермейді';

  @override
  String get documentReadOnlyBody =>
      'Оны оқуға және басып шығаруға болады, бірақ иесі өзгертуге рұқсат бермеген. Өңдеу үшін иенің құпия сөзін енгізіңіз.';

  @override
  String get enterOwnerPassword => 'Иенің құпия сөзін енгізу';

  @override
  String get ownerPasswordFieldLabel => 'Иенің құпия сөзі';

  @override
  String get menuPrint => 'Басып шығару…';

  @override
  String get menuPrintCurrentPage => 'Ағымдағы бетті басып шығару';

  @override
  String get printingIsTheOwnersTitle =>
      'Бұл құжатты тек иесі ғана басып шығара алады';

  @override
  String get printingNotAllowed => 'Бұл құжат басып шығаруға рұқсат бермейді.';

  @override
  String get printingFailed => 'Құжатты басып шығару мүмкін болмады.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Бұл құжаттың қорғауын тек иесі ғана өзгерте алады';

  @override
  String get continueButton => 'Жалғастыру';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Қорғалған құжат жадтан көрсетіледі, ал мұның көлемі — $size. Оны ашу шамамен сонша жад алады.';
  }

  @override
  String get shareProtectedNotice =>
      'Жіберілген көшірме құжаттың құпия сөзін сақтайды.';

  @override
  String get unsupportedProtection =>
      'Бұл құжаттың қорғауы қолдау таппайды. PDFSign құпия сөзбен қорғалған құжаттарды ашады, сертификатпен қорғалғандарды емес.';

  @override
  String get menuBringToFront => 'Ең алдыңғы қатарға';

  @override
  String get menuBringForward => 'Алға жылжыту';

  @override
  String get menuSendBackward => 'Артқа жылжыту';

  @override
  String get menuSendToBack => 'Ең артқы қатарға';

  @override
  String get zOrderGroupLabel => 'Реттеу';

  @override
  String get menuUndo => 'Болдырмау';

  @override
  String get menuRedo => 'Қайталау';

  @override
  String get dragToReorder => 'Ретін өзгерту үшін сүйреңіз';

  @override
  String get protectDocumentTitle => 'Құжатты қорғау';

  @override
  String get requirePasswordToOpen => 'Құжатты ашу үшін құпия сөз сұралсын';

  @override
  String get verifyFieldLabel => 'Растау';

  @override
  String get permissionsHeading => 'Рұқсаттар';

  @override
  String get permissionsNote =>
      'Иенің құпия сөзін енгізбестен төмендегі өзгерістерге рұқсат беру.';

  @override
  String get permissionPrinting => 'Басып шығару';

  @override
  String get permissionCopying => 'Мәтінді немесе графиканы көшіру';

  @override
  String get permissionPageAssembly => 'Беттерді кірістіру, жою және бұру';

  @override
  String get permissionAnnotations => 'Түсініктемелер мен қолтаңбаларды қосу';

  @override
  String get permissionChangingContent => 'Құжатты өзгерту';

  @override
  String get permissionFormFilling => 'Бар пішін өрістерін толтыру';

  @override
  String get changingContentIncludes =>
      'Құжатты өзгерту түсініктеме беруді және пішіндерді толтыруды қамтиды — олар сонымен бірге рұқсат етіледі.';

  @override
  String get ownerPasswordHeading => 'Иенің құпия сөзі';

  @override
  String get removeProtection => 'Қорғауды алып тастау';

  @override
  String get applyButton => 'Қолдану';

  @override
  String get passwordsDoNotMatch => 'Құпия сөздер сәйкес келмейді';

  @override
  String get passwordCannotBeEmpty => 'Құпия сөзді енгізіңіз';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Шектеулер үшін иенің құпия сөзі қажет. Онсыз оларды кез келген адам алып тастай алады.';

  @override
  String get signingNeedsChangingContent =>
      '«Құжатты өзгерту» болмаса, бұл файлға иенің құпия сөзінсіз мұнда қайта қол қою мүмкін болмайды.';

  @override
  String get menuProtectDocument => 'Құжатты қорғау…';

  @override
  String get protectButtonLabel => 'Қорғау';

  @override
  String get protectButtonTooltip =>
      'Осы құжаттың құпия сөздері мен рұқсаттарын белгілеңіз';
}
