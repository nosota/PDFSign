// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get openPdf => 'PDFを開く';

  @override
  String get selectPdf => 'PDFを選択';

  @override
  String get recentFiles => '最近使ったファイル';

  @override
  String get removeFromList => 'リストから削除';

  @override
  String get openedNow => '今開いた';

  @override
  String openedMinutesAgo(int count) {
    return '$count分前に開いた';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count時間前に開いた';
  }

  @override
  String get openedYesterday => '昨日開いた';

  @override
  String openedDaysAgo(int count) {
    return '$count日前に開いた';
  }

  @override
  String get fileNotFound => 'ファイルが見つかりません';

  @override
  String get fileAccessDenied => 'アクセスが拒否されました';

  @override
  String get clearRecentFiles => '最近使ったファイルを消去';

  @override
  String get cancel => 'キャンセル';

  @override
  String get confirm => '確認';

  @override
  String get error => 'エラー';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'ファイル';

  @override
  String get menuOpen => '開く...';

  @override
  String get menuOpenRecent => '最近使った項目を開く';

  @override
  String get menuNoRecentFiles => '最近使ったファイルはありません';

  @override
  String get menuClearMenu => 'メニューを消去';

  @override
  String get menuSave => '保存';

  @override
  String get menuSaveAs => '別名で保存...';

  @override
  String get menuShare => '共有...';

  @override
  String get menuCloseWindow => 'ウインドウを閉じる';

  @override
  String get saveChangesTitle => '変更を保存しますか？';

  @override
  String saveChangesMessage(String fileName) {
    return '閉じる前に\"$fileName\"への変更を保存しますか？';
  }

  @override
  String get saveButton => '保存';

  @override
  String get discardButton => '保存しない';

  @override
  String get documentEdited => '編集済み';

  @override
  String get documentSaved => '保存済み';

  @override
  String get menuSettings => '設定...';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageSystem => 'システムデフォルト';

  @override
  String get settingsUnits => '単位';

  @override
  String get settingsUnitsCentimeters => 'センチメートル';

  @override
  String get settingsUnitsInches => 'インチ';

  @override
  String get settingsSearchLanguages => '言語を検索...';

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
