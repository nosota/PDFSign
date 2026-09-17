// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Armenian (`hy`).
class AppLocalizationsHy extends AppLocalizations {
  AppLocalizationsHy([String locale = 'hy']) : super(locale);

  @override
  String get openPdf => 'Batsvel PDF';

  @override
  String get selectPdf => 'Yntrel PDF';

  @override
  String get recentFiles => 'Verdjin faylery';

  @override
  String get removeFromList => 'Heratsel tsankits';

  @override
  String get openedNow => 'Nor batsvetso';

  @override
  String openedMinutesAgo(int count) {
    return 'Batsvetso $count rope araj';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Batsvetso $count zham araj';
  }

  @override
  String get openedYesterday => 'Batsvetso yerek';

  @override
  String openedDaysAgo(int count) {
    return 'Batsvetso $count or araj';
  }

  @override
  String get fileNotFound => 'Fayli chi gtanyel';

  @override
  String get fileAccessDenied => 'Mtky merjvatso e';

  @override
  String get clearRecentFiles => 'Maqrel verdjin faylery';

  @override
  String get cancel => 'Chygarkvel';

  @override
  String get confirm => 'Hastatel';

  @override
  String get error => 'Skhalk';

  @override
  String get ok => 'Lav';

  @override
  String get menuFile => 'Fayl';

  @override
  String get menuOpen => 'Batsvel...';

  @override
  String get menuOpenRecent => 'Batsvel verdjiny';

  @override
  String get menuNoRecentFiles => 'Verdjin faylyr chkan';

  @override
  String get menuClearMenu => 'Maqrel tsanky';

  @override
  String get menuSave => 'Pakhpanel';

  @override
  String get menuSaveAs => 'Pakhpanel orpes...';

  @override
  String get menuSaveAll => 'Պահել բոլորը';

  @override
  String get menuShare => 'Kisel...';

  @override
  String get menuCloseWindow => 'Pakers patuhan';

  @override
  String get menuCloseAll => 'Pakers bolory';

  @override
  String get menuEdit => 'Խմբագրել';

  @override
  String get menuDelete => 'Ջնջել';

  @override
  String get menuView => 'Տեսք';

  @override
  String goToPagePrompt(int total) {
    return 'Մուտքագրեք էջի համարը (1–$total).';
  }

  @override
  String get goToPageHint => 'Էջի համարը';

  @override
  String get goToPageInvalid => 'Մուտքագրեք վավեր թիվ';

  @override
  String goToPageOutOfRange(int total) {
    return 'Էջը պետք է լինի 1-ի և $total-ի միջև';
  }

  @override
  String get menuRotateLeft => 'Պտտել ձախ';

  @override
  String get menuRotateRight => 'Պտտել աջ';

  @override
  String get menuCut => 'Կտրել';

  @override
  String get menuCopy => 'Պատճենել';

