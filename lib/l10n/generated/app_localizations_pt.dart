// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Selecionar PDF';

  @override
  String get recentFiles => 'Arquivos recentes';

  @override
  String get removeFromList => 'Remover da lista';

  @override
  String get openedNow => 'Aberto agora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get openedYesterday => 'Aberto ontem';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get fileNotFound => 'Arquivo não encontrado';

  @override
  String get fileAccessDenied => 'Acesso negado';

  @override
  String get clearRecentFiles => 'Limpar arquivos recentes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Erro';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arquivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir recentes';

  @override
  String get menuNoRecentFiles => 'Nenhum arquivo recente';

  @override
  String get menuClearMenu => 'Limpar menu';

  @override
  String get menuSave => 'Salvar';

  @override
  String get menuSaveAs => 'Salvar como...';

  @override
  String get menuSaveAll => 'Salvar tudo';

  @override
  String get menuShare => 'Compartilhar...';

  @override
  String get menuCloseWindow => 'Fechar janela';

  @override
  String get menuCloseAll => 'Fechar tudo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get menuDelete => 'Apagar';

  @override
  String get menuView => 'Visualizar';

  @override
  String goToPagePrompt(int total) {
    return 'Digite o número da página (1–$total):';
  }

  @override
  String get goToPageHint => 'Número da página';

  @override
  String get goToPageInvalid => 'Digite um número válido';

  @override
  String goToPageOutOfRange(int total) {
    return 'A página deve estar entre 1 e $total';
  }

  @override
  String get menuRotateLeft => 'Girar à esquerda';

  @override
  String get menuRotateRight => 'Girar à direita';

  @override
  String get menuCut => 'Recortar';

  @override
  String get menuCopy => 'Copiar';

  @override
  String get menuPaste => 'Colar';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens excedem',
      one: 'imagem excede',
    );
    return 'Não adicionado: $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens excedem',
      one: 'imagem excede',
    );
    return 'Não adicionado: $count $_temp0 $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens',
      one: 'imagem',
    );
    return 'Não adicionado: $count $_temp0';
  }

  @override
  String get clipboardUnavailable =>
      'A área de transferência não está disponível';

  @override
  String get pasteImageFailed => 'Não foi possível adicionar essa imagem';

  @override
  String get menuQuit => 'Sair do PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvar alterações?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Deseja salvar as alterações em $count documentos antes de fechar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Deseja salvar as alterações em 1 documento antes de fechar?';

  @override
  String get closeAllDialogSaveAll => 'Salvar tudo';

  @override
  String get closeAllDialogDontSave => 'Não salvar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Falha ao salvar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Falha ao salvar $count documento(s). Fechar mesmo assim?';
  }

  @override
  String get saveFailedDialogClose => 'Fechar mesmo assim';

  @override
  String get saveChangesTitle => 'Salvar alterações?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deseja salvar as alterações em \"$fileName\" antes de fechar?';
  }

  @override
  String get saveButton => 'Salvar';

  @override
  String get discardButton => 'Não salvar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Salvo';

  @override
  String get menuSettings => 'Configurações...';

  @override
  String get menuWindow => 'Janela';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Trazer Tudo para a Frente';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Padrão do sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Polegadas';

  @override
  String get settingsSearchLanguages => 'Pesquisar idiomas...';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get addImage => 'Adicionar imagem';

  @override
  String get selectImages => 'Selecionar imagens';

  @override
  String get zoomFitWidth => 'Ajustar largura';

  @override
  String get zoomIn => 'Aumentar zoom';

  @override
  String get zoomOut => 'Diminuir zoom';

  @override
  String get selectZoomLevel => 'Selecionar nível de zoom';

  @override
  String get goToPage => 'Ir para página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Salvar PDF como';

  @override
  String get incorrectPassword => 'Senha incorreta';

  @override
  String get saveFailed => 'Falha ao salvar';

  @override
  String savedTo(String path) {
    return 'Salvo em: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nenhum PDF original armazenado';

  @override
  String get waitingForFolderPermission =>
      'Aguardando permissão de acesso à pasta...';

  @override
  String get deleteButtonLabel => 'Excluir';

  @override
  String get deleteButtonTooltip => 'Excluir objeto selecionado';

  @override
  String get documentProtectedTitle => 'Este documento está protegido';

  @override
  String get documentProtectedBody => 'Digite a senha para abri-lo.';

  @override
  String get passwordFieldLabel => 'Senha';

  @override
  String get openDocumentButton => 'Abrir';

  @override
  String get documentReadOnlyTitle => 'Este documento não permite alterações';

  @override
  String get documentReadOnlyBody =>
      'Ele pode ser lido e impresso, mas o proprietário não permitiu alterações. Digite a senha do proprietário para editá-lo.';

  @override
  String get enterOwnerPassword => 'Digitar a senha do proprietário';

  @override
  String get ownerPasswordFieldLabel => 'Senha do proprietário';

  @override
  String get menuPrint => 'Imprimir…';

  @override
  String get menuPrintCurrentPage => 'Imprimir a página atual';

  @override
  String get printingIsTheOwnersTitle =>
      'Somente o proprietário pode imprimir este documento';

  @override
  String get printingNotAllowed => 'Este documento não permite impressão.';

  @override
  String get printingFailed => 'Não foi possível imprimir o documento.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Somente o proprietário pode alterar a proteção deste documento';

  @override
  String get continueButton => 'Continuar';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Um documento protegido é exibido a partir da memória, e este ocupa $size. Abri-lo usará aproximadamente a mesma quantidade.';
  }

  @override
  String get shareProtectedNotice =>
      'A cópia compartilhada mantém a senha do documento.';

  @override
  String get unsupportedProtection =>
      'A proteção deste documento não é compatível. O PDFSign abre documentos protegidos por senha, não os protegidos por certificado.';

  @override
  String get menuBringToFront => 'Trazer para a frente';

  @override
  String get menuBringForward => 'Avançar';

  @override
  String get menuSendBackward => 'Recuar';

  @override
  String get menuSendToBack => 'Enviar para trás';

  @override
  String get zOrderGroupLabel => 'Organizar';

  @override
  String get menuUndo => 'Desfazer';

  @override
  String get menuRedo => 'Refazer';

  @override
  String get dragToReorder => 'Arraste para reordenar';

  @override
  String get protectDocumentTitle => 'Proteger documento';

  @override
  String get requirePasswordToOpen => 'Exigir senha para abrir o documento';

  @override
  String get verifyFieldLabel => 'Confirmação';

  @override
  String get permissionsHeading => 'Permissões';

  @override
  String get permissionsNote =>
      'Permitir as alterações a seguir sem digitar a senha do proprietário.';

  @override
  String get permissionPrinting => 'Impressão';

  @override
  String get permissionCopying => 'Cópia de texto ou gráficos';

  @override
  String get permissionPageAssembly =>
      'Inserção, exclusão ou rotação de páginas';

  @override
  String get permissionAnnotations => 'Adição de anotações ou assinaturas';

  @override
  String get permissionChangingContent => 'Alteração do documento';

  @override
  String get permissionFormFilling =>
      'Preenchimento de campos de formulário existentes';

  @override
  String get changingContentIncludes =>
      'A alteração do documento inclui anotar e preencher formulários: ambos são permitidos junto com ela.';

  @override
  String get ownerPasswordHeading => 'Senha do proprietário';

  @override
  String get removeProtection => 'Remover proteção';

  @override
  String get applyButton => 'Aplicar';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get passwordCannotBeEmpty => 'Digite uma senha';

  @override
  String get restrictionsNeedOwnerPassword =>
      'As restrições exigem uma senha do proprietário. Sem ela, qualquer pessoa pode removê-las.';

  @override
  String get signingNeedsChangingContent =>
      'Sem «Alteração do documento», este arquivo não poderá ser assinado aqui novamente sem a senha do proprietário.';

  @override
  String get menuProtectDocument => 'Proteger documento…';

  @override
  String get protectButtonLabel => 'Proteger';

  @override
  String get protectButtonTooltip =>
      'Definir as senhas e permissões deste documento';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Selecionar PDF';

  @override
  String get recentFiles => 'Arquivos recentes';

  @override
  String get removeFromList => 'Remover da lista';

  @override
  String get openedNow => 'Aberto agora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get openedYesterday => 'Aberto ontem';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get fileNotFound => 'Arquivo não encontrado';

  @override
  String get fileAccessDenied => 'Acesso negado';

  @override
  String get clearRecentFiles => 'Limpar arquivos recentes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Erro';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arquivo';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir recentes';

  @override
  String get menuNoRecentFiles => 'Nenhum arquivo recente';

  @override
  String get menuClearMenu => 'Limpar menu';

  @override
  String get menuSave => 'Salvar';

  @override
  String get menuSaveAs => 'Salvar como...';

  @override
  String get menuSaveAll => 'Salvar tudo';

  @override
  String get menuShare => 'Compartilhar...';

  @override
  String get menuCloseWindow => 'Fechar janela';

  @override
  String get menuCloseAll => 'Fechar tudo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get menuDelete => 'Excluir';

  @override
  String get menuView => 'Visualizar';

  @override
  String goToPagePrompt(int total) {
    return 'Digite o número da página (1–$total):';
  }

  @override
  String get goToPageHint => 'Número da página';

  @override
  String get goToPageInvalid => 'Digite um número válido';

  @override
  String goToPageOutOfRange(int total) {
    return 'A página deve estar entre 1 e $total';
  }

  @override
  String get menuRotateLeft => 'Girar à esquerda';

  @override
  String get menuRotateRight => 'Girar à direita';

  @override
  String get menuCut => 'Recortar';

  @override
  String get menuCopy => 'Copiar';

  @override
  String get menuPaste => 'Colar';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens excedem',
      one: 'imagem excede',
    );
    return 'Não adicionado: $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens excedem',
      one: 'imagem excede',
    );
    return 'Não adicionado: $count $_temp0 $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens',
      one: 'imagem',
    );
    return 'Não adicionado: $count $_temp0';
  }

  @override
  String get clipboardUnavailable =>
      'A área de transferência não está disponível';

  @override
  String get pasteImageFailed => 'Não foi possível adicionar essa imagem';

  @override
  String get menuQuit => 'Sair do PDFSign';

  @override
  String get closeAllDialogTitle => 'Salvar alterações?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Deseja salvar as alterações em $count documentos antes de fechar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Deseja salvar as alterações em 1 documento antes de fechar?';

  @override
  String get closeAllDialogSaveAll => 'Salvar tudo';

  @override
  String get closeAllDialogDontSave => 'Não salvar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Falha ao salvar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Falha ao salvar $count documento(s). Fechar mesmo assim?';
  }

  @override
  String get saveFailedDialogClose => 'Fechar mesmo assim';

  @override
  String get saveChangesTitle => 'Salvar alterações?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deseja salvar as alterações em \"$fileName\" antes de fechar?';
  }

  @override
  String get saveButton => 'Salvar';

  @override
  String get discardButton => 'Não salvar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Salvo';

  @override
  String get menuSettings => 'Configurações...';

  @override
  String get menuWindow => 'Janela';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Trazer Tudo para a Frente';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Padrão do sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Polegadas';

  @override
  String get settingsSearchLanguages => 'Pesquisar idiomas...';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get addImage => 'Adicionar imagem';

  @override
  String get selectImages => 'Selecionar imagens';

  @override
  String get zoomFitWidth => 'Ajustar largura';

  @override
  String get zoomIn => 'Aumentar zoom';

  @override
  String get zoomOut => 'Diminuir zoom';

  @override
  String get selectZoomLevel => 'Selecionar nível de zoom';

  @override
  String get goToPage => 'Ir para página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Salvar PDF como';

  @override
  String get incorrectPassword => 'Senha incorreta';

  @override
  String get saveFailed => 'Falha ao salvar';

  @override
  String savedTo(String path) {
    return 'Salvo em: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nenhum PDF original armazenado';

  @override
  String get waitingForFolderPermission =>
      'Aguardando permissão de acesso à pasta...';

  @override
  String get deleteButtonLabel => 'Excluir';

  @override
  String get deleteButtonTooltip => 'Excluir objeto selecionado';

  @override
  String get documentProtectedTitle => 'Este documento está protegido';

  @override
  String get documentProtectedBody => 'Digite a senha para abri-lo.';

  @override
  String get passwordFieldLabel => 'Senha';

  @override
  String get openDocumentButton => 'Abrir';

  @override
  String get documentReadOnlyTitle => 'Este documento não permite alterações';

  @override
  String get documentReadOnlyBody =>
      'Ele pode ser lido e impresso, mas o proprietário não permitiu alterações. Digite a senha do proprietário para editá-lo.';

  @override
  String get enterOwnerPassword => 'Digitar a senha do proprietário';

  @override
  String get ownerPasswordFieldLabel => 'Senha do proprietário';

  @override
  String get menuPrint => 'Imprimir…';

  @override
  String get menuPrintCurrentPage => 'Imprimir a página atual';

  @override
  String get printingIsTheOwnersTitle =>
      'Somente o proprietário pode imprimir este documento';

  @override
  String get printingNotAllowed => 'Este documento não permite impressão.';

  @override
  String get printingFailed => 'Não foi possível imprimir o documento.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Somente o proprietário pode alterar a proteção deste documento';

  @override
  String get continueButton => 'Continuar';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Um documento protegido é exibido a partir da memória, e este ocupa $size. Abri-lo usará aproximadamente a mesma quantidade.';
  }

  @override
  String get shareProtectedNotice =>
      'A cópia compartilhada mantém a senha do documento.';

  @override
  String get unsupportedProtection =>
      'A proteção deste documento não é compatível. O PDFSign abre documentos protegidos por senha, não os protegidos por certificado.';

  @override
  String get menuBringToFront => 'Trazer para a frente';

  @override
  String get menuBringForward => 'Avançar';

  @override
  String get menuSendBackward => 'Recuar';

  @override
  String get menuSendToBack => 'Enviar para trás';

  @override
  String get zOrderGroupLabel => 'Organizar';

  @override
  String get menuUndo => 'Desfazer';

  @override
  String get menuRedo => 'Refazer';

  @override
  String get dragToReorder => 'Arraste para reordenar';

  @override
  String get protectDocumentTitle => 'Proteger documento';

  @override
  String get requirePasswordToOpen => 'Exigir senha para abrir o documento';

  @override
  String get verifyFieldLabel => 'Confirmação';

  @override
  String get permissionsHeading => 'Permissões';

  @override
  String get permissionsNote =>
      'Permitir as alterações a seguir sem digitar a senha do proprietário.';

  @override
  String get permissionPrinting => 'Impressão';

  @override
  String get permissionCopying => 'Cópia de texto ou gráficos';

  @override
  String get permissionPageAssembly =>
      'Inserção, exclusão ou rotação de páginas';

  @override
  String get permissionAnnotations => 'Adição de anotações ou assinaturas';

  @override
  String get permissionChangingContent => 'Alteração do documento';

  @override
  String get permissionFormFilling =>
      'Preenchimento de campos de formulário existentes';

  @override
  String get changingContentIncludes =>
      'A alteração do documento inclui anotar e preencher formulários: ambos são permitidos junto com ela.';

  @override
  String get ownerPasswordHeading => 'Senha do proprietário';

  @override
  String get removeProtection => 'Remover proteção';

  @override
  String get applyButton => 'Aplicar';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get passwordCannotBeEmpty => 'Digite uma senha';

  @override
  String get restrictionsNeedOwnerPassword =>
      'As restrições exigem uma senha do proprietário. Sem ela, qualquer pessoa pode removê-las.';

  @override
  String get signingNeedsChangingContent =>
      'Sem «Alteração do documento», este arquivo não poderá ser assinado aqui novamente sem a senha do proprietário.';

  @override
  String get menuProtectDocument => 'Proteger documento…';

  @override
  String get protectButtonLabel => 'Proteger';

  @override
  String get protectButtonTooltip =>
      'Definir as senhas e permissões deste documento';
}

