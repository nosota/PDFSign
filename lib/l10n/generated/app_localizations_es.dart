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
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

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
  String get addImage => 'Add Image';

  @override
  String get selectImages => 'Select Images';

  @override
  String get zoomFitWidth => 'Fit Width';

  @override
  String get zoomIn => 'Zoom In';

  @override
  String get zoomOut => 'Zoom Out';

  @override
  String get selectZoomLevel => 'Select zoom level';

  @override
  String get goToPage => 'Go to Page';

  @override
  String get go => 'Go';

  @override
  String get savePdfAs => 'Save PDF As';

  @override
  String get incorrectPassword => 'Incorrect password';

  @override
  String get saveFailed => 'Save failed';

  @override
  String savedTo(String path) {
    return 'Saved to: $path';
  }

  @override
  String get noOriginalPdfStored => 'No original PDF stored';
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
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

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
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

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
  String get menuShare => 'Compartir...';

  @override
  String get menuCloseWindow => 'Cerrar ventana';

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
}
