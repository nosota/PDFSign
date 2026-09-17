// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get openPdf => 'Öppna PDF';

  @override
  String get selectPdf => 'Välj PDF';

  @override
  String get recentFiles => 'Senaste filer';

  @override
  String get removeFromList => 'Ta bort från listan';

  @override
  String get openedNow => 'Nyss öppnad';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minuter',
      one: 'minut',
    );
    return 'Öppnad för $count $_temp0 sedan';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'timmar',
      one: 'timme',
    );
    return 'Öppnad för $count $_temp0 sedan';
  }

  @override
  String get openedYesterday => 'Öppnad igår';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dagar',
      one: 'dag',
    );
    return 'Öppnad för $count $_temp0 sedan';
  }

  @override
  String get fileNotFound => 'Filen hittades inte';

  @override
  String get fileAccessDenied => 'Åtkomst nekad';

  @override
  String get clearRecentFiles => 'Rensa senaste filer';

  @override
  String get cancel => 'Avbryt';

  @override
  String get confirm => 'Bekräfta';

  @override
  String get error => 'Fel';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Arkiv';

  @override
  String get menuOpen => 'Öppna...';

  @override
  String get menuOpenRecent => 'Öppna senaste';

  @override
  String get menuNoRecentFiles => 'Inga senaste filer';

  @override
  String get menuClearMenu => 'Rensa menyn';

  @override
  String get menuSave => 'Spara';

  @override
  String get menuSaveAs => 'Spara som...';

  @override
  String get menuSaveAll => 'Spara alla';

  @override
  String get menuShare => 'Dela...';

  @override
  String get menuCloseWindow => 'Stäng fönster';

  @override
  String get menuCloseAll => 'Stäng alla';

  @override
  String get menuEdit => 'Redigera';

  @override
  String get menuDelete => 'Radera';

  @override
  String get menuView => 'Visa';

  @override
  String goToPagePrompt(int total) {
    return 'Ange sidnummer (1–$total):';
  }

  @override
  String get goToPageHint => 'Sidnummer';

  @override
  String get goToPageInvalid => 'Ange ett giltigt tal';

  @override
  String goToPageOutOfRange(int total) {
    return 'Sidan måste vara mellan 1 och $total';
  }

  @override
  String get menuRotateLeft => 'Rotera åt vänster';

  @override
  String get menuRotateRight => 'Rotera åt höger';

  @override
  String get menuCut => 'Klipp ut';

  @override
  String get menuCopy => 'Kopiera';

  @override
  String get menuPaste => 'Klistra in';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bilder är',
      one: 'bild är',
    );
    return 'Lades inte till: $count $_temp0 större än $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bilder är',
      one: 'bild är',
    );
    return 'Lades inte till: $count $_temp0 större än $limit pixlar';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bilder',
      one: 'bild',
    );
    return 'Lades inte till: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'Urklipp är inte tillgängligt';

  @override
  String get pasteImageFailed => 'Bilden kunde inte läggas till';

  @override
  String get menuQuit => 'Avsluta PDFSign';

  @override
  String get closeAllDialogTitle => 'Spara ändringar?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Vill du spara ändringar i $count dokument innan du stänger?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Vill du spara ändringar i 1 dokument innan du stänger?';

  @override
  String get closeAllDialogSaveAll => 'Spara alla';

  @override
  String get closeAllDialogDontSave => 'Spara inte';

  @override
  String get closeAllDialogCancel => 'Avbryt';

  @override
  String get saveFailedDialogTitle => 'Sparandet misslyckades';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Det gick inte att spara $count dokument. Stäng ändå?';
  }

  @override
  String get saveFailedDialogClose => 'Stäng ändå';

  @override
  String get saveChangesTitle => 'Spara ändringar?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Vill du spara ändringarna i \"$fileName\" innan du stänger?';
  }

  @override
  String get saveButton => 'Spara';

  @override
  String get discardButton => 'Spara inte';

  @override
  String get documentEdited => 'Redigerad';

  @override
  String get documentSaved => 'Sparad';

  @override
  String get menuSettings => 'Inställningar...';

  @override
  String get menuWindow => 'Fönster';

  @override
  String get menuMinimize => 'Minimera';

  @override
  String get menuZoom => 'Zooma';

  @override
  String get menuBringAllToFront => 'För alla framåt';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsUnits => 'Enheter';

  @override
  String get settingsUnitsCentimeters => 'Centimeter';

  @override
  String get settingsUnitsInches => 'Tum';

  @override
  String get settingsSearchLanguages => 'Sök språk...';

  @override
  String get settingsGeneral => 'Allmänt';

  @override
  String get addImage => 'Lägg till bild';

  @override
  String get selectImages => 'Välj bilder';

  @override
  String get zoomFitWidth => 'Anpassa bredd';

  @override
  String get zoomIn => 'Zooma in';

  @override
  String get zoomOut => 'Zooma ut';

  @override
  String get selectZoomLevel => 'Välj zoomnivå';

  @override
  String get goToPage => 'Gå till sida';

  @override
  String get go => 'Gå';

  @override
  String get savePdfAs => 'Spara PDF som';

  @override
  String get incorrectPassword => 'Felaktigt lösenord';

  @override
  String get saveFailed => 'Sparandet misslyckades';

  @override
  String savedTo(String path) {
    return 'Sparat till: $path';
  }

  @override
  String get noOriginalPdfStored => 'Ingen original-PDF sparad';

  @override
  String get waitingForFolderPermission =>
      'Väntar på åtkomstbehörighet för mapp...';

  @override
  String get deleteButtonLabel => 'Radera';

  @override
  String get deleteButtonTooltip => 'Radera valt objekt';

  @override
  String get documentProtectedTitle => 'Det här dokumentet är skyddat';

  @override
  String get documentProtectedBody => 'Ange lösenordet för att öppna det.';

  @override
  String get passwordFieldLabel => 'Lösenord';

  @override
  String get openDocumentButton => 'Öppna';

  @override
  String get documentReadOnlyTitle =>
      'Det här dokumentet tillåter inga ändringar';

  @override
  String get documentReadOnlyBody =>
      'Det kan läsas och skrivas ut, men ägaren har inte tillåtit ändringar. Ange ägarlösenordet för att redigera det.';

  @override
  String get enterOwnerPassword => 'Ange ägarlösenordet';

  @override
  String get ownerPasswordFieldLabel => 'Ägarlösenord';

  @override
  String get menuPrint => 'Skriv ut…';

  @override
  String get menuPrintCurrentPage => 'Skriv ut aktuell sida';

  @override
  String get printingIsTheOwnersTitle =>
      'Endast ägaren får skriva ut det här dokumentet';

  @override
  String get printingNotAllowed => 'Det här dokumentet tillåter inte utskrift.';

  @override
  String get printingFailed => 'Dokumentet kunde inte skrivas ut.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Endast ägaren får ändra skyddet för det här dokumentet';

  @override
  String get continueButton => 'Fortsätt';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Ett skyddat dokument visas från minnet, och det här är $size stort. Att öppna det använder ungefär lika mycket minne.';
  }

  @override
  String get shareProtectedNotice =>
      'Den delade kopian behåller dokumentets lösenord.';

  @override
  String get unsupportedProtection =>
      'Det här dokumentets skydd stöds inte. PDFSign öppnar lösenordsskyddade dokument, inte sådana som skyddas av ett certifikat.';

  @override
  String get menuBringToFront => 'Flytta längst fram';

  @override
  String get menuBringForward => 'Flytta framåt';

  @override
  String get menuSendBackward => 'Flytta bakåt';

  @override
  String get menuSendToBack => 'Flytta längst bak';

  @override
  String get zOrderGroupLabel => 'Ordna';

  @override
  String get menuUndo => 'Ångra';

  @override
  String get menuRedo => 'Gör om';

  @override
  String get dragToReorder => 'Dra för att ändra ordning';

  @override
  String get protectDocumentTitle => 'Skydda dokument';

  @override
  String get requirePasswordToOpen => 'Kräv lösenord för att öppna dokumentet';

  @override
  String get verifyFieldLabel => 'Bekräftelse';

  @override
  String get permissionsHeading => 'Behörigheter';

  @override
  String get permissionsNote =>
      'Tillåt följande ändringar utan att ägarlösenordet anges.';

  @override
  String get permissionPrinting => 'Utskrift';

  @override
  String get permissionCopying => 'Kopiering av text eller grafik';

  @override
  String get permissionPageAssembly =>
      'Infogning, radering och rotering av sidor';

  @override
  String get permissionAnnotations => 'Tillägg av anteckningar och signaturer';

  @override
  String get permissionChangingContent => 'Ändring av dokumentet';

  @override
  String get permissionFormFilling => 'Ifyllning av befintliga formulärfält';

  @override
  String get changingContentIncludes =>
      'Ändring av dokumentet omfattar anteckningar och ifyllning av formulär — de tillåts tillsammans med den.';

  @override
  String get ownerPasswordHeading => 'Ägarlösenord';

  @override
  String get removeProtection => 'Ta bort skydd';

  @override
  String get applyButton => 'Använd';

  @override
  String get passwordsDoNotMatch => 'Lösenorden stämmer inte överens';

  @override
  String get passwordCannotBeEmpty => 'Ange ett lösenord';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Begränsningar kräver ett ägarlösenord. Utan det kan vem som helst ta bort dem.';

  @override
  String get signingNeedsChangingContent =>
      'Utan ”Ändring av dokumentet” går den här filen inte att signera här igen utan ägarlösenordet.';

  @override
  String get menuProtectDocument => 'Skydda dokument…';

  @override
  String get protectButtonLabel => 'Skydda';

  @override
  String get protectButtonTooltip =>
      'Ange lösenord och behörigheter för det här dokumentet';
}
