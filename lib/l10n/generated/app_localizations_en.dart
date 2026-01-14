// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get openPdf => 'Open PDF';

  @override
  String get selectPdf => 'Select PDF';

  @override
  String get recentFiles => 'Recent Files';

  @override
  String get removeFromList => 'Remove from list';

  @override
  String get openedNow => 'Opened just now';

  @override
  String openedMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String openedHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hours',
      one: 'hour',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get openedYesterday => 'Opened yesterday';

  @override
  String openedDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return 'Opened $count $_temp0 ago';
  }

  @override
  String get fileNotFound => 'File not found';

  @override
  String get fileAccessDenied => 'Access denied';

  @override
  String get clearRecentFiles => 'Clear recent files';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'File';

  @override
  String get menuOpen => 'Open...';

  @override
  String get menuOpenRecent => 'Open Recent';

  @override
  String get menuNoRecentFiles => 'No Recent Files';

  @override
  String get menuClearMenu => 'Clear Menu';

  @override
  String get menuSave => 'Save';

  @override
  String get menuSaveAs => 'Save As...';

  @override
  String get menuShare => 'Share...';

  @override
  String get menuCloseWindow => 'Close Window';

  @override
  String get saveChangesTitle => 'Save Changes?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Do you want to save changes to \"$fileName\" before closing?';
  }

  @override
  String get saveButton => 'Save';

  @override
  String get discardButton => 'Discard';

  @override
  String get documentEdited => 'Edited';

  @override
  String get documentSaved => 'Saved';
}
