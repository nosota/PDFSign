// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Seleccionar PDF';

  @override
  String get recentFiles => 'Archivos recientes';

  @override
  String get removeFromList => 'Eliminar de la lista';

  @override
  String get openedNow => 'Abierto ahora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get openedYesterday => 'Abierto ayer';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get fileNotFound => 'Archivo no encontrado';

  @override
  String get fileAccessDenied => 'Acceso denegado';

  @override
  String get clearRecentFiles => 'Borrar archivos recientes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Aceptar';

  @override
  String get menuFile => 'Archivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir reciente';

  @override
  String get menuNoRecentFiles => 'No hay archivos recientes';

  @override
  String get menuClearMenu => 'Limpiar menú';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Guardar todo';

  @override
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

  @override
  String get menuCloseAll => 'Cerrar todo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get menuDelete => 'Eliminar';

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
  String get menuQuit => 'Salir de PDFSign';

  @override
  String get closeAllDialogTitle => '¿Guardar cambios?';

  @override
  String closeAllDialogMessage(int count) {
    return '¿Desea guardar los cambios en $count documentos antes de cerrar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      '¿Desea guardar los cambios en 1 documento antes de cerrar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar todo';

  @override
  String get closeAllDialogDontSave => 'No guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Error al guardar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No se pudieron guardar $count documento(s). ¿Cerrar de todos modos?';
  }

  @override
  String get saveFailedDialogClose => 'Cerrar de todos modos';

  @override
  String get saveChangesTitle => '¿Guardar cambios?';

  @override
  String saveChangesMessage(String fileName) {
    return '¿Deseas guardar los cambios en \"$fileName\" antes de cerrar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'No guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Configuración...';

  @override
  String get menuWindow => 'Ventana';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Traer todo al frente';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Pulgadas';

  @override
  String get settingsSearchLanguages => 'Buscar idiomas...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Añadir imagen';

  @override
  String get selectImages => 'Seleccionar imágenes';

  @override
  String get zoomFitWidth => 'Ajustar ancho';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get selectZoomLevel => 'Seleccionar nivel de zoom';

  @override
  String get goToPage => 'Ir a página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Contraseña incorrecta';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String savedTo(String path) {
    return 'Guardado en: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hay PDF original almacenado';

  @override
  String get waitingForFolderPermission =>
      'Esperando permiso de acceso a la carpeta...';

  @override
  String get deleteButtonLabel => 'Eliminar';

  @override
  String get deleteButtonTooltip => 'Eliminar objeto seleccionado';

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
  String get menuPrint => 'Print…';

  @override
  String get menuPrintCurrentPage => 'Print Current Page';

  @override
  String get printingIsTheOwnersTitle =>
      'Only the owner may print this document';

  @override
  String get printingNotAllowed => 'This document does not allow printing.';

  @override
  String get printingFailed => 'The document could not be printed.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Only the owner may change this document\'s protection';

  @override
  String get continueButton => 'Continue';

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

/// The translations for Spanish Castilian, as used in Argentina (`es_AR`).
class AppLocalizationsEsAr extends AppLocalizationsEs {
  AppLocalizationsEsAr() : super('es_AR');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Seleccionar PDF';

  @override
  String get recentFiles => 'Archivos recientes';

  @override
  String get removeFromList => 'Eliminar de la lista';

  @override
  String get openedNow => 'Abierto ahora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get openedYesterday => 'Abierto ayer';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get fileNotFound => 'Archivo no encontrado';

  @override
  String get fileAccessDenied => 'Acceso denegado';

  @override
  String get clearRecentFiles => 'Borrar archivos recientes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Aceptar';

  @override
  String get menuFile => 'Archivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir reciente';

  @override
  String get menuNoRecentFiles => 'No hay archivos recientes';

  @override
  String get menuClearMenu => 'Limpiar menú';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Guardar todo';

  @override
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

  @override
  String get menuCloseAll => 'Cerrar todo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get menuDelete => 'Eliminar';

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
  String get menuQuit => 'Salir de PDFSign';

  @override
  String get closeAllDialogTitle => '¿Guardar cambios?';

  @override
  String closeAllDialogMessage(int count) {
    return '¿Desea guardar los cambios en $count documentos antes de cerrar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      '¿Desea guardar los cambios en 1 documento antes de cerrar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar todo';

  @override
  String get closeAllDialogDontSave => 'No guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Error al guardar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No se pudieron guardar $count documento(s). ¿Cerrar de todos modos?';
  }

  @override
  String get saveFailedDialogClose => 'Cerrar de todos modos';

  @override
  String get saveChangesTitle => '¿Guardar cambios?';

  @override
  String saveChangesMessage(String fileName) {
    return '¿Deseás guardar los cambios en \"$fileName\" antes de cerrar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'No guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Configuración...';

  @override
  String get menuWindow => 'Ventana';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Traer todo al frente';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Pulgadas';

  @override
  String get settingsSearchLanguages => 'Buscar idiomas...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Agregar imagen';

  @override
  String get selectImages => 'Seleccionar imágenes';

  @override
  String get zoomFitWidth => 'Ajustar ancho';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get selectZoomLevel => 'Seleccionar nivel de zoom';

  @override
  String get goToPage => 'Ir a página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Contraseña incorrecta';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String savedTo(String path) {
    return 'Guardado en: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hay PDF original almacenado';

  @override
  String get waitingForFolderPermission =>
      'Esperando permiso de acceso a la carpeta...';

  @override
  String get deleteButtonLabel => 'Eliminar';

  @override
  String get deleteButtonTooltip => 'Eliminar objeto seleccionado';
}

/// The translations for Spanish Castilian, as used in Spain (`es_ES`).
class AppLocalizationsEsEs extends AppLocalizationsEs {
  AppLocalizationsEsEs() : super('es_ES');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Seleccionar PDF';

  @override
  String get recentFiles => 'Archivos recientes';

  @override
  String get removeFromList => 'Eliminar de la lista';

  @override
  String get openedNow => 'Abierto ahora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get openedYesterday => 'Abierto ayer';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get fileNotFound => 'Archivo no encontrado';

  @override
  String get fileAccessDenied => 'Acceso denegado';

  @override
  String get clearRecentFiles => 'Borrar archivos recientes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Aceptar';

  @override
  String get menuFile => 'Archivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir reciente';

  @override
  String get menuNoRecentFiles => 'No hay archivos recientes';

  @override
  String get menuClearMenu => 'Vaciar menú';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Guardar todo';

  @override
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

  @override
  String get menuCloseAll => 'Cerrar todo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get menuDelete => 'Eliminar';

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
  String get menuQuit => 'Salir de PDFSign';

  @override
  String get closeAllDialogTitle => '¿Guardar cambios?';

  @override
  String closeAllDialogMessage(int count) {
    return '¿Desea guardar los cambios en $count documentos antes de cerrar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      '¿Desea guardar los cambios en 1 documento antes de cerrar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar todo';

  @override
  String get closeAllDialogDontSave => 'No guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Error al guardar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No se pudieron guardar $count documento(s). ¿Cerrar de todos modos?';
  }

  @override
  String get saveFailedDialogClose => 'Cerrar de todos modos';

  @override
  String get saveChangesTitle => '¿Guardar cambios?';

  @override
  String saveChangesMessage(String fileName) {
    return '¿Deseáis guardar los cambios en «$fileName» antes de cerrar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'No guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Ajustes...';

  @override
  String get menuWindow => 'Ventana';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Traer todo al frente';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Pulgadas';

  @override
  String get settingsSearchLanguages => 'Buscar idiomas...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Añadir imagen';

  @override
  String get selectImages => 'Seleccionar imágenes';

  @override
  String get zoomFitWidth => 'Ajustar ancho';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get selectZoomLevel => 'Seleccionar nivel de zoom';

  @override
  String get goToPage => 'Ir a página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Contraseña incorrecta';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String savedTo(String path) {
    return 'Guardado en: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hay PDF original almacenado';

  @override
  String get waitingForFolderPermission =>
      'Esperando permiso de acceso a la carpeta...';

  @override
  String get deleteButtonLabel => 'Eliminar';

  @override
  String get deleteButtonTooltip => 'Eliminar objeto seleccionado';
}

/// The translations for Spanish Castilian, as used in Mexico (`es_MX`).
class AppLocalizationsEsMx extends AppLocalizationsEs {
  AppLocalizationsEsMx() : super('es_MX');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Seleccionar PDF';

  @override
  String get recentFiles => 'Archivos recientes';

  @override
  String get removeFromList => 'Eliminar de la lista';

  @override
  String get openedNow => 'Abierto ahora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get openedYesterday => 'Abierto ayer';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'días',
      one: 'día',
    );
    return 'Abierto hace $count $_temp0';
  }

  @override
  String get fileNotFound => 'Archivo no encontrado';

  @override
  String get fileAccessDenied => 'Acceso denegado';

  @override
  String get clearRecentFiles => 'Borrar archivos recientes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Error';

  @override
  String get ok => 'Aceptar';

  @override
  String get menuFile => 'Archivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir reciente';

  @override
  String get menuNoRecentFiles => 'No hay archivos recientes';

  @override
  String get menuClearMenu => 'Limpiar menú';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Guardar todo';

  @override
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

  @override
  String get menuCloseAll => 'Cerrar todo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get menuDelete => 'Eliminar';

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
  String get menuQuit => 'Salir de PDFSign';

  @override
  String get closeAllDialogTitle => '¿Guardar cambios?';

  @override
  String closeAllDialogMessage(int count) {
    return '¿Desea guardar los cambios en $count documentos antes de cerrar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      '¿Desea guardar los cambios en 1 documento antes de cerrar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar todo';

  @override
  String get closeAllDialogDontSave => 'No guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Error al guardar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'No se pudieron guardar $count documento(s). ¿Cerrar de todos modos?';
  }

  @override
  String get saveFailedDialogClose => 'Cerrar de todos modos';

  @override
  String get saveChangesTitle => '¿Guardar cambios?';

  @override
  String saveChangesMessage(String fileName) {
    return '¿Deseas guardar los cambios en \"$fileName\" antes de cerrar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'No guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Configuración...';

  @override
  String get menuWindow => 'Ventana';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Traer todo al frente';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Pulgadas';

  @override
  String get settingsSearchLanguages => 'Buscar idiomas...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Agregar imagen';

  @override
  String get selectImages => 'Seleccionar imágenes';

  @override
  String get zoomFitWidth => 'Ajustar ancho';

  @override
  String get zoomIn => 'Acercar';

  @override
  String get zoomOut => 'Alejar';

  @override
  String get selectZoomLevel => 'Seleccionar nivel de zoom';

  @override
  String get goToPage => 'Ir a página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Contraseña incorrecta';

  @override
  String get saveFailed => 'Error al guardar';

  @override
  String savedTo(String path) {
    return 'Guardado en: $path';
  }

  @override
  String get noOriginalPdfStored => 'No hay PDF original almacenado';

  @override
  String get waitingForFolderPermission =>
      'Esperando permiso de acceso a la carpeta...';

  @override
  String get deleteButtonLabel => 'Eliminar';

  @override
  String get deleteButtonTooltip => 'Eliminar objeto seleccionado';
}