/// The translations for Portuguese, as used in Portugal (`pt_PT`).
class AppLocalizationsPtPt extends AppLocalizationsPt {
  AppLocalizationsPtPt() : super('pt_PT');

  @override
  String get openPdf => 'Abrir PDF';

  @override
  String get selectPdf => 'Selecionar PDF';

  @override
  String get recentFiles => 'Ficheiros recentes';

  @override
  String get removeFromList => 'Remover da lista';

  @override
  String get openedNow => 'Aberto agora';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutos',
      one: 'minuto',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'horas',
      one: 'hora',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get openedYesterday => 'Aberto ontem';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dias',
      one: 'dia',
    );
    return 'Aberto há $count $_temp0';
  }

  @override
  String get fileNotFound => 'Ficheiro não encontrado';

  @override
  String get fileAccessDenied => 'Acesso negado';

  @override
  String get clearRecentFiles => 'Limpar ficheiros recentes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get error => 'Erro';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Ficheiro';

  @override
  String get menuOpen => 'Abrir...';

  @override
  String get menuOpenRecent => 'Abrir recentes';

  @override
  String get menuNoRecentFiles => 'Sem ficheiros recentes';

  @override
  String get menuClearMenu => 'Limpar menu';

  @override
  String get menuSave => 'Guardar';

  @override
  String get menuSaveAs => 'Guardar como...';

  @override
  String get menuSaveAll => 'Salvar tudo';

  @override
  String get menuShare => 'Partilhar...';

  @override
  String get menuCloseWindow => 'Fechar janela';

  @override
  String get menuCloseAll => 'Fechar tudo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get menuDelete => 'Apagar';

  @override
  String get menuView => 'Visualizar';

  @override
  String goToPagePrompt(int total) {
    return 'Introduza o número da página (1–$total):';
  }

  @override
  String get goToPageHint => 'Número da página';

  @override
  String get goToPageInvalid => 'Introduza um número válido';

  @override
  String goToPageOutOfRange(int total) {
    return 'A página deve estar entre 1 e $total';
  }

  @override
  String get menuRotateLeft => 'Rodar à esquerda';

  @override
  String get menuRotateRight => 'Rodar à direita';

  @override
  String get menuCut => 'Recortar';

  @override
  String get menuCopy => 'Copiar';

  @override
  String get menuPaste => 'Colar';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens excedem',
      one: 'imagem excede',
    );
    return 'Não adicionado: $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens excedem',
      one: 'imagem excede',
    );
    return 'Não adicionado: $count $_temp0 $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'imagens',
      one: 'imagem',
    );
    return 'Não adicionado: $count $_temp0';
  }

  @override
  String get clipboardUnavailable =>
      'A área de transferência não está disponível';

  @override
  String get pasteImageFailed => 'Não foi possível adicionar essa imagem';

  @override
  String get menuQuit => 'Sair do PDFSign';

  @override
  String get closeAllDialogTitle => 'Guardar alterações?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Deseja guardar as alterações em $count documentos antes de fechar?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Deseja guardar as alterações em 1 documento antes de fechar?';

  @override
  String get closeAllDialogSaveAll => 'Guardar tudo';

  @override
  String get closeAllDialogDontSave => 'Não guardar';

  @override
  String get closeAllDialogCancel => 'Cancelar';

  @override
  String get saveFailedDialogTitle => 'Falha ao salvar';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Falha ao salvar $count documento(s). Fechar mesmo assim?';
  }

  @override
  String get saveFailedDialogClose => 'Fechar mesmo assim';

  @override
  String get saveChangesTitle => 'Guardar alterações?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Deseja guardar as alterações em \"$fileName\" antes de fechar?';
  }

  @override
  String get saveButton => 'Guardar';

  @override
  String get discardButton => 'Não guardar';

  @override
  String get documentEdited => 'Editado';

  @override
  String get documentSaved => 'Guardado';

  @override
  String get menuSettings => 'Definições...';

  @override
  String get menuWindow => 'Janela';

  @override
  String get menuMinimize => 'Minimizar';

  @override
  String get menuZoom => 'Ampliação';

  @override
  String get menuBringAllToFront => 'Trazer Tudo para a Frente';

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predefinição do sistema';

  @override
  String get settingsUnits => 'Unidades';

  @override
  String get settingsUnitsCentimeters => 'Centímetros';

  @override
  String get settingsUnitsInches => 'Polegadas';

  @override
  String get settingsSearchLanguages => 'Pesquisar idiomas...';

  @override
  String get settingsGeneral => 'Geral';

  @override
  String get addImage => 'Adicionar imagem';

  @override
  String get selectImages => 'Selecionar imagens';

  @override
  String get zoomFitWidth => 'Ajustar largura';

  @override
  String get zoomIn => 'Aumentar';

  @override
  String get zoomOut => 'Diminuir';

  @override
  String get selectZoomLevel => 'Selecionar nível de zoom';

  @override
  String get goToPage => 'Ir para página';

  @override
  String get go => 'Ir';

  @override
  String get savePdfAs => 'Guardar PDF como';

  @override
  String get incorrectPassword => 'Palavra-passe incorreta';

  @override
  String get saveFailed => 'Falha ao guardar';

  @override
  String savedTo(String path) {
    return 'Guardado em: $path';
  }

  @override
  String get noOriginalPdfStored => 'Nenhum PDF original armazenado';

  @override
  String get waitingForFolderPermission =>
      'Aguardando permissão de acesso à pasta...';

  @override
  String get deleteButtonLabel => 'Eliminar';

  @override
  String get deleteButtonTooltip => 'Eliminar objeto selecionado';

  @override
  String get documentProtectedTitle => 'Este documento está protegido';

  @override
  String get documentProtectedBody => 'Introduza a palavra-passe para abri-lo.';

  @override
  String get passwordFieldLabel => 'Palavra-passe';

  @override
  String get openDocumentButton => 'Abrir';

  @override
  String get documentReadOnlyTitle => 'Este documento não permite alterações';

  @override
  String get documentReadOnlyBody =>
      'Ele pode ser lido e impresso, mas o proprietário não permitiu alterações. Introduza a palavra-passe do proprietário para editá-lo.';

  @override
  String get enterOwnerPassword => 'Digitar a palavra-passe do proprietário';

  @override
  String get ownerPasswordFieldLabel => 'Palavra-passe do proprietário';

  @override
  String get menuPrint => 'Imprimir…';

  @override
  String get menuPrintCurrentPage => 'Imprimir a página atual';

  @override
  String get printingIsTheOwnersTitle =>
      'Apenas o proprietário pode imprimir este documento';

  @override
  String get printingNotAllowed => 'Este documento não permite impressão.';

  @override
  String get printingFailed => 'Não foi possível imprimir o documento.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Apenas o proprietário pode alterar a proteção deste documento';

  @override
  String get continueButton => 'Continuar';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Um documento protegido é exibido a partir da memória, e este ocupa $size. Abri-lo usará aproximadamente a mesma quantidade.';
  }

  @override
  String get shareProtectedNotice =>
      'A cópia partilhada mantém a palavra-passe do documento.';

  @override
  String get unsupportedProtection =>
      'A proteção deste documento não é compatível. O PDFSign abre documentos protegidos por palavra-passe, não os protegidos por certificado.';

  @override
  String get menuBringToFront => 'Trazer para a frente';

  @override
  String get menuBringForward => 'Avançar';

  @override
  String get menuSendBackward => 'Recuar';

  @override
  String get menuSendToBack => 'Enviar para trás';

  @override
  String get zOrderGroupLabel => 'Organizar';

  @override
  String get menuUndo => 'Desfazer';

  @override
  String get menuRedo => 'Refazer';

  @override
  String get dragToReorder => 'Arraste para reordenar';

  @override
  String get protectDocumentTitle => 'Proteger documento';

  @override
  String get requirePasswordToOpen =>
      'Exigir palavra-passe para abrir o documento';

  @override
  String get verifyFieldLabel => 'Confirmação';

  @override
  String get permissionsHeading => 'Permissões';

  @override
  String get permissionsNote =>
      'Permitir as alterações a seguir sem introduzir a palavra-passe do proprietário.';

  @override
  String get permissionPrinting => 'Impressão';

  @override
  String get permissionCopying => 'Cópia de texto ou gráficos';

  @override
  String get permissionPageAssembly =>
      'Inserção, eliminação ou rotação de páginas';

  @override
  String get permissionAnnotations => 'Adição de anotações ou assinaturas';

  @override
  String get permissionChangingContent => 'Alteração do documento';

  @override
  String get permissionFormFilling =>
      'Preenchimento de campos de formulário existentes';

  @override
  String get changingContentIncludes =>
      'A alteração do documento inclui anotar e preencher formulários: ambos são permitidos junto com ela.';

  @override
  String get ownerPasswordHeading => 'Palavra-passe do proprietário';

  @override
  String get removeProtection => 'Remover proteção';

  @override
  String get applyButton => 'Aplicar';

  @override
  String get passwordsDoNotMatch => 'As palavra-passes não coincidem';

  @override
  String get passwordCannotBeEmpty => 'Introduza uma palavra-passe';

  @override
  String get restrictionsNeedOwnerPassword =>
      'As restrições exigem uma palavra-passe do proprietário. Sem ela, qualquer pessoa pode removê-las.';

  @override
  String get signingNeedsChangingContent =>
      'Sem «Alteração do documento», este ficheiro não poderá ser assinado aqui novamente sem a palavra-passe do proprietário.';

  @override
  String get menuProtectDocument => 'Proteger documento…';

  @override
  String get protectButtonLabel => 'Proteger';

  @override
  String get protectButtonTooltip =>
      'Definir as palavra-passes e permissões deste documento';
}
