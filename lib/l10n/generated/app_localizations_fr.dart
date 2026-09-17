// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get openPdf => 'Ouvrir PDF';

  @override
  String get selectPdf => 'Sélectionner PDF';

  @override
  String get recentFiles => 'Fichiers récents';

  @override
  String get removeFromList => 'Supprimer de la liste';

  @override
  String get openedNow => 'Ouvert à l\'instant';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Ouvert il y a $count $_temp0';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'heures',
      one: 'heure',
    );
    return 'Ouvert il y a $count $_temp0';
  }

  @override
  String get openedYesterday => 'Ouvert hier';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'jours',
      one: 'jour',
    );
    return 'Ouvert il y a $count $_temp0';
  }

  @override
  String get fileNotFound => 'Fichier introuvable';

  @override
  String get fileAccessDenied => 'Accès refusé';

  @override
  String get clearRecentFiles => 'Effacer les fichiers récents';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get error => 'Erreur';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Fichier';

  @override
  String get menuOpen => 'Ouvrir...';

  @override
  String get menuOpenRecent => 'Ouvrir récent';

  @override
  String get menuNoRecentFiles => 'Aucun fichier récent';

  @override
  String get menuClearMenu => 'Effacer le menu';

  @override
  String get menuSave => 'Enregistrer';

  @override
  String get menuSaveAs => 'Enregistrer sous...';

  @override
  String get menuSaveAll => 'Tout enregistrer';

  @override
  String get menuShare => 'Partager...';

  @override
  String get menuCloseWindow => 'Fermer la fenêtre';

  @override
  String get menuCloseAll => 'Tout fermer';

  @override
  String get menuEdit => 'Édition';

  @override
  String get menuDelete => 'Supprimer';

  @override
  String get menuView => 'Présentation';

  @override
  String goToPagePrompt(int total) {
    return 'Saisissez un numéro de page (1–$total) :';
  }

  @override
  String get goToPageHint => 'Numéro de page';

  @override
  String get goToPageInvalid => 'Saisissez un nombre valide';

  @override
  String goToPageOutOfRange(int total) {
    return 'La page doit être comprise entre 1 et $total';
  }

  @override
  String get menuRotateLeft => 'Pivoter vers la gauche';

  @override
  String get menuRotateRight => 'Pivoter vers la droite';

  @override
  String get menuCut => 'Couper';

  @override
  String get menuCopy => 'Copier';

  @override
  String get menuPaste => 'Coller';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images dépassent',
      one: 'image dépasse',
    );
    return 'Non ajouté : $count $_temp0 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images dépassent',
      one: 'image dépasse',
    );
    return 'Non ajouté : $count $_temp0 $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Non ajouté : $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'Le presse-papiers n’est pas disponible';

  @override
  String get pasteImageFailed => 'Cette image n’a pas pu être ajoutée';

  @override
  String get menuQuit => 'Quitter PDFSign';

  @override
  String get closeAllDialogTitle => 'Enregistrer les modifications ?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Voulez-vous enregistrer les modifications de $count documents avant de fermer ?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Voulez-vous enregistrer les modifications de 1 document avant de fermer ?';

  @override
  String get closeAllDialogSaveAll => 'Tout enregistrer';

  @override
  String get closeAllDialogDontSave => 'Ne pas enregistrer';

  @override
  String get closeAllDialogCancel => 'Annuler';

  @override
  String get saveFailedDialogTitle => 'Échec de l\'enregistrement';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Échec de l\'enregistrement de $count document(s). Fermer quand même ?';
  }

  @override
  String get saveFailedDialogClose => 'Fermer quand même';

  @override
  String get saveChangesTitle => 'Enregistrer les modifications?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Voulez-vous enregistrer les modifications apportées à \"$fileName\" avant de fermer?';
  }

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get discardButton => 'Ne pas enregistrer';

  @override
  String get documentEdited => 'Modifié';

  @override
  String get documentSaved => 'Enregistré';

  @override
  String get menuSettings => 'Réglages...';

  @override
  String get menuWindow => 'Fenêtre';

  @override
  String get menuMinimize => 'Réduire';

  @override
  String get menuZoom => 'Réduire/agrandir';

  @override
  String get menuBringAllToFront => 'Tout ramener au premier plan';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSystem => 'Par défaut du système';

  @override
  String get settingsUnits => 'Unités';

  @override
  String get settingsUnitsCentimeters => 'Centimètres';

  @override
  String get settingsUnitsInches => 'Pouces';

  @override
  String get settingsSearchLanguages => 'Rechercher des langues...';

  @override
  String get settingsGeneral => 'Général';

  @override
  String get addImage => 'Ajouter une image';

  @override
  String get selectImages => 'Sélectionner des images';

  @override
  String get zoomFitWidth => 'Ajuster à la largeur';

  @override
  String get zoomIn => 'Zoom avant';

  @override
  String get zoomOut => 'Zoom arrière';

  @override
  String get selectZoomLevel => 'Sélectionner le niveau de zoom';

  @override
  String get goToPage => 'Aller à la page';

  @override
  String get go => 'Aller';

  @override
  String get savePdfAs => 'Enregistrer le PDF sous';

  @override
  String get incorrectPassword => 'Mot de passe incorrect';

  @override
  String get saveFailed => 'Échec de l\'enregistrement';

  @override
  String savedTo(String path) {
    return 'Enregistré dans : $path';
  }

  @override
  String get noOriginalPdfStored => 'Aucun PDF original stocké';

  @override
  String get waitingForFolderPermission =>
      'En attente de l\'autorisation d\'accès au dossier...';

  @override
  String get deleteButtonLabel => 'Supprimer';

  @override
  String get deleteButtonTooltip => 'Supprimer l\'objet sélectionné';

  @override
  String get documentProtectedTitle => 'Ce document est protégé';

  @override
  String get documentProtectedBody =>
      'Saisissez son mot de passe pour l’ouvrir.';

  @override
  String get passwordFieldLabel => 'Mot de passe';

  @override
  String get openDocumentButton => 'Ouvrir';

  @override
  String get documentReadOnlyTitle =>
      'Ce document n’autorise aucune modification';

  @override
  String get documentReadOnlyBody =>
      'Il peut être lu et imprimé, mais son propriétaire n’a pas autorisé les modifications. Saisissez le mot de passe du propriétaire pour le modifier.';

  @override
  String get enterOwnerPassword => 'Saisir le mot de passe du propriétaire';

  @override
  String get ownerPasswordFieldLabel => 'Mot de passe du propriétaire';

  @override
  String get menuPrint => 'Imprimer…';

  @override
  String get menuPrintCurrentPage => 'Imprimer la page actuelle';

  @override
  String get printingIsTheOwnersTitle =>
      'Seul le propriétaire peut imprimer ce document';

  @override
  String get printingNotAllowed => 'Ce document n’autorise pas l’impression.';

  @override
  String get printingFailed => 'Le document n’a pas pu être imprimé.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Seul le propriétaire peut modifier la protection de ce document';

  @override
  String get continueButton => 'Continuer';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Un document protégé est affiché depuis la mémoire, et celui-ci occupe $size. Son ouverture en utilisera à peu près autant.';
  }

  @override
  String get shareProtectedNotice =>
      'La copie partagée conserve le mot de passe du document.';

  @override
  String get unsupportedProtection =>
      'La protection de ce document n’est pas prise en charge. PDFSign ouvre les documents protégés par mot de passe, mais pas ceux protégés par un certificat.';

  @override
  String get menuBringToFront => 'Mettre au premier plan';

  @override
  String get menuBringForward => 'Avancer d’un plan';

  @override
  String get menuSendBackward => 'Reculer d’un plan';

  @override
  String get menuSendToBack => 'Mettre à l’arrière-plan';

  @override
  String get zOrderGroupLabel => 'Disposition';

  @override
  String get menuUndo => 'Annuler';

  @override
  String get menuRedo => 'Rétablir';

  @override
  String get dragToReorder => 'Faites glisser pour réorganiser';

  @override
  String get protectDocumentTitle => 'Protéger le document';

  @override
  String get requirePasswordToOpen =>
      'Exiger un mot de passe pour ouvrir le document';

  @override
  String get verifyFieldLabel => 'Confirmation';

  @override
  String get permissionsHeading => 'Autorisations';

  @override
  String get permissionsNote =>
      'Autoriser les modifications suivantes sans saisir le mot de passe du propriétaire.';

  @override
  String get permissionPrinting => 'Impression';

  @override
  String get permissionCopying => 'Copie de texte ou de graphiques';

  @override
  String get permissionPageAssembly =>
      'Insertion, suppression ou rotation de pages';

  @override
  String get permissionAnnotations => 'Ajout d’annotations ou de signatures';

  @override
  String get permissionChangingContent => 'Modification du document';

  @override
  String get permissionFormFilling =>
      'Remplissage des champs de formulaire existants';

  @override
  String get changingContentIncludes =>
      'La modification du document comprend les annotations et le remplissage des formulaires : ils sont autorisés avec elle.';

  @override
  String get ownerPasswordHeading => 'Mot de passe du propriétaire';

  @override
  String get removeProtection => 'Supprimer la protection';

  @override
  String get applyButton => 'Appliquer';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get passwordCannotBeEmpty => 'Saisissez un mot de passe';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Les restrictions exigent un mot de passe du propriétaire. Sans lui, n’importe qui peut les lever.';

  @override
  String get signingNeedsChangingContent =>
      'Sans « Modification du document », ce fichier ne pourra plus être signé ici sans le mot de passe du propriétaire.';

  @override
  String get menuProtectDocument => 'Protéger le document…';

  @override
  String get protectButtonLabel => 'Protéger';

  @override
  String get protectButtonTooltip =>
      'Définir les mots de passe et les autorisations de ce document';
}
