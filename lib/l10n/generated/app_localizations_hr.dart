// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Croatian (`hr`).
class AppLocalizationsHr extends AppLocalizations {
  AppLocalizationsHr([String locale = 'hr']) : super(locale);

  @override
  String get openPdf => 'Otvori PDF';

  @override
  String get selectPdf => 'Odaberi PDF';

  @override
  String get recentFiles => 'Nedavne datoteke';

  @override
  String get removeFromList => 'Ukloni s popisa';

  @override
  String get openedNow => 'Upravo otvoreno';

  @override
  String openedMinutesAgo(int count) {
    return 'Otvoreno prije $count minuta';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Otvoreno prije $count sati';
  }

  @override
  String get openedYesterday => 'Otvoreno jucer';

  @override
  String openedDaysAgo(int count) {
    return 'Otvoreno prije $count dana';
  }

  @override
  String get fileNotFound => 'Datoteka nije pronadena';

  @override
  String get fileAccessDenied => 'Pristup odbijen';

  @override
  String get clearRecentFiles => 'Ocisti nedavne datoteke';

  @override
  String get cancel => 'Odustani';

  @override
  String get confirm => 'Potvrdi';

  @override
  String get error => 'Greska';

  @override
  String get ok => 'U redu';

  @override
  String get menuFile => 'Datoteka';

  @override
  String get menuOpen => 'Otvori...';

  @override
  String get menuOpenRecent => 'Otvori nedavne';

  @override
  String get menuNoRecentFiles => 'Nema nedavnih datoteka';

  @override
  String get menuClearMenu => 'Ocisti izbornik';

  @override
  String get menuSave => 'Spremi';

  @override
  String get menuSaveAs => 'Spremi kao...';

  @override
  String get menuSaveAll => 'Spremi sve';

  @override
  String get menuShare => 'Podijeli...';

  @override
  String get menuCloseWindow => 'Zatvori prozor';

  @override
  String get menuCloseAll => 'Zatvori sve';

  @override
  String get menuEdit => 'Uređivanje';

  @override
  String get menuDelete => 'Obriši';

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
  String get menuQuit => 'Zatvori PDFSign';

  @override
  String get closeAllDialogTitle => 'Spremi promjene?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Želite li spremiti promjene u $count dokumenata prije zatvaranja?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Želite li spremiti promjene u 1 dokumentu prije zatvaranja?';

  @override
  String get closeAllDialogSaveAll => 'Spremi sve';

  @override
  String get closeAllDialogDontSave => 'Ne spremi';

  @override
  String get closeAllDialogCancel => 'Odustani';

  @override
  String get saveFailedDialogTitle => 'Spremanje nije uspjelo';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Spremanje $count dokumenta nije uspjelo. Svejedno zatvoriti?';
  }

  @override
  String get saveFailedDialogClose => 'Svejedno zatvori';

  @override
  String get saveChangesTitle => 'Spremi promjene?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Zelite li spremiti promjene u \"$fileName\" prije zatvaranja?';
  }

  @override
  String get saveButton => 'Spremi';

  @override
  String get discardButton => 'Ne spremi';

  @override
  String get documentEdited => 'Uredeno';

  @override
  String get documentSaved => 'Spremljeno';

  @override
  String get menuSettings => 'Postavke...';

  @override
  String get menuWindow => 'Prozor';

  @override
  String get menuMinimize => 'Minimiziraj';

  @override
  String get menuZoom => 'Zumiraj';

  @override
  String get menuBringAllToFront => 'Dovedi sve naprijed';

  @override
  String get settingsTitle => 'Postavke';

  @override
  String get settingsLanguage => 'Jezik';

  @override
  String get settingsLanguageSystem => 'Zadano sustava';

  @override
  String get settingsUnits => 'Jedinice';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Inci';

  @override
  String get settingsSearchLanguages => 'Pretraži jezike...';

  @override
  String get settingsGeneral => 'Opće';

  @override
  String get addImage => 'Dodaj sliku';

  @override
  String get selectImages => 'Odaberi slike';

  @override
  String get zoomFitWidth => 'Prilagodi širini';

  @override
  String get zoomIn => 'Povećaj';

  @override
  String get zoomOut => 'Smanji';

  @override
  String get selectZoomLevel => 'Odaberi razinu zumiranja';

  @override
  String get goToPage => 'Idi na stranicu';

  @override
  String get go => 'Idi';

  @override
  String get savePdfAs => 'Spremi PDF kao';

  @override
  String get incorrectPassword => 'Pogrešna lozinka';

  @override
  String get saveFailed => 'Spremanje nije uspjelo';

  @override
  String savedTo(String path) {
    return 'Spremljeno u: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nema pohranjenog izvornog PDF-a';

  @override
  String get waitingForFolderPermission => 'Čekanje dozvole za pristup mapi...';

  @override
  String get deleteButtonLabel => 'Obriši';

  @override
  String get deleteButtonTooltip => 'Obriši odabrani objekt';

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
}
