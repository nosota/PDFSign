// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get openPdf => 'Apri PDF';

  @override
  String get selectPdf => 'Seleziona PDF';

  @override
  String get recentFiles => 'File recenti';

  @override
  String get removeFromList => 'Rimuovi dalla lista';

  @override
  String get openedNow => 'Aperto ora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuti',
      one: 'minuto',
    );
    return 'Aperto $count $_temp0 fa';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ore',
      one: 'ora',
    );
    return 'Aperto $count $_temp0 fa';
  }

  @override
  String get openedYesterday => 'Aperto ieri';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'giorni',
      one: 'giorno',
    );
    return 'Aperto $count $_temp0 fa';
  }

  @override
  String get fileNotFound => 'File non trovato';

  @override
  String get fileAccessDenied => 'Accesso negato';

  @override
  String get clearRecentFiles => 'Cancella file recenti';

  @override
  String get cancel => 'Annulla';

  @override
  String get confirm => 'Conferma';

  @override
  String get error => 'Errore';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Apri...';

  @override
  String get menuOpenRecent => 'Apri recenti';

  @override
  String get menuNoRecentFiles => 'Nessun file recente';

  @override
  String get menuClearMenu => 'Cancella menu';

  @override
  String get menuSave => 'Salva';

  @override
  String get menuSaveAs => 'Salva come...';

  @override
  String get menuSaveAll => 'Salva tutto';

  @override
  String get menuShare => 'Condividi...';

  @override
  String get menuCloseWindow => 'Chiudi finestra';

  @override
  String get menuCloseAll => 'Chiudi tutto';

  @override
  String get menuEdit => 'Modifica';

  @override
  String get menuDelete => 'Elimina';

  @override
  String get menuView => 'Vista';

  @override
  String goToPagePrompt(int total) {
    return 'Inserisci il numero di pagina (1–$total):';
  }

  @override
  String get goToPageHint => 'Numero di pagina';

  @override
  String get goToPageInvalid => 'Inserisci un numero valido';

  @override
  String goToPageOutOfRange(int total) {
    return 'La pagina deve essere compresa tra 1 e $total';
  }

  @override
  String get menuRotateLeft => 'Ruota a sinistra';

  @override
  String get menuRotateRight => 'Ruota a destra';

  @override
  String get menuCut => 'Taglia';

  @override
  String get menuCopy => 'Copia';

  @override
  String get menuPaste => 'Incolla';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'immagini superano',
      one: 'immagine supera',
    );
    return 'Non aggiunto: $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'immagini superano',
      one: 'immagine supera',
    );
    return 'Non aggiunto: $count $_temp0 $limit pixel';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'immagini',
      one: 'immagine',
    );
    return 'Non aggiunto: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'Gli appunti non sono disponibili';

  @override
  String get pasteImageFailed =>
      'Non è stato possibile aggiungere questa immagine';

  @override
  String get menuQuit => 'Esci da PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvare le modifiche?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vuoi salvare le modifiche a $count documenti prima di chiudere?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vuoi salvare le modifiche a 1 documento prima di chiudere?';

  @override
  String get closeAllDialogSaveAll => 'Salva tutto';

  @override
  String get closeAllDialogDontSave => 'Non salvare';

  @override
  String get closeAllDialogCancel => 'Annulla';

  @override
  String get saveFailedDialogTitle => 'Salvataggio non riuscito';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Impossibile salvare $count documento(i). Chiudere comunque?';
  }

  @override
  String get saveFailedDialogClose => 'Chiudi comunque';

  @override
  String get saveChangesTitle => 'Salvare le modifiche?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vuoi salvare le modifiche in \"$fileName\" prima di chiudere?';
  }

  @override
  String get saveButton => 'Salva';

  @override
  String get discardButton => 'Non salvare';

  @override
  String get documentEdited => 'Modificato';

  @override
  String get documentSaved => 'Salvato';

  @override
  String get menuSettings => 'Impostazioni...';

  @override
  String get menuWindow => 'Finestra';

  @override
  String get menuMinimize => 'Contrai';

  @override
  String get menuZoom => 'Ridimensiona';

  @override
  String get menuBringAllToFront => 'Porta tutto in primo piano';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsLanguageSystem => 'Predefinito di sistema';

  @override
  String get settingsUnits => 'Unità';

  @override
  String get settingsUnitsCentimeters => 'Centimetri';

  @override
  String get settingsUnitsInches => 'Pollici';

  @override
  String get settingsSearchLanguages => 'Cerca lingue...';

  @override
  String get settingsGeneral => 'Generale';

  @override
  String get addImage => 'Aggiungi immagine';

  @override
  String get selectImages => 'Seleziona immagini';

  @override
  String get zoomFitWidth => 'Adatta larghezza';

  @override
  String get zoomIn => 'Ingrandisci';

  @override
  String get zoomOut => 'Riduci';

  @override
  String get selectZoomLevel => 'Seleziona livello di zoom';

  @override
  String get goToPage => 'Vai alla pagina';

  @override
  String get go => 'Vai';

  @override
  String get savePdfAs => 'Salva PDF come';

  @override
  String get incorrectPassword => 'Password errata';

  @override
  String get saveFailed => 'Salvataggio fallito';

  @override
  String savedTo(String path) {
    return 'Salvato in: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nessun PDF originale memorizzato';

  @override
  String get waitingForFolderPermission =>
      'In attesa dell\'autorizzazione di accesso alla cartella...';

  @override
  String get deleteButtonLabel => 'Elimina';

  @override
  String get deleteButtonTooltip => 'Elimina oggetto selezionato';

  @override
  String get documentProtectedTitle => 'Questo documento è protetto';

  @override
  String get documentProtectedBody => 'Inserisci la password per aprirlo.';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get openDocumentButton => 'Apri';

  @override
  String get documentReadOnlyTitle => 'Questo documento non consente modifiche';

  @override
  String get documentReadOnlyBody =>
      'Può essere letto e stampato, ma il proprietario non ne ha consentito la modifica. Inserisci la password del proprietario per modificarlo.';

  @override
  String get enterOwnerPassword => 'Inserisci la password del proprietario';

  @override
  String get ownerPasswordFieldLabel => 'Password del proprietario';

  @override
  String get menuPrint => 'Stampa…';

  @override
  String get menuPrintCurrentPage => 'Stampa la pagina corrente';

  @override
  String get printingIsTheOwnersTitle =>
      'Solo il proprietario può stampare questo documento';

  @override
  String get printingNotAllowed => 'Questo documento non consente la stampa.';

  @override
  String get printingFailed => 'Non è stato possibile stampare il documento.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Solo il proprietario può modificare la protezione di questo documento';

  @override
  String get continueButton => 'Continua';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Un documento protetto viene mostrato dalla memoria, e questo occupa $size. Aprirlo richiederà all’incirca altrettanto.';
  }

  @override
  String get shareProtectedNotice =>
      'La copia condivisa conserva la password del documento.';

  @override
  String get unsupportedProtection =>
      'La protezione di questo documento non è supportata. PDFSign apre i documenti protetti da password, non quelli protetti da un certificato.';

  @override
  String get menuBringToFront => 'Porta in primo piano';

  @override
  String get menuBringForward => 'Porta avanti';

  @override
  String get menuSendBackward => 'Porta indietro';

  @override
  String get menuSendToBack => 'Porta in fondo';

  @override
  String get zOrderGroupLabel => 'Disponi';

  @override
  String get menuUndo => 'Annulla';

  @override
  String get menuRedo => 'Ripristina';

  @override
  String get dragToReorder => 'Trascina per riordinare';

  @override
  String get protectDocumentTitle => 'Proteggi documento';

  @override
  String get requirePasswordToOpen =>
      'Richiedi una password per aprire il documento';

  @override
  String get verifyFieldLabel => 'Conferma';

  @override
  String get permissionsHeading => 'Autorizzazioni';

  @override
  String get permissionsNote =>
      'Consenti le seguenti modifiche senza inserire la password del proprietario.';

  @override
  String get permissionPrinting => 'Stampa';

  @override
  String get permissionCopying => 'Copia di testo o grafica';

  @override
  String get permissionPageAssembly =>
      'Inserimento, eliminazione o rotazione delle pagine';

  @override
  String get permissionAnnotations => 'Aggiunta di annotazioni o firme';

  @override
  String get permissionChangingContent => 'Modifica del documento';

  @override
  String get permissionFormFilling => 'Compilazione dei campi modulo esistenti';

  @override
  String get changingContentIncludes =>
      'La modifica del documento comprende le annotazioni e la compilazione dei moduli: sono consentite insieme a essa.';

  @override
  String get ownerPasswordHeading => 'Password del proprietario';

  @override
  String get removeProtection => 'Rimuovi protezione';

  @override
  String get applyButton => 'Applica';

  @override
  String get passwordsDoNotMatch => 'Le password non coincidono';

  @override
  String get passwordCannotBeEmpty => 'Inserisci una password';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Le restrizioni richiedono una password del proprietario. Senza di essa chiunque può rimuoverle.';

  @override
  String get signingNeedsChangingContent =>
      'Senza «Modifica del documento» questo file non potrà essere firmato di nuovo qui senza la password del proprietario.';

  @override
  String get menuProtectDocument => 'Proteggi documento…';

  @override
  String get protectButtonLabel => 'Proteggi';

  @override
  String get protectButtonTooltip =>
      'Imposta le password e le autorizzazioni di questo documento';
}
