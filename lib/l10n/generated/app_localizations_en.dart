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
}
