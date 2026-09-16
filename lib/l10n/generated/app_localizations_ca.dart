// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get openPdf => 'Obre PDF';

  @override
  String get selectPdf => 'Selecciona PDF';

  @override
  String get recentFiles => 'Fitxers recents';

  @override
  String get removeFromList => 'Elimina de la llista';

  @override
  String get openedNow => 'Obert ara mateix';

  @override
  String openedMinutesAgo(int count) {
    return 'Obert fa $count minuts';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Obert fa $count hores';
  }

  @override
  String get openedYesterday => 'Obert ahir';

  @override
  String openedDaysAgo(int count) {
    return 'Obert fa $count dies';
  }

  @override
  String get fileNotFound => 'Fitxer no trobat';

  @override
  String get fileAccessDenied => 'Acces denegat';

  @override
  String get clearRecentFiles => 'Neteja fitxers recents';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get confirm => 'Confirma';

  @override
  String get error => 'Error';

  @override
  String get ok => 'D\'acord';

  @override
  String get menuFile => 'Fitxer';

  @override
  String get menuOpen => 'Obre...';

  @override
  String get menuOpenRecent => 'Obre recents';

  @override
  String get menuNoRecentFiles => 'Cap fitxer recent';

  @override
  String get menuClearMenu => 'Neteja el menu';

  @override
  String get menuSave => 'Desa';

  @override
  String get menuSaveAs => 'Anomena i desa...';

  @override
  String get menuSaveAll => 'Desa-ho tot';

  @override
  String get menuShare => 'Comparteix...';

  @override
  String get menuCloseWindow => 'Tanca la finestra';

  @override
  String get menuCloseAll => 'Tanca-ho tot';

  @override
  String get menuEdit => 'Edita';

  @override
  String get menuDelete => 'Suprimeix';

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
  String get menuQuit => 'Sortir de PDFSign';

  @override
  String get closeAllDialogTitle => 'Desar els canvis?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vols desar els canvis a $count documents abans de tancar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vols desar els canvis a 1 document abans de tancar?';

  @override
  String get closeAllDialogSaveAll => 'Desa-ho tot';

  @override
  String get closeAllDialogDontSave => 'No desis';

  @override
  String get closeAllDialogCancel => 'Cancel·la';

  @override
  String get saveFailedDialogTitle => 'Error en desar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No s\'han pogut desar $count document(s). Tancar igualment?';
  }

  @override
  String get saveFailedDialogClose => 'Tanca igualment';

  @override
  String get saveChangesTitle => 'Desar els canvis?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vols desar els canvis a \"$fileName\" abans de tancar?';
  }

  @override
  String get saveButton => 'Desa';

  @override
  String get discardButton => 'No desis';

  @override
  String get documentEdited => 'Editat';

  @override
  String get documentSaved => 'Desat';

  @override
  String get menuSettings => 'Configuracio...';

  @override
  String get menuWindow => 'Finestra';

  @override
  String get menuMinimize => 'Minimitza';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Porta-ho tot al davant';

  @override
  String get settingsTitle => 'Configuracio';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Per defecte del sistema';

  @override
  String get settingsUnits => 'Unitats';

  @override
  String get settingsUnitsCentimeters => 'Centimetres';

  @override
  String get settingsUnitsInches => 'Polzades';

  @override
  String get settingsSearchLanguages => 'Cercar idiomes...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Afegeix imatge';

  @override
  String get selectImages => 'Selecciona imatges';

  @override
  String get zoomFitWidth => 'Ajusta a l\'amplada';

  @override
  String get zoomIn => 'Apropa';

  @override
  String get zoomOut => 'Allunya';

  @override
  String get selectZoomLevel => 'Selecciona nivell de zoom';

  @override
  String get goToPage => 'Vés a la pàgina';

  @override
  String get go => 'Vés';

  @override
  String get savePdfAs => 'Desa PDF com';

  @override
  String get incorrectPassword => 'Contrasenya incorrecta';

  @override
  String get saveFailed => 'Error en desar';

  @override
  String savedTo(String path) {
    return 'Desat a: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hi ha PDF original emmagatzemat';

  @override
  String get waitingForFolderPermission =>
      'Esperant permís d\'accés a la carpeta...';

  @override
  String get deleteButtonLabel => 'Eliminar';

  @override
  String get deleteButtonTooltip => 'Eliminar l\'objecte seleccionat';

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
  String get largeProtectedDocumentTitle => 'This protected document is large';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'A protected document has to be held in memory to be shown, and this one is $size. Opening it will use about that much.';
  }

  @override
  String get openAnyway => 'Open';

  @override
  String get shareProtectedNotice =>
      'The shared copy keeps the document\'s password.';

  @override
  String get unsupportedProtection =>
      'This document\'s protection is not supported. PDFSign opens password-protected documents, not those protected by a certificate.';
}
