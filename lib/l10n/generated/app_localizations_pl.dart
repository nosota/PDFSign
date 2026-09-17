// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get openPdf => 'Otwórz PDF';

  @override
  String get selectPdf => 'Wybierz PDF';

  @override
  String get recentFiles => 'Ostatnie pliki';

  @override
  String get removeFromList => 'Usuń z listy';

  @override
  String get openedNow => 'Właśnie otwarty';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minut',
      many: 'minut',
      few: 'minuty',
      one: 'minutę',
    );
    return 'Otwarty $count $_temp0 temu';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'godzin',
      many: 'godzin',
      few: 'godziny',
      one: 'godzinę',
    );
    return 'Otwarty $count $_temp0 temu';
  }

  @override
  String get openedYesterday => 'Otwarty wczoraj';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dni',
      many: 'dni',
      few: 'dni',
      one: 'dzień',
    );
    return 'Otwarty $count $_temp0 temu';
  }

  @override
  String get fileNotFound => 'Plik nie znaleziony';

  @override
  String get fileAccessDenied => 'Odmowa dostępu';

  @override
  String get clearRecentFiles => 'Wyczyść ostatnie pliki';

  @override
  String get cancel => 'Anuluj';

  @override
  String get confirm => 'Potwierdź';

  @override
  String get error => 'Błąd';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Plik';

  @override
  String get menuOpen => 'Otwórz...';

  @override
  String get menuOpenRecent => 'Otwórz ostatnie';

  @override
  String get menuNoRecentFiles => 'Brak ostatnich plików';

  @override
  String get menuClearMenu => 'Wyczyść menu';

  @override
  String get menuSave => 'Zapisz';

  @override
  String get menuSaveAs => 'Zapisz jako...';

  @override
  String get menuSaveAll => 'Zapisz wszystko';

  @override
  String get menuShare => 'Udostępnij...';

  @override
  String get menuCloseWindow => 'Zamknij okno';

  @override
  String get menuCloseAll => 'Zamknij wszystkie';

  @override
  String get menuEdit => 'Edycja';

  @override
  String get menuDelete => 'Usuń';

  @override
  String get menuView => 'Widok';

  @override
  String goToPagePrompt(int total) {
    return 'Podaj numer strony (1–$total):';
  }

  @override
  String get goToPageHint => 'Numer strony';

  @override
  String get goToPageInvalid => 'Podaj prawidłową liczbę';

  @override
  String goToPageOutOfRange(int total) {
    return 'Strona musi mieścić się w zakresie od 1 do $total';
  }

  @override
  String get menuRotateLeft => 'Obróć w lewo';

  @override
  String get menuRotateRight => 'Obróć w prawo';

  @override
  String get menuCut => 'Wytnij';

  @override
  String get menuCopy => 'Kopiuj';

  @override
  String get menuPaste => 'Wklej';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Nie dodano obrazów: $count — przekraczają $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Nie dodano obrazów: $count — przekraczają $limit pikseli';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Nie dodano obrazów: $count';
  }

  @override
  String get clipboardUnavailable => 'Schowek jest niedostępny';

  @override
  String get pasteImageFailed => 'Nie udało się dodać tego obrazu';

  @override
  String get menuQuit => 'Zakończ PDFSign';

  @override
  String get closeAllDialogTitle => 'Zapisać zmiany?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Czy chcesz zapisać zmiany w $count dokumentach przed zamknięciem?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Czy chcesz zapisać zmiany w 1 dokumencie przed zamknięciem?';

  @override
  String get closeAllDialogSaveAll => 'Zapisz wszystkie';

  @override
  String get closeAllDialogDontSave => 'Nie zapisuj';

  @override
  String get closeAllDialogCancel => 'Anuluj';

  @override
  String get saveFailedDialogTitle => 'Zapisywanie nie powiodło się';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Nie udało się zapisać $count dokumentu(ów). Zamknąć mimo to?';
  }

  @override
  String get saveFailedDialogClose => 'Zamknij mimo to';

  @override
  String get saveChangesTitle => 'Zapisać zmiany?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Czy chcesz zapisać zmiany w \"$fileName\" przed zamknięciem?';
  }

  @override
  String get saveButton => 'Zapisz';

  @override
  String get discardButton => 'Nie zapisuj';

  @override
  String get documentEdited => 'Edytowany';

  @override
  String get documentSaved => 'Zapisany';

  @override
  String get menuSettings => 'Ustawienia...';

  @override
  String get menuWindow => 'Okno';

  @override
  String get menuMinimize => 'Minimalizuj';

  @override
  String get menuZoom => 'Powiększ';

  @override
  String get menuBringAllToFront => 'Przenieś wszystkie na wierzch';

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get settingsLanguage => 'Język';

  @override
  String get settingsLanguageSystem => 'Domyślny systemowy';

  @override
  String get settingsUnits => 'Jednostki';

  @override
  String get settingsUnitsCentimeters => 'Centymetry';

  @override
  String get settingsUnitsInches => 'Cale';

  @override
  String get settingsSearchLanguages => 'Szukaj języków...';

  @override
  String get settingsGeneral => 'Ogólne';

  @override
  String get addImage => 'Dodaj obraz';

  @override
  String get selectImages => 'Wybierz obrazy';

  @override
  String get zoomFitWidth => 'Dopasuj do szerokości';

  @override
  String get zoomIn => 'Powiększ';

  @override
  String get zoomOut => 'Pomniejsz';

  @override
  String get selectZoomLevel => 'Wybierz poziom powiększenia';

  @override
  String get goToPage => 'Przejdź do strony';

  @override
  String get go => 'Przejdź';

  @override
  String get savePdfAs => 'Zapisz PDF jako';

  @override
  String get incorrectPassword => 'Nieprawidłowe hasło';

  @override
  String get saveFailed => 'Zapisywanie nie powiodło się';

  @override
  String savedTo(String path) {
    return 'Zapisano w: $path';
  }

  @override
  String get noOriginalPdfStored => 'Brak oryginalnego PDF';

  @override
  String get waitingForFolderPermission =>
      'Oczekiwanie na uprawnienia dostępu do folderu...';

  @override
  String get deleteButtonLabel => 'Usuń';

  @override
  String get deleteButtonTooltip => 'Usuń zaznaczony obiekt';

  @override
  String get documentProtectedTitle => 'Ten dokument jest chroniony';

  @override
  String get documentProtectedBody => 'Wpisz hasło, aby go otworzyć.';

  @override
  String get passwordFieldLabel => 'Hasło';

  @override
  String get openDocumentButton => 'Otwórz';

  @override
  String get documentReadOnlyTitle => 'Ten dokument nie zezwala na zmiany';

  @override
  String get documentReadOnlyBody =>
      'Można go czytać i drukować, lecz właściciel nie zezwolił na wprowadzanie zmian. Wpisz hasło właściciela, aby go edytować.';

  @override
  String get enterOwnerPassword => 'Wpisz hasło właściciela';

  @override
  String get ownerPasswordFieldLabel => 'Hasło właściciela';

  @override
  String get menuPrint => 'Drukuj…';

  @override
  String get menuPrintCurrentPage => 'Drukuj bieżącą stronę';

  @override
  String get printingIsTheOwnersTitle =>
      'Tylko właściciel może wydrukować ten dokument';

  @override
  String get printingNotAllowed => 'Ten dokument nie zezwala na drukowanie.';

  @override
  String get printingFailed => 'Nie udało się wydrukować dokumentu.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Tylko właściciel może zmienić ochronę tego dokumentu';

  @override
  String get continueButton => 'Kontynuuj';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Chroniony dokument jest wyświetlany z pamięci, a ten zajmuje $size. Otwarcie go zużyje mniej więcej tyle samo.';
  }

  @override
  String get shareProtectedNotice =>
      'Udostępniona kopia zachowuje hasło dokumentu.';

  @override
  String get unsupportedProtection =>
      'Ochrona tego dokumentu nie jest obsługiwana. PDFSign otwiera dokumenty chronione hasłem, ale nie te chronione certyfikatem.';

  @override
  String get menuBringToFront => 'Przesuń na wierzch';

  @override
  String get menuBringForward => 'Przesuń do przodu';

  @override
  String get menuSendBackward => 'Przesuń do tyłu';

  @override
  String get menuSendToBack => 'Przesuń na spód';

  @override
  String get zOrderGroupLabel => 'Rozmieść';

  @override
  String get menuUndo => 'Cofnij';

  @override
  String get menuRedo => 'Ponów';

  @override
  String get dragToReorder => 'Przeciągnij, aby zmienić kolejność';

  @override
  String get protectDocumentTitle => 'Ochrona dokumentu';

  @override
  String get requirePasswordToOpen => 'Wymagaj hasła do otwarcia dokumentu';

  @override
  String get verifyFieldLabel => 'Potwierdzenie';

  @override
  String get permissionsHeading => 'Uprawnienia';

  @override
  String get permissionsNote =>
      'Zezwalaj na poniższe zmiany bez podawania hasła właściciela.';

  @override
  String get permissionPrinting => 'Drukowanie';

  @override
  String get permissionCopying => 'Kopiowanie tekstu lub grafiki';

  @override
  String get permissionPageAssembly => 'Wstawianie, usuwanie i obracanie stron';

  @override
  String get permissionAnnotations => 'Dodawanie adnotacji i podpisów';

  @override
  String get permissionChangingContent => 'Zmienianie dokumentu';

  @override
  String get permissionFormFilling => 'Wypełnianie istniejących pól formularzy';

  @override
  String get changingContentIncludes =>
      'Zmienianie dokumentu obejmuje adnotacje i wypełnianie formularzy — są dozwolone razem z nim.';

  @override
  String get ownerPasswordHeading => 'Hasło właściciela';

  @override
  String get removeProtection => 'Usuń ochronę';

  @override
  String get applyButton => 'Zastosuj';

  @override
  String get passwordsDoNotMatch => 'Hasła nie są zgodne';

  @override
  String get passwordCannotBeEmpty => 'Wpisz hasło';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Ograniczenia wymagają hasła właściciela. Bez niego każdy może je znieść.';

  @override
  String get signingNeedsChangingContent =>
      'Bez pozycji „Zmienianie dokumentu” tego pliku nie będzie można tu ponownie podpisać bez hasła właściciela.';

  @override
  String get menuProtectDocument => 'Chroń dokument…';

  @override
  String get protectButtonLabel => 'Ochrona';

  @override
  String get protectButtonTooltip => 'Ustaw hasła i uprawnienia tego dokumentu';
}
