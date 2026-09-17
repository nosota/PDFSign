// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get openPdf => 'Anoigma PDF';

  @override
  String get selectPdf => 'Epilogi PDF';

  @override
  String get recentFiles => 'Prosfata archeia';

  @override
  String get removeFromList => 'Afairesi apo ti lista';

  @override
  String get openedNow => 'Molis anoixe';

  @override
  String openedMinutesAgo(int count) {
    return 'Anoixe prin apo $count lepta';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Anoixe prin apo $count ores';
  }

  @override
  String get openedYesterday => 'Anoixe chthes';

  @override
  String openedDaysAgo(int count) {
    return 'Anoixe prin apo $count imeres';
  }

  @override
  String get fileNotFound => 'To archeio den vrethike';

  @override
  String get fileAccessDenied => 'Den epitrepetai i prosvasi';

  @override
  String get clearRecentFiles => 'Ekkatharisi prosfaton archeion';

  @override
  String get cancel => 'Akyrosi';

  @override
  String get confirm => 'Epivevaiosi';

  @override
  String get error => 'Sfalma';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Archeio';

  @override
  String get menuOpen => 'Anoigma...';

  @override
  String get menuOpenRecent => 'Anoigma prosfaton';

  @override
  String get menuNoRecentFiles => 'Den yparxoun prosfata archeia';

  @override
  String get menuClearMenu => 'Ekkatharisi menou';

  @override
  String get menuSave => 'Apothikefsi';

  @override
  String get menuSaveAs => 'Apothikefsi os...';

  @override
  String get menuSaveAll => 'Αποθήκευση όλων';

  @override
  String get menuShare => 'Koinopoiisi...';

  @override
  String get menuCloseWindow => 'Kleisimo parathyrou';

  @override
  String get menuCloseAll => 'Κλείσιμο όλων';

  @override
  String get menuEdit => 'Επεξεργασία';

  @override
  String get menuDelete => 'Διαγραφή';

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
  String get menuQuit => 'Τερματισμός PDFSign';

  @override
  String get closeAllDialogTitle => 'Αποθήκευση αλλαγών;';

  @override
  String closeAllDialogMessage(int count) {
    return 'Θέλετε να αποθηκεύσετε τις αλλαγές σε $count έγγραφα πριν το κλείσιμο;';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Θέλετε να αποθηκεύσετε τις αλλαγές σε 1 έγγραφο πριν το κλείσιμο;';

  @override
  String get closeAllDialogSaveAll => 'Αποθήκευση όλων';

  @override
  String get closeAllDialogDontSave => 'Να μην αποθηκευτεί';

  @override
  String get closeAllDialogCancel => 'Ακύρωση';

  @override
  String get saveFailedDialogTitle => 'Αποτυχία αποθήκευσης';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Αποτυχία αποθήκευσης $count εγγράφου(ων). Κλείσιμο ούτως ή άλλως;';
  }

  @override
  String get saveFailedDialogClose => 'Κλείσιμο ούτως ή άλλως';

  @override
  String get saveChangesTitle => 'Apothikefsi allagon?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Thelete na apothikefthoun oi allages sto \"$fileName\" prin to kleisimo?';
  }

  @override
  String get saveButton => 'Apothikefsi';

  @override
  String get discardButton => 'Aporripsi';

  @override
  String get documentEdited => 'Epexergasmeno';

  @override
  String get documentSaved => 'Apothikeftike';

  @override
  String get menuSettings => 'Rythmiseis...';

  @override
  String get menuWindow => 'Παράθυρο';

  @override
  String get menuMinimize => 'Ελαχιστοποίηση';

  @override
  String get menuZoom => 'Ζουμ';

  @override
  String get menuBringAllToFront => 'Όλα στο προσκήνιο';

  @override
  String get settingsTitle => 'Rythmiseis';

  @override
  String get settingsLanguage => 'Glossa';

  @override
  String get settingsLanguageSystem => 'Proepilogi systimatos';

  @override
  String get settingsUnits => 'Monades';

  @override
  String get settingsUnitsCentimeters => 'Ekatosta';

  @override
  String get settingsUnitsInches => 'Intses';

  @override
  String get settingsSearchLanguages => 'Αναζήτηση γλωσσών...';

  @override
  String get settingsGeneral => 'Γενικά';

  @override
  String get addImage => 'Προσθήκη εικόνας';

  @override
  String get selectImages => 'Επιλογή εικόνων';

  @override
  String get zoomFitWidth => 'Προσαρμογή πλάτους';

  @override
  String get zoomIn => 'Μεγέθυνση';

  @override
  String get zoomOut => 'Σμίκρυνση';

  @override
  String get selectZoomLevel => 'Επιλογή επιπέδου ζουμ';

  @override
  String get goToPage => 'Μετάβαση σε σελίδα';

  @override
  String get go => 'Μετάβαση';

  @override
  String get savePdfAs => 'Αποθήκευση PDF ως';

  @override
  String get incorrectPassword => 'Λάθος κωδικός';

  @override
  String get saveFailed => 'Αποτυχία αποθήκευσης';

  @override
  String savedTo(String path) {
    return 'Αποθηκεύτηκε σε: $path';
  }

  @override
  String get noOriginalPdfStored => 'Δεν αποθηκεύτηκε αρχικό PDF';

  @override
  String get waitingForFolderPermission =>
      'Αναμονή για άδεια πρόσβασης φακέλου...';

  @override
  String get deleteButtonLabel => 'Διαγραφή';

  @override
  String get deleteButtonTooltip => 'Διαγραφή επιλεγμένου αντικειμένου';

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
}
