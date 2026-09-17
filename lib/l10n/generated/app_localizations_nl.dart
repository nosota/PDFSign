// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get openPdf => 'PDF openen';

  @override
  String get selectPdf => 'PDF selecteren';

  @override
  String get recentFiles => 'Recente bestanden';

  @override
  String get removeFromList => 'Verwijderen uit lijst';

  @override
  String get openedNow => 'Zojuist geopend';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuten',
      one: 'minuut',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'uur',
      one: 'uur',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String get openedYesterday => 'Gisteren geopend';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dagen',
      one: 'dag',
    );
    return '$count $_temp0 geleden geopend';
  }

  @override
  String get fileNotFound => 'Bestand niet gevonden';

  @override
  String get fileAccessDenied => 'Toegang geweigerd';

  @override
  String get clearRecentFiles => 'Recente bestanden wissen';

  @override
  String get cancel => 'Annuleer';

  @override
  String get confirm => 'Bevestig';

  @override
  String get error => 'Fout';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Archief';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open recente';

  @override
  String get menuNoRecentFiles => 'Geen recente bestanden';

  @override
  String get menuClearMenu => 'Wis menu';

  @override
  String get menuSave => 'Bewaar';

  @override
  String get menuSaveAs => 'Bewaar als...';

  @override
  String get menuSaveAll => 'Alles opslaan';

  @override
  String get menuShare => 'Deel...';

  @override
  String get menuCloseWindow => 'Sluit venster';

  @override
  String get menuCloseAll => 'Alles sluiten';

  @override
  String get menuEdit => 'Bewerken';

  @override
  String get menuDelete => 'Verwijderen';

  @override
  String get menuView => 'Weergave';

  @override
  String goToPagePrompt(int total) {
    return 'Voer een paginanummer in (1–$total):';
  }

  @override
  String get goToPageHint => 'Paginanummer';

  @override
  String get goToPageInvalid => 'Voer een geldig getal in';

  @override
  String goToPageOutOfRange(int total) {
    return 'De pagina moet tussen 1 en $total liggen';
  }

  @override
  String get menuRotateLeft => 'Draai naar links';

  @override
  String get menuRotateRight => 'Draai naar rechts';

  @override
  String get menuCut => 'Knip';

  @override
  String get menuCopy => 'Kopieer';

  @override
  String get menuPaste => 'Plak';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'afbeeldingen zijn',
      one: 'afbeelding is',
    );
    return 'Niet toegevoegd: $count $_temp0 groter dan $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'afbeeldingen zijn',
      one: 'afbeelding is',
    );
    return 'Niet toegevoegd: $count $_temp0 groter dan $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'afbeeldingen',
      one: 'afbeelding',
    );
    return 'Niet toegevoegd: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'Het klembord is niet beschikbaar';

  @override
  String get pasteImageFailed => 'Die afbeelding kon niet worden toegevoegd';

  @override
  String get menuQuit => 'Stop PDFSign';

  @override
  String get closeAllDialogTitle => 'Wijzigingen opslaan?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Wilt u de wijzigingen in $count documenten opslaan voordat u sluit?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Wilt u de wijzigingen in 1 document opslaan voordat u sluit?';

  @override
  String get closeAllDialogSaveAll => 'Alles opslaan';

  @override
  String get closeAllDialogDontSave => 'Niet opslaan';

  @override
  String get closeAllDialogCancel => 'Annuleren';

  @override
  String get saveFailedDialogTitle => 'Opslaan mislukt';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Kon $count document(en) niet opslaan. Toch sluiten?';
  }

  @override
  String get saveFailedDialogClose => 'Toch sluiten';

  @override
  String get saveChangesTitle => 'Wijzigingen bewaren?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Wilt u de wijzigingen in \"$fileName\" bewaren voordat u sluit?';
  }

  @override
  String get saveButton => 'Bewaar';

  @override
  String get discardButton => 'Niet bewaren';

  @override
  String get documentEdited => 'Bewerkt';

  @override
  String get documentSaved => 'Bewaard';

  @override
  String get menuSettings => 'Instellingen...';

  @override
  String get menuWindow => 'Venster';

  @override
  String get menuMinimize => 'Minimaliseer';

  @override
  String get menuZoom => 'Zoom';

  @override
  String get menuBringAllToFront => 'Breng alles naar voren';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get settingsLanguage => 'Taal';

  @override
  String get settingsLanguageSystem => 'Systeemstandaard';

  @override
  String get settingsUnits => 'Eenheden';

  @override
  String get settingsUnitsCentimeters => 'Centimeters';

  @override
  String get settingsUnitsInches => 'Inches';

  @override
  String get settingsSearchLanguages => 'Talen zoeken...';

  @override
  String get settingsGeneral => 'Algemeen';

  @override
  String get addImage => 'Afbeelding toevoegen';

  @override
  String get selectImages => 'Afbeeldingen selecteren';

  @override
  String get zoomFitWidth => 'Breedte aanpassen';

  @override
  String get zoomIn => 'Inzoomen';

  @override
  String get zoomOut => 'Uitzoomen';

  @override
  String get selectZoomLevel => 'Zoomniveau selecteren';

  @override
  String get goToPage => 'Ga naar pagina';

  @override
  String get go => 'Ga';

  @override
  String get savePdfAs => 'PDF opslaan als';

  @override
  String get incorrectPassword => 'Onjuist wachtwoord';

  @override
  String get saveFailed => 'Opslaan mislukt';

  @override
  String savedTo(String path) {
    return 'Opgeslagen naar: $path';
  }

  @override
  String get noOriginalPdfStored => 'Geen originele PDF opgeslagen';

  @override
  String get waitingForFolderPermission =>
      'Wachten op toestemming voor maptoegang...';

  @override
  String get deleteButtonLabel => 'Verwijderen';

  @override
  String get deleteButtonTooltip => 'Geselecteerd object verwijderen';

  @override
  String get documentProtectedTitle => 'Dit document is beveiligd';

  @override
  String get documentProtectedBody =>
      'Voer het wachtwoord in om het te openen.';

  @override
  String get passwordFieldLabel => 'Wachtwoord';

  @override
  String get openDocumentButton => 'Open';

  @override
  String get documentReadOnlyTitle => 'Dit document staat geen wijzigingen toe';

  @override
  String get documentReadOnlyBody =>
      'Het kan worden gelezen en afgedrukt, maar de eigenaar heeft wijzigingen niet toegestaan. Voer het eigenaarswachtwoord in om het te bewerken.';

  @override
  String get enterOwnerPassword => 'Voer het eigenaarswachtwoord in';

  @override
  String get ownerPasswordFieldLabel => 'Eigenaarswachtwoord';

  @override
  String get menuPrint => 'Druk af…';

  @override
  String get menuPrintCurrentPage => 'Druk de huidige pagina af';

  @override
  String get printingIsTheOwnersTitle =>
      'Alleen de eigenaar mag dit document afdrukken';

  @override
  String get printingNotAllowed => 'Dit document staat afdrukken niet toe.';

  @override
  String get printingFailed => 'Het document kon niet worden afgedrukt.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Alleen de eigenaar mag de beveiliging van dit document wijzigen';

  @override
  String get continueButton => 'Ga door';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Een beveiligd document wordt vanuit het geheugen getoond, en dit document is $size groot. Het openen gebruikt ongeveer evenveel geheugen.';
  }

  @override
  String get shareProtectedNotice =>
      'De gedeelde kopie behoudt het wachtwoord van het document.';

  @override
  String get unsupportedProtection =>
      'De beveiliging van dit document wordt niet ondersteund. PDFSign opent documenten die met een wachtwoord zijn beveiligd, niet die met een certificaat.';

  @override
  String get menuBringToFront => 'Plaats vooraan';

  @override
  String get menuBringForward => 'Plaats naar voren';

  @override
  String get menuSendBackward => 'Plaats naar achteren';

  @override
  String get menuSendToBack => 'Plaats achteraan';

  @override
  String get zOrderGroupLabel => 'Schik';

  @override
  String get menuUndo => 'Herstel';

  @override
  String get menuRedo => 'Voer opnieuw uit';

  @override
  String get dragToReorder => 'Sleep om de volgorde te wijzigen';

  @override
  String get protectDocumentTitle => 'Document beveiligen';

  @override
  String get requirePasswordToOpen =>
      'Wachtwoord vereisen om het document te openen';

  @override
  String get verifyFieldLabel => 'Bevestiging';

  @override
  String get permissionsHeading => 'Bevoegdheden';

  @override
  String get permissionsNote =>
      'Sta de volgende wijzigingen toe zonder het eigenaarswachtwoord in te voeren.';

  @override
  String get permissionPrinting => 'Afdrukken';

  @override
  String get permissionCopying => 'Kopiëren van tekst of afbeeldingen';

  @override
  String get permissionPageAssembly =>
      'Invoegen, verwijderen of draaien van pagina’s';

  @override
  String get permissionAnnotations =>
      'Toevoegen van aantekeningen of handtekeningen';

  @override
  String get permissionChangingContent => 'Wijzigen van het document';

  @override
  String get permissionFormFilling => 'Invullen van bestaande formuliervelden';

  @override
  String get changingContentIncludes =>
      'Het wijzigen van het document omvat aantekeningen en het invullen van formulieren; die worden er samen mee toegestaan.';

  @override
  String get ownerPasswordHeading => 'Eigenaarswachtwoord';

  @override
  String get removeProtection => 'Beveiliging verwijderen';

  @override
  String get applyButton => 'Pas toe';

  @override
  String get passwordsDoNotMatch => 'De wachtwoorden komen niet overeen';

  @override
  String get passwordCannotBeEmpty => 'Voer een wachtwoord in';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Beperkingen vereisen een eigenaarswachtwoord. Zonder dat kan iedereen ze opheffen.';

  @override
  String get signingNeedsChangingContent =>
      'Zonder ‘Wijzigen van het document’ kan dit bestand hier niet opnieuw worden ondertekend zonder het eigenaarswachtwoord.';

  @override
  String get menuProtectDocument => 'Beveilig document…';

  @override
  String get protectButtonLabel => 'Beveilig';

  @override
  String get protectButtonTooltip =>
      'Stel de wachtwoorden en bevoegdheden van dit document in';
}
