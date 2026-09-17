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
  String get menuView => 'Προβολή';

  @override
  String goToPagePrompt(int total) {
    return 'Εισαγάγετε αριθμό σελίδας (1–$total):';
  }

  @override
  String get goToPageHint => 'Αριθμός σελίδας';

  @override
  String get goToPageInvalid => 'Εισαγάγετε έγκυρο αριθμό';

  @override
  String goToPageOutOfRange(int total) {
    return 'Η σελίδα πρέπει να είναι μεταξύ 1 και $total';
  }

  @override
  String get menuRotateLeft => 'Περιστροφή αριστερά';

  @override
  String get menuRotateRight => 'Περιστροφή δεξιά';

  @override
  String get menuCut => 'Αποκοπή';

  @override
  String get menuCopy => 'Αντιγραφή';

  @override
  String get menuPaste => 'Επικόλληση';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Δεν προστέθηκαν εικόνες: $count — υπερβαίνουν τα $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Δεν προστέθηκαν εικόνες: $count — υπερβαίνουν τα $limit pixel';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Δεν προστέθηκαν εικόνες: $count';
  }

  @override
  String get clipboardUnavailable => 'Το πρόχειρο δεν είναι διαθέσιμο';

  @override
  String get pasteImageFailed => 'Δεν ήταν δυνατή η προσθήκη αυτής της εικόνας';

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
  String get documentProtectedTitle => 'Αυτό το έγγραφο προστατεύεται';

  @override
  String get documentProtectedBody =>
      'Εισαγάγετε τον κωδικό πρόσβασης για να το ανοίξετε.';

  @override
  String get passwordFieldLabel => 'Κωδικός πρόσβασης';

  @override
  String get openDocumentButton => 'Άνοιγμα';

  @override
  String get documentReadOnlyTitle => 'Αυτό το έγγραφο δεν επιτρέπει αλλαγές';

  @override
  String get documentReadOnlyBody =>
      'Μπορεί να διαβαστεί και να εκτυπωθεί, αλλά ο κάτοχός του δεν επέτρεψε αλλαγές. Εισαγάγετε τον κωδικό του κατόχου για να το επεξεργαστείτε.';

  @override
  String get enterOwnerPassword => 'Εισαγωγή κωδικού κατόχου';

  @override
  String get ownerPasswordFieldLabel => 'Κωδικός κατόχου';

  @override
  String get menuPrint => 'Εκτύπωση…';

  @override
  String get menuPrintCurrentPage => 'Εκτύπωση τρέχουσας σελίδας';

  @override
  String get printingIsTheOwnersTitle =>
      'Μόνο ο κάτοχος μπορεί να εκτυπώσει αυτό το έγγραφο';

  @override
  String get printingNotAllowed =>
      'Αυτό το έγγραφο δεν επιτρέπει την εκτύπωση.';

  @override
  String get printingFailed => 'Δεν ήταν δυνατή η εκτύπωση του εγγράφου.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Μόνο ο κάτοχος μπορεί να αλλάξει την προστασία αυτού του εγγράφου';

  @override
  String get continueButton => 'Συνέχεια';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Ένα προστατευμένο έγγραφο εμφανίζεται από τη μνήμη, και αυτό καταλαμβάνει $size. Το άνοιγμά του θα χρησιμοποιήσει περίπου τόση μνήμη.';
  }

  @override
  String get shareProtectedNotice =>
      'Το κοινόχρηστο αντίγραφο διατηρεί τον κωδικό του εγγράφου.';

  @override
  String get unsupportedProtection =>
      'Η προστασία αυτού του εγγράφου δεν υποστηρίζεται. Το PDFSign ανοίγει έγγραφα που προστατεύονται με κωδικό, όχι με πιστοποιητικό.';

  @override
  String get menuBringToFront => 'Μεταφορά εμπρός';

  @override
  String get menuBringForward => 'Μεταφορά ένα επίπεδο εμπρός';

  @override
  String get menuSendBackward => 'Μεταφορά ένα επίπεδο πίσω';

  @override
  String get menuSendToBack => 'Μεταφορά πίσω';

  @override
  String get zOrderGroupLabel => 'Τακτοποίηση';

  @override
  String get menuUndo => 'Αναίρεση';

  @override
  String get menuRedo => 'Επανάληψη';

  @override
  String get dragToReorder => 'Σύρετε για αλλαγή σειράς';

  @override
  String get protectDocumentTitle => 'Προστασία εγγράφου';

  @override
  String get requirePasswordToOpen =>
      'Απαίτηση κωδικού για το άνοιγμα του εγγράφου';

  @override
  String get verifyFieldLabel => 'Επιβεβαίωση';

  @override
  String get permissionsHeading => 'Δικαιώματα';

  @override
  String get permissionsNote =>
      'Να επιτρέπονται οι παρακάτω αλλαγές χωρίς εισαγωγή του κωδικού κατόχου.';

  @override
  String get permissionPrinting => 'Εκτύπωση';

  @override
  String get permissionCopying => 'Αντιγραφή κειμένου ή γραφικών';

  @override
  String get permissionPageAssembly =>
      'Εισαγωγή, διαγραφή και περιστροφή σελίδων';

  @override
  String get permissionAnnotations => 'Προσθήκη σχολίων και υπογραφών';

  @override
  String get permissionChangingContent => 'Αλλαγή του εγγράφου';

  @override
  String get permissionFormFilling => 'Συμπλήρωση υπαρχόντων πεδίων φόρμας';

  @override
  String get changingContentIncludes =>
      'Η αλλαγή του εγγράφου περιλαμβάνει τα σχόλια και τη συμπλήρωση φορμών — επιτρέπονται μαζί της.';

  @override
  String get ownerPasswordHeading => 'Κωδικός κατόχου';

  @override
  String get removeProtection => 'Αφαίρεση προστασίας';

  @override
  String get applyButton => 'Εφαρμογή';

  @override
  String get passwordsDoNotMatch => 'Οι κωδικοί δεν ταιριάζουν';

  @override
  String get passwordCannotBeEmpty => 'Εισαγάγετε κωδικό';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Οι περιορισμοί απαιτούν κωδικό κατόχου. Χωρίς αυτόν, οποιοσδήποτε μπορεί να τους άρει.';

  @override
  String get signingNeedsChangingContent =>
      'Χωρίς την «Αλλαγή του εγγράφου», αυτό το αρχείο δεν θα μπορεί να υπογραφεί ξανά εδώ χωρίς τον κωδικό κατόχου.';

  @override
  String get menuProtectDocument => 'Προστασία εγγράφου…';

  @override
  String get protectButtonLabel => 'Προστασία';

  @override
  String get protectButtonTooltip =>
      'Ορίστε τους κωδικούς και τα δικαιώματα αυτού του εγγράφου';
}
