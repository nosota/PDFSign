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
  String get menuView => 'Visualització';

  @override
  String goToPagePrompt(int total) {
    return 'Introdueix el número de pàgina (1–$total):';
  }

  @override
  String get goToPageHint => 'Número de pàgina';

  @override
  String get goToPageInvalid => 'Escriu un número vàlid';

  @override
  String goToPageOutOfRange(int total) {
    return 'La pàgina ha d’estar entre 1 i $total';
  }

  @override
  String get menuRotateLeft => 'Gira a l’esquerra';

  @override
  String get menuRotateRight => 'Gira a la dreta';

  @override
  String get menuCut => 'Retalla';

  @override
  String get menuCopy => 'Copia';

  @override
  String get menuPaste => 'Enganxa';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imatges superen',
      one: 'imatge supera',
    );
    return 'No s’ha afegit: $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imatges superen',
      one: 'imatge supera',
    );
    return 'No s’ha afegit: $count $_temp0 $limit píxels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imatges',
      one: 'imatge',
    );
    return 'No s’ha afegit: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'El porta-retalls no està disponible';

  @override
  String get pasteImageFailed => 'No s’ha pogut afegir aquesta imatge';

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
  String get documentProtectedTitle => 'Aquest document està protegit';

  @override
  String get documentProtectedBody => 'Introdueix la contrasenya per obrir-lo.';

  @override
  String get passwordFieldLabel => 'Contrasenya';

  @override
  String get openDocumentButton => 'Obre';

  @override
  String get documentReadOnlyTitle => 'Aquest document no permet canvis';

  @override
  String get documentReadOnlyBody =>
      'Es pot llegir i imprimir, però el propietari no n’ha permès la modificació. Introdueix la contrasenya del propietari per editar-lo.';

  @override
  String get enterOwnerPassword => 'Introdueix la contrasenya del propietari';

  @override
  String get ownerPasswordFieldLabel => 'Contrasenya del propietari';

  @override
  String get menuPrint => 'Imprimeix…';

  @override
  String get menuPrintCurrentPage => 'Imprimeix la pàgina actual';

  @override
  String get printingIsTheOwnersTitle =>
      'Només el propietari pot imprimir aquest document';

  @override
  String get printingNotAllowed => 'Aquest document no permet imprimir.';

  @override
  String get printingFailed => 'No s’ha pogut imprimir el document.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Només el propietari pot canviar la protecció d’aquest document';

  @override
  String get continueButton => 'Continua';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Un document protegit es mostra des de la memòria, i aquest ocupa $size. Obrir-lo en farà servir aproximadament la mateixa quantitat.';
  }

  @override
  String get shareProtectedNotice =>
      'La còpia compartida conserva la contrasenya del document.';

  @override
  String get unsupportedProtection =>
      'La protecció d’aquest document no és compatible. PDFSign obre documents protegits amb contrasenya, però no els protegits amb un certificat.';

  @override
  String get menuBringToFront => 'Porta al davant';

  @override
  String get menuBringForward => 'Avança';

  @override
  String get menuSendBackward => 'Endarrereix';

  @override
  String get menuSendToBack => 'Porta al darrere';

  @override
  String get zOrderGroupLabel => 'Organitza';

  @override
  String get menuUndo => 'Desfés';

  @override
  String get menuRedo => 'Refés';

  @override
  String get dragToReorder => 'Arrossega per canviar l’ordre';

  @override
  String get protectDocumentTitle => 'Protegeix el document';

  @override
  String get requirePasswordToOpen =>
      'Demana una contrasenya per obrir el document';

  @override
  String get verifyFieldLabel => 'Confirmació';

  @override
  String get permissionsHeading => 'Permisos';

  @override
  String get permissionsNote =>
      'Permet els canvis següents sense introduir la contrasenya del propietari.';

  @override
  String get permissionPrinting => 'Impressió';

  @override
  String get permissionCopying => 'Còpia de text o gràfics';

  @override
  String get permissionPageAssembly =>
      'Inserció, eliminació o rotació de pàgines';

  @override
  String get permissionAnnotations => 'Addició d’anotacions o signatures';

  @override
  String get permissionChangingContent => 'Modificació del document';

  @override
  String get permissionFormFilling =>
      'Emplenament dels camps de formulari existents';

  @override
  String get changingContentIncludes =>
      'La modificació del document inclou anotar i emplenar formularis: tots dos es permeten amb ella.';

  @override
  String get ownerPasswordHeading => 'Contrasenya del propietari';

  @override
  String get removeProtection => 'Elimina la protecció';

  @override
  String get applyButton => 'Aplica';

  @override
  String get passwordsDoNotMatch => 'Les contrasenyes no coincideixen';

  @override
  String get passwordCannotBeEmpty => 'Introdueix una contrasenya';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Les restriccions necessiten una contrasenya del propietari. Sense ella, qualsevol les pot aixecar.';

  @override
  String get signingNeedsChangingContent =>
      'Sense «Modificació del document», aquest fitxer no es podrà tornar a signar aquí sense la contrasenya del propietari.';

  @override
  String get menuProtectDocument => 'Protegeix el document…';

  @override
  String get protectButtonLabel => 'Protegeix';

  @override
  String get protectButtonTooltip =>
      'Defineix les contrasenyes i els permisos d’aquest document';
}
