// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get openPdf => '打开 PDF';

  @override
  String get selectPdf => '选择 PDF';

  @override
  String get recentFiles => '最近文件';

  @override
  String get removeFromList => '从列表中移除';

  @override
  String get openedNow => '刚刚打开';

  @override
  String openedMinutesAgo(int count) {
    return '$count分钟前打开';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count小时前打开';
  }

  @override
  String get openedYesterday => '昨天打开';

  @override
  String openedDaysAgo(int count) {
    return '$count天前打开';
  }

  @override
  String get fileNotFound => '文件未找到';

  @override
  String get fileAccessDenied => '访问被拒绝';

  @override
  String get clearRecentFiles => '清除最近文件';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get error => '错误';

  @override
  String get ok => '好';

  @override
  String get menuFile => '文件';

  @override
  String get menuOpen => '打开...';

  @override
  String get menuOpenRecent => '打开最近';

  @override
  String get menuNoRecentFiles => '没有最近文件';

  @override
  String get menuClearMenu => '清除菜单';

  @override
  String get menuSave => '保存';

  @override
  String get menuSaveAs => '另存为...';

  @override
  String get menuShare => '共享...';

  @override
  String get menuCloseWindow => '关闭窗口';

  @override
  String get saveChangesTitle => '保存更改？';

  @override
  String saveChangesMessage(String fileName) {
    return '关闭前是否要保存对「$fileName」的更改？';
  }

  @override
  String get saveButton => '保存';

  @override
  String get discardButton => '不保存';

  @override
  String get documentEdited => '已编辑';

  @override
  String get documentSaved => '已保存';

  @override
  String get menuSettings => '设置...';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsLanguageSystem => '系统默认';

  @override
  String get settingsUnits => '单位';

  @override
  String get settingsUnitsCentimeters => '厘米';

  @override
  String get settingsUnitsInches => '英寸';

  @override
  String get settingsSearchLanguages => '搜索语言...';

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

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get openPdf => '打开 PDF';

  @override
  String get selectPdf => '选择 PDF';

  @override
  String get recentFiles => '最近文件';

  @override
  String get removeFromList => '从列表中移除';

  @override
  String get openedNow => '刚刚打开';

  @override
  String openedMinutesAgo(int count) {
    return '$count分钟前打开';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count小时前打开';
  }

  @override
  String get openedYesterday => '昨天打开';

  @override
  String openedDaysAgo(int count) {
    return '$count天前打开';
  }

  @override
  String get fileNotFound => '文件未找到';

  @override
  String get fileAccessDenied => '访问被拒绝';

  @override
  String get clearRecentFiles => '清除最近文件';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '确认';

  @override
  String get error => '错误';

  @override
  String get ok => '好';

  @override
  String get menuFile => '文件';

  @override
  String get menuOpen => '打开...';

  @override
  String get menuOpenRecent => '打开最近';

  @override
  String get menuNoRecentFiles => '没有最近文件';

  @override
  String get menuClearMenu => '清除菜单';

  @override
  String get menuSave => '保存';

  @override
  String get menuSaveAs => '另存为...';

  @override
  String get menuShare => '共享...';

  @override
  String get menuCloseWindow => '关闭窗口';

  @override
  String get saveChangesTitle => '保存更改？';

  @override
  String saveChangesMessage(String fileName) {
    return '关闭前是否要保存对「$fileName」的更改？';
  }

  @override
  String get saveButton => '保存';

  @override
  String get discardButton => '不保存';

  @override
  String get documentEdited => '已编辑';

  @override
  String get documentSaved => '已保存';

  @override
  String get menuSettings => '设置...';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsLanguageSystem => '系统默认';

  @override
  String get settingsUnits => '单位';

  @override
  String get settingsUnitsCentimeters => '厘米';

  @override
  String get settingsUnitsInches => '英寸';

  @override
  String get settingsSearchLanguages => '搜索语言...';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get openPdf => '開啟 PDF';

  @override
  String get selectPdf => '選擇 PDF';

  @override
  String get recentFiles => '最近檔案';

  @override
  String get removeFromList => '從列表中移除';

  @override
  String get openedNow => '剛剛開啟';

  @override
  String openedMinutesAgo(int count) {
    return '$count分鐘前開啟';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count小時前開啟';
  }

  @override
  String get openedYesterday => '昨天開啟';

  @override
  String openedDaysAgo(int count) {
    return '$count天前開啟';
  }

  @override
  String get fileNotFound => '找不到檔案';

  @override
  String get fileAccessDenied => '存取遭拒';

  @override
  String get clearRecentFiles => '清除最近檔案';

  @override
  String get cancel => '取消';

  @override
  String get confirm => '確認';

  @override
  String get error => '錯誤';

  @override
  String get ok => '好';

  @override
  String get menuFile => '檔案';

  @override
  String get menuOpen => '開啟...';

  @override
  String get menuOpenRecent => '開啟最近項目';

  @override
  String get menuNoRecentFiles => '沒有最近檔案';

  @override
  String get menuClearMenu => '清除選單';

  @override
  String get menuSave => '儲存';

  @override
  String get menuSaveAs => '另存新檔...';

  @override
  String get menuShare => '分享...';

  @override
  String get menuCloseWindow => '關閉視窗';

  @override
  String get saveChangesTitle => '儲存更動？';

  @override
  String saveChangesMessage(String fileName) {
    return '關閉前是否要儲存對「$fileName」的更動？';
  }

  @override
  String get saveButton => '儲存';

  @override
  String get discardButton => '不儲存';

  @override
  String get documentEdited => '已編輯';

  @override
  String get documentSaved => '已儲存';

  @override
  String get menuSettings => '設定...';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguage => '語言';

  @override
  String get settingsLanguageSystem => '系統預設';

  @override
  String get settingsUnits => '單位';

  @override
  String get settingsUnitsCentimeters => '公分';

  @override
  String get settingsUnitsInches => '英吋';

  @override
  String get settingsSearchLanguages => '搜尋語言...';
}
