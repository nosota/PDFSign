// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get openPdf => 'Deschide PDF';

  @override
  String get selectPdf => 'Selecteaza PDF';

  @override
  String get recentFiles => 'Fisiere recente';

  @override
  String get removeFromList => 'Elimina din lista';

  @override
  String get openedNow => 'Deschis acum';

  @override
  String openedMinutesAgo(int count) {
    return 'Deschis acum $count minute';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Deschis acum $count ore';
  }

  @override
  String get openedYesterday => 'Deschis ieri';

  @override
  String openedDaysAgo(int count) {
    return 'Deschis acum $count zile';
  }

  @override
  String get fileNotFound => 'Fisierul nu a fost gasit';

  @override
  String get fileAccessDenied => 'Acces refuzat';

  @override
  String get clearRecentFiles => 'Sterge fisierele recente';

  @override
  String get cancel => 'Anulare';

  @override
  String get confirm => 'Confirmare';

  @override
  String get error => 'Eroare';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fisier';

  @override
  String get menuOpen => 'Deschide...';

  @override
  String get menuOpenRecent => 'Deschide recente';

  @override
  String get menuNoRecentFiles => 'Nu exista fisiere recente';

  @override
  String get menuClearMenu => 'Sterge meniu';

  @override
  String get menuSave => 'Salvare';

  @override
  String get menuSaveAs => 'Salvare ca...';

  @override
  String get menuSaveAll => 'Salvează tot';

  @override
  String get menuShare => 'Partajare...';

  @override
  String get menuCloseWindow => 'Inchide fereastra';

  @override
  String get menuCloseAll => 'Închide tot';

  @override
  String get menuEdit => 'Editare';

  @override
  String get menuDelete => 'Șterge';

  @override
  String get menuView => 'Vizualizare';

  @override
  String goToPagePrompt(int total) {
    return 'Introduceți numărul paginii (1–$total):';
  }

  @override
  String get goToPageHint => 'Numărul paginii';

  @override
  String get goToPageInvalid => 'Introduceți un număr valid';

  @override
  String goToPageOutOfRange(int total) {
    return 'Pagina trebuie să fie între 1 și $total';
  }

  @override
  String get menuRotateLeft => 'Rotire la stânga';

  @override
  String get menuRotateRight => 'Rotire la dreapta';

  @override
  String get menuCut => 'Decupare';

  @override
  String get menuCopy => 'Copiere';

  @override
  String get menuPaste => 'Lipire';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Nu s-au adăugat imagini: $count — depășesc $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Nu s-au adăugat imagini: $count — depășesc $limit pixeli';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Nu s-au adăugat imagini: $count';
  }

  @override
  String get clipboardUnavailable => 'Clipboardul nu este disponibil';

  @override
  String get pasteImageFailed => 'Această imagine nu a putut fi adăugată';

  @override
  String get menuQuit => 'Ieșire din PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvați modificările?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Doriți să salvați modificările din $count documente înainte de închidere?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Doriți să salvați modificările din 1 document înainte de închidere?';

  @override
  String get closeAllDialogSaveAll => 'Salvează tot';

  @override
  String get closeAllDialogDontSave => 'Nu salva';

  @override
  String get closeAllDialogCancel => 'Anulare';

  @override
  String get saveFailedDialogTitle => 'Salvarea a eșuat';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nu s-au putut salva $count document(e). Închideți oricum?';
  }

  @override
  String get saveFailedDialogClose => 'Închide oricum';

  @override
  String get saveChangesTitle => 'Salvati modificarile?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Doriti sa salvati modificarile din \"$fileName\" inainte de inchidere?';
  }

  @override
  String get saveButton => 'Salvare';

  @override
  String get discardButton => 'Renuntare';

  @override
  String get documentEdited => 'Editat';

  @override
  String get documentSaved => 'Salvat';

  @override
  String get menuSettings => 'Setari...';

  @override
  String get menuWindow => 'Fereastră';

  @override
  String get menuMinimize => 'Minimizare';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Adu Toate în Față';

  @override
  String get settingsTitle => 'Setari';

  @override
  String get settingsLanguage => 'Limba';

  @override
  String get settingsLanguageSystem => 'Implicit sistem';

  @override
  String get settingsUnits => 'Unitati';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Toli';

  @override
  String get settingsSearchLanguages => 'Căutare limbi...';

  @override
  String get settingsGeneral => 'General';

  @override
  String get addImage => 'Adaugă imagine';

  @override
  String get selectImages => 'Selectează imagini';

  @override
  String get zoomFitWidth => 'Potrivire lățime';

  @override
  String get zoomIn => 'Mărește';

  @override
  String get zoomOut => 'Micșorează';

  @override
  String get selectZoomLevel => 'Selectează nivelul de zoom';

  @override
  String get goToPage => 'Mergi la pagina';

  @override
  String get go => 'Mergi';

  @override
  String get savePdfAs => 'Salvează PDF ca';

  @override
  String get incorrectPassword => 'Parolă incorectă';

  @override
  String get saveFailed => 'Salvare eșuată';

  @override
  String savedTo(String path) {
    return 'Salvat în: $path';
  }

  @override
  String get noOriginalPdfStored => 'Niciun PDF original stocat';

  @override
  String get waitingForFolderPermission =>
      'Se așteaptă permisiunea de acces la folder...';

  @override
  String get deleteButtonLabel => 'Șterge';

  @override
  String get deleteButtonTooltip => 'Șterge obiectul selectat';

  @override
  String get documentProtectedTitle => 'Acest document este protejat';

  @override
  String get documentProtectedBody => 'Introduceți parola pentru a-l deschide.';

  @override
  String get passwordFieldLabel => 'Parolă';

  @override
  String get openDocumentButton => 'Deschide';

  @override
  String get documentReadOnlyTitle => 'Acest document nu permite modificări';

  @override
  String get documentReadOnlyBody =>
      'Poate fi citit și tipărit, dar proprietarul nu a permis modificarea lui. Introduceți parola proprietarului pentru a-l edita.';

  @override
  String get enterOwnerPassword => 'Introduceți parola proprietarului';

  @override
  String get ownerPasswordFieldLabel => 'Parola proprietarului';

  @override
  String get menuPrint => 'Tipărire…';

  @override
  String get menuPrintCurrentPage => 'Tipărirea paginii curente';

  @override
  String get printingIsTheOwnersTitle =>
      'Numai proprietarul poate tipări acest document';

  @override
  String get printingNotAllowed => 'Acest document nu permite tipărirea.';

  @override
  String get printingFailed => 'Documentul nu a putut fi tipărit.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Numai proprietarul poate schimba protecția acestui document';

  @override
  String get continueButton => 'Continuă';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Un document protejat este afișat din memorie, iar acesta ocupă $size. Deschiderea lui va folosi aproximativ tot atât.';
  }

  @override
  String get shareProtectedNotice =>
      'Copia partajată păstrează parola documentului.';

  @override
  String get unsupportedProtection =>
      'Protecția acestui document nu este acceptată. PDFSign deschide documente protejate prin parolă, nu pe cele protejate printr-un certificat.';

  @override
  String get menuBringToFront => 'Adu în față';

  @override
  String get menuBringForward => 'Mută înainte';

  @override
  String get menuSendBackward => 'Mută înapoi';

  @override
  String get menuSendToBack => 'Trimite în spate';

  @override
  String get zOrderGroupLabel => 'Aranjare';

  @override
  String get menuUndo => 'Anulează';

  @override
  String get menuRedo => 'Refă';

  @override
  String get dragToReorder => 'Trageți pentru a schimba ordinea';

  @override
  String get protectDocumentTitle => 'Protejarea documentului';

  @override
  String get requirePasswordToOpen =>
      'Solicită o parolă pentru deschiderea documentului';

  @override
  String get verifyFieldLabel => 'Confirmare';

  @override
  String get permissionsHeading => 'Permisiuni';

  @override
  String get permissionsNote =>
      'Permite următoarele modificări fără introducerea parolei proprietarului.';

  @override
  String get permissionPrinting => 'Tipărire';

  @override
  String get permissionCopying => 'Copierea textului sau a graficii';

  @override
  String get permissionPageAssembly =>
      'Inserarea, ștergerea și rotirea paginilor';

  @override
  String get permissionAnnotations => 'Adăugarea de adnotări și semnături';

  @override
  String get permissionChangingContent => 'Modificarea documentului';

  @override
  String get permissionFormFilling =>
      'Completarea câmpurilor de formular existente';

  @override
  String get changingContentIncludes =>
      'Modificarea documentului include adnotarea și completarea formularelor — acestea sunt permise odată cu ea.';

  @override
  String get ownerPasswordHeading => 'Parola proprietarului';

  @override
  String get removeProtection => 'Elimină protecția';

  @override
  String get applyButton => 'Aplică';

  @override
  String get passwordsDoNotMatch => 'Parolele nu coincid';

  @override
  String get passwordCannotBeEmpty => 'Introduceți o parolă';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Restricțiile necesită o parolă a proprietarului. Fără ea, oricine le poate elimina.';

  @override
  String get signingNeedsChangingContent =>
      'Fără „Modificarea documentului”, acest fișier nu va mai putea fi semnat aici fără parola proprietarului.';

  @override
  String get menuProtectDocument => 'Protejează documentul…';

  @override
  String get protectButtonLabel => 'Protejează';

  @override
  String get protectButtonTooltip =>
      'Stabiliți parolele și permisiunile acestui document';
}
