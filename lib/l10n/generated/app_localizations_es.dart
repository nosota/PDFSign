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
  String get menuView => 'Visualización';

  @override
  String goToPagePrompt(int total) {
    return 'Introduce el número de página (1–$total):';
  }

  @override
  String get goToPageHint => 'Número de página';

  @override
  String get goToPageInvalid => 'Escribe un número válido';

  @override
  String goToPageOutOfRange(int total) {
    return 'La página debe estar entre 1 y $total';
  }

  @override
  String get menuRotateLeft => 'Girar a la izquierda';

  @override
  String get menuRotateRight => 'Girar a la derecha';

  @override
  String get menuCut => 'Cortar';

  @override
  String get menuCopy => 'Copiar';

  @override
  String get menuPaste => 'Pegar';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes superan',
      one: 'imagen supera',
    );
    return 'No se añadió: $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes superan',
      one: 'imagen supera',
    );
    return 'No se añadió: $count $_temp0 $limit píxeles';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes',
      one: 'imagen',
    );
    return 'No se añadió: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'El portapapeles no está disponible';

  @override
  String get pasteImageFailed => 'No se pudo añadir esa imagen';

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
  String get documentProtectedTitle => 'Este documento está protegido';

  @override
  String get documentProtectedBody => 'Introduce su contraseña para abrirlo.';

  @override
  String get passwordFieldLabel => 'Contraseña';

  @override
  String get openDocumentButton => 'Abrir';

  @override
  String get documentReadOnlyTitle => 'Este documento no permite cambios';

  @override
  String get documentReadOnlyBody =>
      'Se puede leer e imprimir, pero su propietario no ha permitido modificarlo. Introduce la contraseña del propietario para editarlo.';

  @override
  String get enterOwnerPassword => 'Introducir la contraseña del propietario';

  @override
  String get ownerPasswordFieldLabel => 'Contraseña del propietario';

  @override
  String get menuPrint => 'Imprimir…';

  @override
  String get menuPrintCurrentPage => 'Imprimir la página actual';

  @override
  String get printingIsTheOwnersTitle =>
      'Solo el propietario puede imprimir este documento';

  @override
  String get printingNotAllowed => 'Este documento no permite imprimir.';

  @override
  String get printingFailed => 'No se pudo imprimir el documento.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Solo el propietario puede cambiar la protección de este documento';

  @override
  String get continueButton => 'Continuar';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Un documento protegido se muestra desde la memoria, y este ocupa $size. Abrirlo usará aproximadamente esa misma cantidad.';
  }

  @override
  String get shareProtectedNotice =>
      'La copia compartida conserva la contraseña del documento.';

  @override
  String get unsupportedProtection =>
      'La protección de este documento no es compatible. PDFSign abre documentos protegidos con contraseña, no los protegidos con un certificado.';

  @override
  String get menuBringToFront => 'Traer al frente';

  @override
  String get menuBringForward => 'Traer adelante';

  @override
  String get menuSendBackward => 'Enviar atrás';

  @override
  String get menuSendToBack => 'Enviar al fondo';

  @override
  String get zOrderGroupLabel => 'Organizar';

  @override
  String get menuUndo => 'Deshacer';

  @override
  String get menuRedo => 'Rehacer';

  @override
  String get dragToReorder => 'Arrastra para cambiar el orden';

  @override
  String get protectDocumentTitle => 'Proteger documento';

  @override
  String get requirePasswordToOpen =>
      'Solicitar contraseña para abrir el documento';

  @override
  String get verifyFieldLabel => 'Confirmación';

  @override
  String get permissionsHeading => 'Permisos';

  @override
  String get permissionsNote =>
      'Permitir los siguientes cambios sin introducir la contraseña del propietario.';

  @override
  String get permissionPrinting => 'Impresión';

  @override
  String get permissionCopying => 'Copia de texto o gráficos';

  @override
  String get permissionPageAssembly =>
      'Inserción, eliminación o rotación de páginas';

  @override
  String get permissionAnnotations => 'Adición de anotaciones o firmas';

  @override
  String get permissionChangingContent => 'Modificación del documento';

  @override
  String get permissionFormFilling =>
      'Relleno de campos de formulario existentes';

  @override
  String get changingContentIncludes =>
      'La modificación del documento incluye anotar y rellenar formularios: ambos se permiten con ella.';

  @override
  String get ownerPasswordHeading => 'Contraseña del propietario';

  @override
  String get removeProtection => 'Quitar protección';

  @override
  String get applyButton => 'Aplicar';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get passwordCannotBeEmpty => 'Introduce una contraseña';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Las restricciones necesitan una contraseña del propietario. Sin ella, cualquiera puede levantarlas.';

  @override
  String get signingNeedsChangingContent =>
      'Sin «Modificación del documento», este archivo no podrá firmarse aquí de nuevo sin la contraseña del propietario.';

  @override
  String get menuProtectDocument => 'Proteger documento…';

  @override
  String get protectButtonLabel => 'Proteger';

  @override
  String get protectButtonTooltip =>
      'Definir las contraseñas y los permisos de este documento';
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
  String get menuView => 'Visualización';

  @override
  String goToPagePrompt(int total) {
    return 'Ingresa el número de página (1–$total):';
  }

  @override
  String get goToPageHint => 'Número de página';

  @override
  String get goToPageInvalid => 'Escribe un número válido';

  @override
  String goToPageOutOfRange(int total) {
    return 'La página debe estar entre 1 y $total';
  }

  @override
  String get menuRotateLeft => 'Girar a la izquierda';

  @override
  String get menuRotateRight => 'Girar a la derecha';

  @override
  String get menuCut => 'Cortar';

  @override
  String get menuCopy => 'Copiar';

  @override
  String get menuPaste => 'Pegar';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes superan',
      one: 'imagen supera',
    );
    return 'No se agregó: $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes superan',
      one: 'imagen supera',
    );
    return 'No se agregó: $count $_temp0 $limit píxeles';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes',
      one: 'imagen',
    );
    return 'No se agregó: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'El portapapeles no está disponible';

  @override
  String get pasteImageFailed => 'No se pudo agregar esa imagen';

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

  @override
  String get documentProtectedTitle => 'Este documento está protegido';

  @override
  String get documentProtectedBody => 'Ingresa su contraseña para abrirlo.';

  @override
  String get passwordFieldLabel => 'Contraseña';

  @override
  String get openDocumentButton => 'Abrir';

  @override
  String get documentReadOnlyTitle => 'Este documento no permite cambios';

  @override
  String get documentReadOnlyBody =>
      'Se puede leer e imprimir, pero su propietario no ha permitido modificarlo. Ingresa la contraseña del propietario para editarlo.';

  @override
  String get enterOwnerPassword => 'Ingresar la contraseña del propietario';

  @override
  String get ownerPasswordFieldLabel => 'Contraseña del propietario';

  @override
  String get menuPrint => 'Imprimir…';

  @override
  String get menuPrintCurrentPage => 'Imprimir la página actual';

  @override
  String get printingIsTheOwnersTitle =>
      'Solo el propietario puede imprimir este documento';

  @override
  String get printingNotAllowed => 'Este documento no permite imprimir.';

  @override
  String get printingFailed => 'No se pudo imprimir el documento.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Solo el propietario puede cambiar la protección de este documento';

  @override
  String get continueButton => 'Continuar';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Un documento protegido se muestra desde la memoria, y este ocupa $size. Abrirlo usará aproximadamente esa misma cantidad.';
  }

  @override
  String get shareProtectedNotice =>
      'La copia compartida conserva la contraseña del documento.';

  @override
  String get unsupportedProtection =>
      'La protección de este documento no es compatible. PDFSign abre documentos protegidos con contraseña, no los protegidos con un certificado.';

  @override
  String get menuBringToFront => 'Traer al frente';

  @override
  String get menuBringForward => 'Traer adelante';

  @override
  String get menuSendBackward => 'Enviar atrás';

  @override
  String get menuSendToBack => 'Enviar al fondo';

  @override
  String get zOrderGroupLabel => 'Organizar';

  @override
  String get menuUndo => 'Deshacer';

  @override
  String get menuRedo => 'Rehacer';

  @override
  String get dragToReorder => 'Arrastra para cambiar el orden';

  @override
  String get protectDocumentTitle => 'Proteger documento';

  @override
  String get requirePasswordToOpen =>
      'Solicitar contraseña para abrir el documento';

  @override
  String get verifyFieldLabel => 'Confirmación';

  @override
  String get permissionsHeading => 'Permisos';

  @override
  String get permissionsNote =>
      'Permitir los siguientes cambios sin ingresar la contraseña del propietario.';

  @override
  String get permissionPrinting => 'Impresión';

  @override
  String get permissionCopying => 'Copia de texto o gráficos';

  @override
  String get permissionPageAssembly =>
      'Inserción, eliminación o rotación de páginas';

  @override
  String get permissionAnnotations => 'Adición de anotaciones o firmas';

  @override
  String get permissionChangingContent => 'Modificación del documento';

  @override
  String get permissionFormFilling =>
      'Relleno de campos de formulario existentes';

  @override
  String get changingContentIncludes =>
      'La modificación del documento incluye anotar y rellenar formularios: ambos se permiten con ella.';

  @override
  String get ownerPasswordHeading => 'Contraseña del propietario';

  @override
  String get removeProtection => 'Quitar protección';

  @override
  String get applyButton => 'Aplicar';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get passwordCannotBeEmpty => 'Ingresa una contraseña';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Las restricciones necesitan una contraseña del propietario. Sin ella, cualquiera puede levantarlas.';

  @override
  String get signingNeedsChangingContent =>
      'Sin «Modificación del documento», este archivo no podrá firmarse aquí de nuevo sin la contraseña del propietario.';

  @override
  String get menuProtectDocument => 'Proteger documento…';

  @override
  String get protectButtonLabel => 'Proteger';

  @override
  String get protectButtonTooltip =>
      'Definir las contraseñas y los permisos de este documento';
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
  String get menuView => 'Visualización';

  @override
  String goToPagePrompt(int total) {
    return 'Introduce el número de página (1–$total):';
  }

  @override
  String get goToPageHint => 'Número de página';

  @override
  String get goToPageInvalid => 'Escribe un número válido';

  @override
  String goToPageOutOfRange(int total) {
    return 'La página debe estar entre 1 y $total';
  }

  @override
  String get menuRotateLeft => 'Girar a la izquierda';

  @override
  String get menuRotateRight => 'Girar a la derecha';

  @override
  String get menuCut => 'Cortar';

  @override
  String get menuCopy => 'Copiar';

  @override
  String get menuPaste => 'Pegar';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes superan',
      one: 'imagen supera',
    );
    return 'No se añadió: $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes superan',
      one: 'imagen supera',
    );
    return 'No se añadió: $count $_temp0 $limit píxeles';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes',
      one: 'imagen',
    );
    return 'No se añadió: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'El portapapeles no está disponible';

  @override
  String get pasteImageFailed => 'No se pudo añadir esa imagen';

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

  @override
  String get documentProtectedTitle => 'Este documento está protegido';

  @override
  String get documentProtectedBody => 'Introduce su contraseña para abrirlo.';

  @override
  String get passwordFieldLabel => 'Contraseña';

  @override
  String get openDocumentButton => 'Abrir';

  @override
  String get documentReadOnlyTitle => 'Este documento no permite cambios';

  @override
  String get documentReadOnlyBody =>
      'Se puede leer e imprimir, pero su propietario no ha permitido modificarlo. Introduce la contraseña del propietario para editarlo.';

  @override
  String get enterOwnerPassword => 'Introducir la contraseña del propietario';

  @override
  String get ownerPasswordFieldLabel => 'Contraseña del propietario';

  @override
  String get menuPrint => 'Imprimir…';

  @override
  String get menuPrintCurrentPage => 'Imprimir la página actual';

  @override
  String get printingIsTheOwnersTitle =>
      'Solo el propietario puede imprimir este documento';

  @override
  String get printingNotAllowed => 'Este documento no permite imprimir.';

  @override
  String get printingFailed => 'No se pudo imprimir el documento.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Solo el propietario puede cambiar la protección de este documento';

  @override
  String get continueButton => 'Continuar';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Un documento protegido se muestra desde la memoria, y este ocupa $size. Abrirlo usará aproximadamente esa misma cantidad.';
  }

  @override
  String get shareProtectedNotice =>
      'La copia compartida conserva la contraseña del documento.';

  @override
  String get unsupportedProtection =>
      'La protección de este documento no es compatible. PDFSign abre documentos protegidos con contraseña, no los protegidos con un certificado.';

  @override
  String get menuBringToFront => 'Traer al frente';

  @override
  String get menuBringForward => 'Traer adelante';

  @override
  String get menuSendBackward => 'Enviar atrás';

  @override
  String get menuSendToBack => 'Enviar al fondo';

  @override
  String get zOrderGroupLabel => 'Organizar';

  @override
  String get menuUndo => 'Deshacer';

  @override
  String get menuRedo => 'Rehacer';

  @override
  String get dragToReorder => 'Arrastra para cambiar el orden';

  @override
  String get protectDocumentTitle => 'Proteger documento';

  @override
  String get requirePasswordToOpen =>
      'Solicitar contraseña para abrir el documento';

  @override
  String get verifyFieldLabel => 'Confirmación';

  @override
  String get permissionsHeading => 'Permisos';

  @override
  String get permissionsNote =>
      'Permitir los siguientes cambios sin introducir la contraseña del propietario.';

  @override
  String get permissionPrinting => 'Impresión';

  @override
  String get permissionCopying => 'Copia de texto o gráficos';

  @override
  String get permissionPageAssembly =>
      'Inserción, eliminación o rotación de páginas';

  @override
  String get permissionAnnotations => 'Adición de anotaciones o firmas';

  @override
  String get permissionChangingContent => 'Modificación del documento';

  @override
  String get permissionFormFilling =>
      'Relleno de campos de formulario existentes';

  @override
  String get changingContentIncludes =>
      'La modificación del documento incluye anotar y rellenar formularios: ambos se permiten con ella.';

  @override
  String get ownerPasswordHeading => 'Contraseña del propietario';

  @override
  String get removeProtection => 'Quitar protección';

  @override
  String get applyButton => 'Aplicar';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get passwordCannotBeEmpty => 'Introduce una contraseña';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Las restricciones necesitan una contraseña del propietario. Sin ella, cualquiera puede levantarlas.';

  @override
  String get signingNeedsChangingContent =>
      'Sin «Modificación del documento», este archivo no podrá firmarse aquí de nuevo sin la contraseña del propietario.';

  @override
  String get menuProtectDocument => 'Proteger documento…';

  @override
  String get protectButtonLabel => 'Proteger';

  @override
  String get protectButtonTooltip =>
      'Definir las contraseñas y los permisos de este documento';
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
  String get menuView => 'Visualización';

  @override
  String goToPagePrompt(int total) {
    return 'Ingresa el número de página (1–$total):';
  }

  @override
  String get goToPageHint => 'Número de página';

  @override
  String get goToPageInvalid => 'Escribe un número válido';

  @override
  String goToPageOutOfRange(int total) {
    return 'La página debe estar entre 1 y $total';
  }

  @override
  String get menuRotateLeft => 'Girar a la izquierda';

  @override
  String get menuRotateRight => 'Girar a la derecha';

  @override
  String get menuCut => 'Cortar';

  @override
  String get menuCopy => 'Copiar';

  @override
  String get menuPaste => 'Pegar';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes superan',
      one: 'imagen supera',
    );
    return 'No se agregó: $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes superan',
      one: 'imagen supera',
    );
    return 'No se agregó: $count $_temp0 $limit píxeles';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imágenes',
      one: 'imagen',
    );
    return 'No se agregó: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'El portapapeles no está disponible';

  @override
  String get pasteImageFailed => 'No se pudo agregar esa imagen';

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

  @override
  String get documentProtectedTitle => 'Este documento está protegido';

  @override
  String get documentProtectedBody => 'Ingresa su contraseña para abrirlo.';

  @override
  String get passwordFieldLabel => 'Contraseña';

  @override
  String get openDocumentButton => 'Abrir';

  @override
  String get documentReadOnlyTitle => 'Este documento no permite cambios';

  @override
  String get documentReadOnlyBody =>
      'Se puede leer e imprimir, pero su propietario no ha permitido modificarlo. Ingresa la contraseña del propietario para editarlo.';

  @override
  String get enterOwnerPassword => 'Ingresar la contraseña del propietario';

  @override
  String get ownerPasswordFieldLabel => 'Contraseña del propietario';

  @override
  String get menuPrint => 'Imprimir…';

  @override
  String get menuPrintCurrentPage => 'Imprimir la página actual';

  @override
  String get printingIsTheOwnersTitle =>
      'Solo el propietario puede imprimir este documento';

  @override
  String get printingNotAllowed => 'Este documento no permite imprimir.';

  @override
  String get printingFailed => 'No se pudo imprimir el documento.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Solo el propietario puede cambiar la protección de este documento';

  @override
  String get continueButton => 'Continuar';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Un documento protegido se muestra desde la memoria, y este ocupa $size. Abrirlo usará aproximadamente esa misma cantidad.';
  }

  @override
  String get shareProtectedNotice =>
      'La copia compartida conserva la contraseña del documento.';

  @override
  String get unsupportedProtection =>
      'La protección de este documento no es compatible. PDFSign abre documentos protegidos con contraseña, no los protegidos con un certificado.';

  @override
  String get menuBringToFront => 'Traer al frente';

  @override
  String get menuBringForward => 'Traer adelante';

  @override
  String get menuSendBackward => 'Enviar atrás';

  @override
  String get menuSendToBack => 'Enviar al fondo';

  @override
  String get zOrderGroupLabel => 'Organizar';

  @override
  String get menuUndo => 'Deshacer';

  @override
  String get menuRedo => 'Rehacer';

  @override
  String get dragToReorder => 'Arrastra para cambiar el orden';

  @override
  String get protectDocumentTitle => 'Proteger documento';

  @override
  String get requirePasswordToOpen =>
      'Solicitar contraseña para abrir el documento';

  @override
  String get verifyFieldLabel => 'Confirmación';

  @override
  String get permissionsHeading => 'Permisos';

  @override
  String get permissionsNote =>
      'Permitir los siguientes cambios sin ingresar la contraseña del propietario.';

  @override
  String get permissionPrinting => 'Impresión';

  @override
  String get permissionCopying => 'Copia de texto o gráficos';

  @override
  String get permissionPageAssembly =>
      'Inserción, eliminación o rotación de páginas';

  @override
  String get permissionAnnotations => 'Adición de anotaciones o firmas';

  @override
  String get permissionChangingContent => 'Modificación del documento';

  @override
  String get permissionFormFilling =>
      'Relleno de campos de formulario existentes';

  @override
  String get changingContentIncludes =>
      'La modificación del documento incluye anotar y rellenar formularios: ambos se permiten con ella.';

  @override
  String get ownerPasswordHeading => 'Contraseña del propietario';

  @override
  String get removeProtection => 'Quitar protección';

  @override
  String get applyButton => 'Aplicar';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get passwordCannotBeEmpty => 'Ingresa una contraseña';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Las restricciones necesitan una contraseña del propietario. Sin ella, cualquiera puede levantarlas.';

  @override
  String get signingNeedsChangingContent =>
      'Sin «Modificación del documento», este archivo no podrá firmarse aquí de nuevo sin la contraseña del propietario.';

  @override
  String get menuProtectDocument => 'Proteger documento…';

  @override
  String get protectButtonLabel => 'Proteger';

  @override
  String get protectButtonTooltip =>
      'Definir las contraseñas y los permisos de este documento';
}