  @override
  String get menuPaste => 'Տեղադրել';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Չավելացված պատկերներ՝ $count — գերազանցում են $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Չավելացված պատկերներ՝ $count — գերազանցում են $limit փիքսել';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Չավելացված պատկերներ՝ $count';
  }

  @override
  String get clipboardUnavailable => 'Փոխանակման հիշողությունը հասանելի չէ';

  @override
  String get pasteImageFailed => 'Այս պատկերը չհաջողվեց ավելացնել';

  @override
  String get menuQuit => 'Yelk PDFSign-its';

  @override
  String get closeAllDialogTitle => 'Pakhpanel pokhutyyunnery?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Uzum eq pakhpanel pokhutyyunnery $count pastatghterum pokheluts araj?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Uzum eq pakhpanel pokhutyyunnery 1 pastatghterum pokheluts araj?';

  @override
  String get closeAllDialogSaveAll => 'Pakhpanel bolory';

  @override
  String get closeAllDialogDontSave => 'Chpakhpanel';

  @override
  String get closeAllDialogCancel => 'Chygarkvel';

  @override
  String get saveFailedDialogTitle => 'Պահումը ձախողվեց';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Failed to save $count document(s). Close anyway?';
  }

  @override
  String get saveFailedDialogClose => 'Այնուամենայնիվ փակել';

  @override
  String get saveChangesTitle => 'Pakhpanel pokhutyyunnery?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Uzum eq pakhpanel \"$fileName\" faylum katrvatso pokhutyyunnery pokhelu araj?';
  }

  @override
  String get saveButton => 'Pakhpanel';

  @override
  String get discardButton => 'Chpakhpanel';

  @override
  String get documentEdited => 'Khmbagrets';

  @override
  String get documentSaved => 'Pakhpanvatso e';

  @override
  String get menuSettings => 'Kargavorumner...';

  @override
  String get menuWindow => 'Patuhan';

  @override
  String get menuMinimize => 'Pokratsnel';

  @override
  String get menuZoom => 'Masshtab';

  @override
  String get menuBringAllToFront => 'Bolory araj berel';

  @override
  String get settingsTitle => 'Kargavorumner';

  @override
  String get settingsLanguage => 'Lezu';

  @override
  String get settingsLanguageSystem => 'Hamakargayin lrutso';

  @override
  String get settingsUnits => 'Chapaqi miavorner';

  @override
  String get settingsUnitsCentimeters => 'Santimetrer';

  @override
  String get settingsUnitsInches => 'Duymer';

  @override
  String get settingsSearchLanguages => 'Lezuneri porokhum...';

  @override
  String get settingsGeneral => 'Yndhanur';

  @override
  String get addImage => 'Avelatsnel patker';

  @override
  String get selectImages => 'Yntrel patkerner';

  @override
  String get zoomFitWidth => 'Hamarjetsnel laynutyamb';

  @override
  String get zoomIn => 'Metatsnel';

  @override
  String get zoomOut => 'Pokratsnel';

  @override
  String get selectZoomLevel => 'Yntrel masshtabi makardaky';

  @override
  String get goToPage => 'Anjnel ej';

  @override
  String get go => 'Anjnel';

  @override
  String get savePdfAs => 'Pakhpanel PDF orpes';

  @override
  String get incorrectPassword => 'Sphal gaghtnabar';

  @override
  String get saveFailed => 'Pakhpanman skhalkutyun';

  @override
  String savedTo(String path) {
    return 'Pakhpanvatso e: $path';
  }

  @override
  String get noOriginalPdfStored => 'Bnatipi PDF-y pakhpanvatso che';

  @override
  String get waitingForFolderPermission =>
      'Սպասում է թղթապանակի հասանելիության թույլտվությանը…';

  @override
  String get deleteButtonLabel => 'Ջնջել';

  @override
  String get deleteButtonTooltip => 'Ջնջել ընտրված օբյեկտը';

  @override
  String get documentProtectedTitle => 'Այս փաստաթուղթը պաշտպանված է';

  @override
  String get documentProtectedBody =>
      'Մուտքագրեք գաղտնաբառը՝ այն բացելու համար։';

  @override
  String get passwordFieldLabel => 'Գաղտնաբառ';

  @override
  String get openDocumentButton => 'Բացել';

  @override
  String get documentReadOnlyTitle =>
      'Այս փաստաթուղթը փոփոխություններ չի թույլատրում';

  @override
  String get documentReadOnlyBody =>
      'Այն կարելի է կարդալ և տպել, սակայն սեփականատերը փոփոխություններ չի թույլատրել։ Խմբագրելու համար մուտքագրեք սեփականատիրոջ գաղտնաբառը։';

  @override
  String get enterOwnerPassword => 'Մուտքագրել սեփականատիրոջ գաղտնաբառը';

  @override
  String get ownerPasswordFieldLabel => 'Սեփականատիրոջ գաղտնաբառը';

  @override
  String get menuPrint => 'Տպել…';

  @override
  String get menuPrintCurrentPage => 'Տպել ընթացիկ էջը';

  @override
  String get printingIsTheOwnersTitle =>
      'Այս փաստաթուղթը կարող է տպել միայն սեփականատերը';

  @override
  String get printingNotAllowed => 'Այս փաստաթուղթը տպելը չի թույլատրում։';

  @override
  String get printingFailed => 'Փաստաթուղթը չհաջողվեց տպել։';

  @override
  String get protectionIsTheOwnersTitle =>
      'Այս փաստաթղթի պաշտպանությունը կարող է փոխել միայն սեփականատերը';

  @override
  String get continueButton => 'Շարունակել';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Պաշտպանված փաստաթուղթը ցուցադրվում է հիշողությունից, իսկ սա զբաղեցնում է $size։ Բացելը կսպառի մոտավորապես նույնքան։';
  }

  @override
  String get shareProtectedNotice =>
      'Ուղարկված պատճենը պահպանում է փաստաթղթի գաղտնաբառը։';

  @override
  String get unsupportedProtection =>
      'Այս փաստաթղթի պաշտպանությունը չի աջակցվում։ PDFSign-ը բացում է գաղտնաբառով պաշտպանված փաստաթղթեր, ոչ թե վկայագրով պաշտպանվածները։';

  @override
  String get menuBringToFront => 'Տեղափոխել առաջին պլան';

  @override
  String get menuBringForward => 'Տեղափոխել առաջ';

  @override
  String get menuSendBackward => 'Տեղափոխել հետ';

  @override
  String get menuSendToBack => 'Տեղափոխել վերջին պլան';

  @override
  String get zOrderGroupLabel => 'Դասավորել';

  @override
  String get menuUndo => 'Հետարկել';

  @override
  String get menuRedo => 'Կրկնել';

  @override
  String get dragToReorder => 'Քաշեք՝ հերթականությունը փոխելու համար';

  @override
  String get protectDocumentTitle => 'Փաստաթղթի պաշտպանություն';

  @override
  String get requirePasswordToOpen =>
      'Պահանջել գաղտնաբառ փաստաթուղթը բացելու համար';

  @override
  String get verifyFieldLabel => 'Հաստատում';

  @override
  String get permissionsHeading => 'Թույլտվություններ';

  @override
  String get permissionsNote =>
      'Թույլատրել հետևյալ փոփոխությունները՝ առանց սեփականատիրոջ գաղտնաբառի։';

  @override
  String get permissionPrinting => 'Տպում';

  @override
  String get permissionCopying => 'Տեքստի կամ գրաֆիկայի պատճենում';

  @override
  String get permissionPageAssembly => 'Էջերի ավելացում, ջնջում և պտտում';

  @override
  String get permissionAnnotations =>
      'Ծանոթագրությունների և ստորագրությունների ավելացում';

  @override
  String get permissionChangingContent => 'Փաստաթղթի փոփոխում';

  @override
  String get permissionFormFilling => 'Առկա ձևաթղթերի դաշտերի լրացում';

  @override
  String get changingContentIncludes =>
      'Փաստաթղթի փոփոխումը ներառում է ծանոթագրելը և ձևաթղթերի լրացումը — դրանք թույլատրվում են դրա հետ միասին։';

  @override
  String get ownerPasswordHeading => 'Սեփականատիրոջ գաղտնաբառը';

  @override
  String get removeProtection => 'Հեռացնել պաշտպանությունը';

  @override
  String get applyButton => 'Կիրառել';

  @override
  String get passwordsDoNotMatch => 'Գաղտնաբառերը չեն համընկնում';

  @override
  String get passwordCannotBeEmpty => 'Մուտքագրեք գաղտնաբառ';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Սահմանափակումները պահանջում են սեփականատիրոջ գաղտնաբառ։ Առանց դրա դրանք կարող է հեռացնել ցանկացած մեկը։';

  @override
  String get signingNeedsChangingContent =>
      'Առանց «Փաստաթղթի փոփոխում» կետի այս ֆայլն այստեղ այլևս հնարավոր չի լինի ստորագրել առանց սեփականատիրոջ գաղտնաբառի։';

  @override
  String get menuProtectDocument => 'Պաշտպանել փաստաթուղթը…';

  @override
  String get protectButtonLabel => 'Պաշտպանել';

  @override
  String get protectButtonTooltip =>
      'Սահմանեք այս փաստաթղթի գաղտնաբառերն ու թույլտվությունները';
}
