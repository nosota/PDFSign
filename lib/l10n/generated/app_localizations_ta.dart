// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get openPdf => 'PDF thira';

  @override
  String get selectPdf => 'PDF thernthedu';

  @override
  String get recentFiles => 'Samipattiya koapugal';

  @override
  String get removeFromList => 'Pattiyal irunthu neekkavu';

  @override
  String get openedNow => 'Ippothuthan thirakkappattatu';

  @override
  String openedMinutesAgo(int count) {
    return '$count nimidam munpu thirakkappattatu';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count mani neram munpu thirakkappattatu';
  }

  @override
  String get openedYesterday => 'Netru thirakkappattatu';

  @override
  String openedDaysAgo(int count) {
    return '$count natkal munpu thirakkappattatu';
  }

  @override
  String get fileNotFound => 'Koapu kandupidikkavillai';

  @override
  String get fileAccessDenied => 'Anugal maruppu';

  @override
  String get clearRecentFiles => 'Samipattiya koapugalai azhikka';

  @override
  String get cancel => 'Raththu seiva';

  @override
  String get confirm => 'Uruthi seyya';

  @override
  String get error => 'Pizhiai';

  @override
  String get ok => 'Sari';

  @override
  String get menuFile => 'Koapu';

  @override
  String get menuOpen => 'Thira...';

  @override
  String get menuOpenRecent => 'Samipattiya thira';

  @override
  String get menuNoRecentFiles => 'Samipattiya koapugal illai';

  @override
  String get menuClearMenu => 'Menyuvai azhikka';

  @override
  String get menuSave => 'Semiykka';

  @override
  String get menuSaveAs => 'Veraraga semiykkavu...';

  @override
  String get menuSaveAll => 'அனைத்தையும் சேமிக்கவும்';

  @override
  String get menuShare => 'Pakirvu...';

  @override
  String get menuCloseWindow => 'Jannal muda';

  @override
  String get menuCloseAll => 'அனைத்தையும் மூடு';

  @override
  String get menuEdit => 'திருத்து';

  @override
  String get menuDelete => 'நீக்கு';

  @override
  String get menuView => 'காட்சி';

  @override
  String goToPagePrompt(int total) {
    return 'பக்க எண்ணை உள்ளிடவும் (1–$total):';
  }

  @override
  String get goToPageHint => 'பக்க எண்';

  @override
  String get goToPageInvalid => 'செல்லுபடியாகும் எண்ணை உள்ளிடவும்';

  @override
  String goToPageOutOfRange(int total) {
    return 'பக்கம் 1 முதல் $total வரை இருக்க வேண்டும்';
  }

  @override
  String get menuRotateLeft => 'இடப்புறம் சுழற்று';

  @override
  String get menuRotateRight => 'வலப்புறம் சுழற்று';

  @override
  String get menuCut => 'வெட்டு';

  @override
  String get menuCopy => 'நகலெடு';

  @override
  String get menuPaste => 'ஒட்டு';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'சேர்க்கப்படவில்லை: $count படங்கள் $limit அளவை மீறுகின்றன';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'சேர்க்கப்படவில்லை: $count படங்கள் $limit பிக்சல்களை மீறுகின்றன';
  }

  @override
  String imagesNotAdded(int count) {
    return 'சேர்க்கப்படவில்லை: $count படங்கள்';
  }

  @override
  String get clipboardUnavailable => 'இடைநிலைப் பலகை கிடைக்கவில்லை';

  @override
  String get pasteImageFailed => 'இந்தப் படத்தைச் சேர்க்க முடியவில்லை';

  @override
  String get menuQuit => 'PDFSign-இலிருந்து வெளியேறு';

  @override
  String get closeAllDialogTitle => 'மாற்றங்களை சேமிக்கவா?';

  @override
  String closeAllDialogMessage(int count) {
    return 'மூடுவதற்கு முன் $count ஆவணங்களில் மாற்றங்களை சேமிக்க விரும்புகிறீர்களா?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'மூடுவதற்கு முன் 1 ஆவணத்தில் மாற்றங்களை சேமிக்க விரும்புகிறீர்களா?';

  @override
  String get closeAllDialogSaveAll => 'அனைத்தையும் சேமி';

  @override
  String get closeAllDialogDontSave => 'சேமிக்க வேண்டாம்';

  @override
  String get closeAllDialogCancel => 'ரத்து செய்';

  @override
  String get saveFailedDialogTitle => 'சேமிப்பு தோல்வி';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count ஆவணங்களைச் சேமிக்க முடியவில்லை. எப்படியும் மூடவா?';
  }

  @override
  String get saveFailedDialogClose => 'எப்படியும் மூடு';

  @override
  String get saveChangesTitle => 'Marrrangalai semikkava?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Muduvathikku munpu \"$fileName\" koapil marrrangalai semikka virumpukirayrka?';
  }

  @override
  String get saveButton => 'Semiykka';

  @override
  String get discardButton => 'Vidu';

  @override
  String get documentEdited => 'Thirutappattatu';

  @override
  String get documentSaved => 'Semikkappattathu';

  @override
  String get menuSettings => 'Amaikpugal...';

  @override
  String get menuWindow => 'சாளரம்';

  @override
  String get menuMinimize => 'சிறியதாக்கு';

  @override
  String get menuZoom => 'பெரிதாக்கு';

  @override
  String get menuBringAllToFront => 'அனைத்தையும் முன்னே கொண்டுவா';

  @override
  String get settingsTitle => 'Amaikpugal';

  @override
  String get settingsLanguage => 'Mozhli';

  @override
  String get settingsLanguageSystem => 'Amaippu default';

  @override
  String get settingsUnits => 'Alagu';

  @override
  String get settingsUnitsCentimeters => 'Sentimeettar';

  @override
  String get settingsUnitsInches => 'Inchu';

  @override
  String get settingsSearchLanguages => 'மொழிகளைத் தேடு...';

  @override
  String get settingsGeneral => 'பொது';

  @override
  String get addImage => 'படம் சேர்';

  @override
  String get selectImages => 'படங்களைத் தேர்ந்தெடு';

  @override
  String get zoomFitWidth => 'அகலத்திற்கு பொருத்து';

  @override
  String get zoomIn => 'பெரிதாக்கு';

  @override
  String get zoomOut => 'சிறிதாக்கு';

  @override
  String get selectZoomLevel => 'பெரிதாக்க நிலையைத் தேர்ந்தெடு';

  @override
  String get goToPage => 'பக்கத்திற்குச் செல்';

  @override
  String get go => 'செல்';

  @override
  String get savePdfAs => 'PDF ஆக சேமி';

  @override
  String get incorrectPassword => 'தவறான கடவுச்சொல்';

  @override
  String get saveFailed => 'சேமிப்பு தோல்வி';

  @override
  String savedTo(String path) {
    return 'சேமிக்கப்பட்டது: $path';
  }

  @override
  String get noOriginalPdfStored => 'அசல் PDF சேமிக்கப்படவில்லை';

  @override
  String get waitingForFolderPermission =>
      'கோப்புறை அணுகல் அனுமதிக்காக காத்திருக்கிறது...';

  @override
  String get deleteButtonLabel => 'நீக்கு';

  @override
  String get deleteButtonTooltip => 'தேர்ந்தெடுக்கப்பட்ட பொருளை நீக்கு';

  @override
  String get documentProtectedTitle => 'இந்த ஆவணம் பாதுகாக்கப்பட்டுள்ளது';

  @override
  String get documentProtectedBody => 'இதைத் திறக்க கடவுச்சொல்லை உள்ளிடவும்.';

  @override
  String get passwordFieldLabel => 'கடவுச்சொல்';

  @override
  String get openDocumentButton => 'திற';

  @override
  String get documentReadOnlyTitle => 'இந்த ஆவணம் மாற்றங்களை அனுமதிக்கவில்லை';

  @override
  String get documentReadOnlyBody =>
      'இதைப் படிக்கவும் அச்சிடவும் முடியும், ஆனால் உரிமையாளர் மாற்றங்களை அனுமதிக்கவில்லை. திருத்த உரிமையாளரின் கடவுச்சொல்லை உள்ளிடவும்.';

  @override
  String get enterOwnerPassword => 'உரிமையாளரின் கடவுச்சொல்லை உள்ளிடவும்';

  @override
  String get ownerPasswordFieldLabel => 'உரிமையாளரின் கடவுச்சொல்';

  @override
  String get menuPrint => 'அச்சிடு…';

  @override
  String get menuPrintCurrentPage => 'தற்போதைய பக்கத்தை அச்சிடு';

  @override
  String get printingIsTheOwnersTitle =>
      'இந்த ஆவணத்தை உரிமையாளர் மட்டுமே அச்சிட முடியும்';

  @override
  String get printingNotAllowed => 'இந்த ஆவணம் அச்சிடுவதை அனுமதிக்கவில்லை.';

  @override
  String get printingFailed => 'ஆவணத்தை அச்சிட முடியவில்லை.';

  @override
  String get protectionIsTheOwnersTitle =>
      'இந்த ஆவணத்தின் பாதுகாப்பை உரிமையாளர் மட்டுமே மாற்ற முடியும்';

  @override
  String get continueButton => 'தொடர்க';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'பாதுகாக்கப்பட்ட ஆவணம் நினைவகத்திலிருந்து காட்டப்படுகிறது; இதன் அளவு $size. இதைத் திறக்க ஏறக்குறைய அதே அளவு நினைவகம் தேவைப்படும்.';
  }

  @override
  String get shareProtectedNotice =>
      'பகிரப்பட்ட நகல் ஆவணத்தின் கடவுச்சொல்லைத் தக்கவைக்கிறது.';

  @override
  String get unsupportedProtection =>
      'இந்த ஆவணத்தின் பாதுகாப்பு ஆதரிக்கப்படவில்லை. PDFSign கடவுச்சொல்லால் பாதுகாக்கப்பட்ட ஆவணங்களைத் திறக்கும், சான்றிதழால் பாதுகாக்கப்பட்டவற்றை அல்ல.';

  @override
  String get menuBringToFront => 'முன்னுக்குக் கொண்டுவா';

  @override
  String get menuBringForward => 'முன்னால் நகர்த்து';

  @override
  String get menuSendBackward => 'பின்னால் நகர்த்து';

  @override
  String get menuSendToBack => 'பின்னுக்கு அனுப்பு';

  @override
  String get zOrderGroupLabel => 'வரிசைப்படுத்து';

  @override
  String get menuUndo => 'செயல்தவிர்';

  @override
  String get menuRedo => 'மீண்டும் செய்';

  @override
  String get dragToReorder => 'வரிசையை மாற்ற இழுக்கவும்';

  @override
  String get protectDocumentTitle => 'ஆவணத்தைப் பாதுகாக்கவும்';

  @override
  String get requirePasswordToOpen =>
      'ஆவணத்தைத் திறக்க கடவுச்சொல் கேட்கப்படட்டும்';

  @override
  String get verifyFieldLabel => 'உறுதிப்படுத்தல்';

  @override
  String get permissionsHeading => 'அனுமதிகள்';

  @override
  String get permissionsNote =>
      'உரிமையாளரின் கடவுச்சொல் இல்லாமல் பின்வரும் மாற்றங்களை அனுமதிக்கவும்.';

  @override
  String get permissionPrinting => 'அச்சிடுதல்';

  @override
  String get permissionCopying => 'உரை அல்லது வரைபடங்களை நகலெடுத்தல்';

  @override
  String get permissionPageAssembly =>
      'பக்கங்களைச் சேர்த்தல், நீக்குதல், சுழற்றுதல்';

  @override
  String get permissionAnnotations =>
      'குறிப்புகள் அல்லது கையொப்பங்களைச் சேர்த்தல்';

  @override
  String get permissionChangingContent => 'ஆவணத்தை மாற்றுதல்';

  @override
  String get permissionFormFilling =>
      'ஏற்கெனவே உள்ள படிவப் புலங்களை நிரப்புதல்';

  @override
  String get changingContentIncludes =>
      'ஆவணத்தை மாற்றுதலில் குறிப்பிடுதலும் படிவங்களை நிரப்புதலும் அடங்கும் — அவையும் சேர்ந்தே அனுமதிக்கப்படும்.';

  @override
  String get ownerPasswordHeading => 'உரிமையாளரின் கடவுச்சொல்';

  @override
  String get removeProtection => 'பாதுகாப்பை நீக்கு';

  @override
  String get applyButton => 'பயன்படுத்து';

  @override
  String get passwordsDoNotMatch => 'கடவுச்சொற்கள் பொருந்தவில்லை';

  @override
  String get passwordCannotBeEmpty => 'கடவுச்சொல்லை உள்ளிடவும்';

  @override
  String get restrictionsNeedOwnerPassword =>
      'கட்டுப்பாடுகளுக்கு உரிமையாளரின் கடவுச்சொல் தேவை. அது இல்லாவிட்டால் யார் வேண்டுமானாலும் அவற்றை நீக்கலாம்.';

  @override
  String get signingNeedsChangingContent =>
      '“ஆவணத்தை மாற்றுதல்” இல்லாமல், உரிமையாளரின் கடவுச்சொல் இன்றி இந்தக் கோப்பில் மீண்டும் இங்கே கையொப்பமிட முடியாது.';

  @override
  String get menuProtectDocument => 'ஆவணத்தைப் பாதுகாக்கவும்…';

  @override
  String get protectButtonLabel => 'பாதுகாப்பு';

  @override
  String get protectButtonTooltip =>
      'இந்த ஆவணத்தின் கடவுச்சொற்களையும் அனுமதிகளையும் அமைக்கவும்';
}
