// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get openPdf => 'PDF phwint';

  @override
  String get selectPdf => 'PDF rwe';

  @override
  String get recentFiles => 'Makhawkamhar file myar';

  @override
  String get removeFromList => 'Saryin hma hpyout';

  @override
  String get openedNow => 'Achu phwint lite';

  @override
  String openedMinutesAgo(int count) {
    return 'Minit $count u gar phwint';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Nari $count u gar phwint';
  }

  @override
  String get openedYesterday => 'Mahnekaun phwint';

  @override
  String openedDaysAgo(int count) {
    return 'Rout $count u gar phwint';
  }

  @override
  String get fileNotFound => 'File mar shi';

  @override
  String get fileAccessDenied => 'Win khwint mar rhi';

  @override
  String get clearRecentFiles => 'Makhawkamhar file myar ko shot';

  @override
  String get cancel => 'Pyet';

  @override
  String get confirm => 'Atint pyuu';

  @override
  String get error => 'Arhar';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Phwint...';

  @override
  String get menuOpenRecent => 'Makhawkamhar phwint';

  @override
  String get menuNoRecentFiles => 'Makhawkamhar file myar mar rhi';

  @override
  String get menuClearMenu => 'Menu ko shot';

  @override
  String get menuSave => 'Thein';

  @override
  String get menuSaveAs => 'Aloat thein...';

  @override
  String get menuSaveAll => 'အားလုံးသိမ်းဆည်းပါ';

  @override
  String get menuShare => 'Mhway vway...';

  @override
  String get menuCloseWindow => 'Window peit';

  @override
  String get menuCloseAll => 'အားလုံးပိတ်ရန်';

  @override
  String get menuEdit => 'တည်းဖြတ်';

  @override
  String get menuDelete => 'ဖျက်';

  @override
  String get menuView => 'View';

  @override
  String goToPagePrompt(int total) {
    return 'Enter page number (1-$total):';
  }

  @override
  String get goToPageHint => 'Page number';

  @override
  String get goToPageInvalid => 'Please enter a valid number';

  @override
  String goToPageOutOfRange(int total) {
    return 'Page must be between 1 and $total';
  }

  @override
  String get menuRotateLeft => 'Rotate Left';

  @override
  String get menuRotateRight => 'Rotate Right';

  @override
  String get menuCut => 'Cut';

  @override
  String get menuCopy => 'Copy';

  @override
  String get menuPaste => 'Paste';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Not added: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'The clipboard is unavailable';

  @override
  String get pasteImageFailed => 'That image could not be added';

  @override
  String get menuQuit => 'PDFSign မှထွက်ရန်';

  @override
  String get closeAllDialogTitle => 'ပြောင်းလဲမှုများသိမ်းမလား?';

  @override
  String closeAllDialogMessage(int count) {
    return 'မပိတ်မီ စာရွက်စာတမ်း $count ခုတွင် ပြောင်းလဲမှုများကို သိမ်းဆည်းလိုပါသလား?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'မပိတ်မီ စာရွက်စာတမ်း 1 ခုတွင် ပြောင်းလဲမှုများကို သိမ်းဆည်းလိုပါသလား?';

  @override
  String get closeAllDialogSaveAll => 'အားလုံးသိမ်းရန်';

  @override
  String get closeAllDialogDontSave => 'မသိမ်းပါ';

  @override
  String get closeAllDialogCancel => 'ပယ်ဖျက်ရန်';

  @override
  String get saveFailedDialogTitle => 'သိမ်းဆည်းခြင်း မအောင်မြင်ပါ';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count စာရွက်စာတမ်း သိမ်းဆည်းခြင်း မအောင်မြင်ပါ။ ဘာပဲဖြစ်ဖြစ် ပိတ်မလား?';
  }

  @override
  String get saveFailedDialogClose => 'ဘာပဲဖြစ်ဖြစ် ပိတ်ပါ';

  @override
  String get saveChangesTitle => 'Pyaunglevmhuu thein malar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Mapeitmhin \"$fileName\" hta pyaunglevmhuu thein larmalar?';
  }

  @override
  String get saveButton => 'Thein';

  @override
  String get discardButton => 'Ma thein';

  @override
  String get documentEdited => 'Pyifjyifpyi';

  @override
  String get documentSaved => 'Thein pyi';

  @override
  String get menuSettings => 'Setting myar...';

  @override
  String get menuWindow => 'ဝင်းဒိုး';

  @override
  String get menuMinimize => 'ချုံ့ရန်';

  @override
  String get menuZoom => 'ချဲ့ရန်';

  @override
  String get menuBringAllToFront => 'အားလုံးကိုရှေ့သို့ယူလာရန်';

  @override
  String get settingsTitle => 'Setting myar';

  @override
  String get settingsLanguage => 'Bhashar zagar';

  @override
  String get settingsLanguageSystem => 'System mhuu run';

  @override
  String get settingsUnits => 'Tinetunit myar';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'ဘာသာစကား ရှာရန်...';

  @override
  String get settingsGeneral => 'အထွေထွေ';

  @override
  String get addImage => 'ပုံထည့်ရန်';

  @override
  String get selectImages => 'ပုံများရွေးရန်';

  @override
  String get zoomFitWidth => 'အကျယ်နဲ့ကိုက်ညီအောင်';

  @override
  String get zoomIn => 'ချဲ့ကြည့်ရန်';

  @override
  String get zoomOut => 'ချုံ့ကြည့်ရန်';

  @override
  String get selectZoomLevel => 'ချဲ့/ချုံ့အဆင့်ရွေးရန်';

  @override
  String get goToPage => 'စာမျက်နှာသို့သွားရန်';

  @override
  String get go => 'သွားရန်';

  @override
  String get savePdfAs => 'PDF အဖြစ်သိမ်းရန်';

  @override
  String get incorrectPassword => 'စကားဝှက်မှားနေသည်';

  @override
  String get saveFailed => 'သိမ်းဆည်းမှုမအောင်မြင်ပါ';

  @override
  String savedTo(String path) {
    return 'သိမ်းဆည်းပြီး: $path';
  }

  @override
  String get noOriginalPdfStored => 'မူရင်း PDF မသိမ်းရသေးပါ';

  @override
  String get waitingForFolderPermission =>
      'ဖိုင်တွဲဝင်ရောက်ခွင့်အတွက်စောင့်ဆိုင်းနေသည်...';

  @override
  String get deleteButtonLabel => 'ဖျက်ရန်';

  @override
  String get deleteButtonTooltip => 'ရွေးချယ်ထားသော အရာဝတ္ထုကို ဖျက်ရန်';

  @override
  String get documentProtectedTitle => 'This document is protected';

  @override
  String get documentProtectedBody => 'Enter its password to open it.';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get openDocumentButton => 'Open';

  @override
  String get documentReadOnlyTitle => 'This document does not allow changes';

  @override
  String get documentReadOnlyBody =>
      'It can be read and printed, but its owner has not allowed it to be changed. Enter the owner password to edit it.';

  @override
  String get enterOwnerPassword => 'Enter owner password';

  @override
  String get ownerPasswordFieldLabel => 'Owner password';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'A protected document has to be held in memory to be shown, and this one is $size. Opening it will use about that much.';
  }

  @override
  String get shareProtectedNotice =>
      'The shared copy keeps the document\'s password.';

  @override
  String get unsupportedProtection =>
      'This document\'s protection is not supported. PDFSign opens password-protected documents, not those protected by a certificate.';

  @override
  String get menuBringToFront => 'Bring to Front';

  @override
  String get menuBringForward => 'Bring Forward';

  @override
  String get menuSendBackward => 'Send Backward';

  @override
  String get menuSendToBack => 'Send to Back';

  @override
  String get zOrderGroupLabel => 'Arrange';

  @override
  String get menuUndo => 'Undo';

  @override
  String get menuRedo => 'Redo';

  @override
  String get dragToReorder => 'Drag to reorder';

  @override
  String get protectDocumentTitle => 'Protect Document';

  @override
  String get requirePasswordToOpen => 'Require Password To Open Document';

  @override
  String get verifyFieldLabel => 'Verify';

  @override
  String get permissionsHeading => 'Permissions';

  @override
  String get permissionsNote =>
      'Allow the following changes to be made without entering the owner password.';

  @override
  String get permissionPrinting => 'Printing';

  @override
  String get permissionCopying => 'Copying Text or Graphics';

  @override
  String get permissionPageAssembly => 'Inserting, Deleting, or Rotating Pages';

  @override
  String get permissionAnnotations => 'Adding Annotations or Signatures';

  @override
  String get permissionChangingContent => 'Changing the Document';

  @override
  String get permissionFormFilling => 'Filling Existing Form Fields';

  @override
  String get changingContentIncludes =>
      'Changing the document includes annotating and filling in forms, so those are granted with it.';

  @override
  String get ownerPasswordHeading => 'Owner Password';

  @override
  String get removeProtection => 'Remove Protection';

  @override
  String get applyButton => 'Apply';

  @override
  String get passwordsDoNotMatch => 'The passwords do not match';

  @override
  String get passwordCannotBeEmpty => 'Enter a password';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Restrictions need an owner password. Without one, anyone can lift them.';

  @override
  String get signingNeedsChangingContent =>
      'Without “Changing the Document”, this file cannot be signed here again unless the owner password is given.';

  @override
  String get menuProtectDocument => 'Protect Document…';

  @override
  String get protectButtonLabel => 'Protect';

  @override
  String get protectButtonTooltip =>
      'Set this document\'s passwords and permissions';
}
