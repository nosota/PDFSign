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
  String get menuSaveAll => '全部保存';

  @override
  String get menuShare => '共享...';

  @override
  String get menuCloseWindow => '关闭窗口';

  @override
  String get menuCloseAll => '全部关闭';

  @override
  String get menuEdit => '编辑';

  @override
  String get menuDelete => '删除';

  @override
  String get menuView => '显示';

  @override
  String goToPagePrompt(int total) {
    return '输入页码（1–$total）：';
  }

  @override
  String get goToPageHint => '页码';

  @override
  String get goToPageInvalid => '请输入有效的数字';

  @override
  String goToPageOutOfRange(int total) {
    return '页码必须介于 1 和 $total 之间';
  }

  @override
  String get menuRotateLeft => '向左旋转';

  @override
  String get menuRotateRight => '向右旋转';

  @override
  String get menuCut => '剪切';

  @override
  String get menuCopy => '拷贝';

  @override
  String get menuPaste => '粘贴';

  @override
  String imagesTooLarge(int count, String limit) {
    return '未添加 $count 张图像：超过 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return '未添加 $count 张图像：超过 $limit 像素';
  }

  @override
  String imagesNotAdded(int count) {
    return '未添加 $count 张图像';
  }

  @override
  String get clipboardUnavailable => '剪贴板不可用';

  @override
  String get pasteImageFailed => '无法添加该图像';

  @override
  String get menuQuit => '退出 PDFSign';

  @override
  String get closeAllDialogTitle => '保存更改？';

  @override
  String closeAllDialogMessage(int count) {
    return '关闭前是否要保存对 $count 个文档的更改？';
  }

  @override
  String get closeAllDialogMessageOne => '关闭前是否要保存对 1 个文档的更改？';

  @override
  String get closeAllDialogSaveAll => '全部保存';

  @override
  String get closeAllDialogDontSave => '不保存';

  @override
  String get closeAllDialogCancel => '取消';

  @override
  String get saveFailedDialogTitle => '保存失败';

  @override
  String saveFailedDialogMessage(int count) {
    return '无法保存 $count 个文档。仍然关闭？';
  }

  @override
  String get saveFailedDialogClose => '仍然关闭';

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
  String get menuWindow => '窗口';

  @override
  String get menuMinimize => '最小化';

  @override
  String get menuZoom => '缩放';

  @override
  String get menuBringAllToFront => '前置全部窗口';

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
  String get settingsGeneral => '通用';

  @override
  String get addImage => '添加图片';

  @override
  String get selectImages => '选择图片';

  @override
  String get zoomFitWidth => '适应宽度';

  @override
  String get zoomIn => '放大';

  @override
  String get zoomOut => '缩小';

  @override
  String get selectZoomLevel => '选择缩放级别';

  @override
  String get goToPage => '跳转到页面';

  @override
  String get go => '跳转';

  @override
  String get savePdfAs => 'PDF另存为';

  @override
  String get incorrectPassword => '密码错误';

  @override
  String get saveFailed => '保存失败';

  @override
  String savedTo(String path) {
    return '已保存至：$path';
  }

  @override
  String get noOriginalPdfStored => '未存储原始PDF';

  @override
  String get waitingForFolderPermission => '正在等待文件夹访问权限...';

  @override
  String get deleteButtonLabel => '删除';

  @override
  String get deleteButtonTooltip => '删除所选对象';

  @override
  String get documentProtectedTitle => '此文稿受保护';

  @override
  String get documentProtectedBody => '请输入密码以打开它。';

  @override
  String get passwordFieldLabel => '密码';

  @override
  String get openDocumentButton => '打开';

  @override
  String get documentReadOnlyTitle => '此文稿不允许更改';

  @override
  String get documentReadOnlyBody => '可以阅读和打印，但其所有者未允许更改。请输入所有者密码以进行编辑。';

  @override
  String get enterOwnerPassword => '输入所有者密码';

  @override
  String get ownerPasswordFieldLabel => '所有者密码';

  @override
  String get menuPrint => '打印…';

  @override
  String get menuPrintCurrentPage => '打印当前页';

  @override
  String get printingIsTheOwnersTitle => '只有所有者可以打印此文稿';

  @override
  String get printingNotAllowed => '此文稿不允许打印。';

  @override
  String get printingFailed => '无法打印此文稿。';

  @override
  String get protectionIsTheOwnersTitle => '只有所有者可以更改此文稿的保护';

  @override
  String get continueButton => '继续';

  @override
  String largeProtectedDocumentBody(String size) {
    return '受保护的文稿从内存中显示，而此文稿大小为 $size。打开它将占用大致相同的内存。';
  }

  @override
  String get shareProtectedNotice => '共享的副本会保留文稿的密码。';

  @override
  String get unsupportedProtection =>
      '不支持此文稿的保护方式。PDFSign 可以打开使用密码保护的文稿，但不支持使用证书保护的文稿。';

  @override
  String get menuBringToFront => '移到最前';

  @override
  String get menuBringForward => '前移一层';

  @override
  String get menuSendBackward => '后移一层';

  @override
  String get menuSendToBack => '移到最后';

  @override
  String get zOrderGroupLabel => '排列';

  @override
  String get menuUndo => '撤销';

  @override
  String get menuRedo => '重做';

  @override
  String get dragToReorder => '拖移以调整顺序';

  @override
  String get protectDocumentTitle => '保护文稿';

  @override
  String get requirePasswordToOpen => '打开文稿时需要密码';

  @override
  String get verifyFieldLabel => '确认';

  @override
  String get permissionsHeading => '权限';

  @override
  String get permissionsNote => '允许在不输入所有者密码的情况下进行以下更改。';

  @override
  String get permissionPrinting => '打印';

  @override
  String get permissionCopying => '拷贝文本或图形';

  @override
  String get permissionPageAssembly => '插入、删除或旋转页面';

  @override
  String get permissionAnnotations => '添加标注或签名';

  @override
  String get permissionChangingContent => '更改文稿';

  @override
  String get permissionFormFilling => '填写现有的表单栏位';

  @override
  String get changingContentIncludes => '更改文稿包含标注和填写表单，二者随之一并允许。';

  @override
  String get ownerPasswordHeading => '所有者密码';

  @override
  String get removeProtection => '移除保护';

  @override
  String get applyButton => '应用';

  @override
  String get passwordsDoNotMatch => '两次输入的密码不一致';

  @override
  String get passwordCannotBeEmpty => '请输入密码';

  @override
  String get restrictionsNeedOwnerPassword => '限制需要所有者密码。没有它，任何人都可以解除这些限制。';

  @override
  String get signingNeedsChangingContent => '若不勾选“更改文稿”，没有所有者密码就无法在此再次签名。';

  @override
  String get menuProtectDocument => '保护文稿…';

  @override
  String get protectButtonLabel => '保护';

  @override
  String get protectButtonTooltip => '设置此文稿的密码和权限';
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
  String get menuSaveAll => '全部保存';

  @override
  String get menuShare => '共享...';

  @override
  String get menuCloseWindow => '关闭窗口';

  @override
  String get menuCloseAll => '全部关闭';

  @override
  String get menuEdit => '编辑';

  @override
  String get menuDelete => '删除';

  @override
  String get menuView => '显示';

  @override
  String goToPagePrompt(int total) {
    return '输入页码（1–$total）：';
  }

  @override
  String get goToPageHint => '页码';

  @override
  String get goToPageInvalid => '请输入有效的数字';

  @override
  String goToPageOutOfRange(int total) {
    return '页码必须介于 1 和 $total 之间';
  }

  @override
  String get menuRotateLeft => '向左旋转';

  @override
  String get menuRotateRight => '向右旋转';

  @override
  String get menuCut => '剪切';

  @override
  String get menuCopy => '拷贝';

  @override
  String get menuPaste => '粘贴';

  @override
  String imagesTooLarge(int count, String limit) {
    return '未添加 $count 张图像：超过 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return '未添加 $count 张图像：超过 $limit 像素';
  }

  @override
  String imagesNotAdded(int count) {
    return '未添加 $count 张图像';
  }

  @override
  String get clipboardUnavailable => '剪贴板不可用';

  @override
  String get pasteImageFailed => '无法添加该图像';

  @override
  String get menuQuit => '退出 PDFSign';

  @override
  String get closeAllDialogTitle => '保存更改？';

  @override
  String closeAllDialogMessage(int count) {
    return '关闭前是否要保存对 $count 个文档的更改？';
  }

  @override
  String get closeAllDialogMessageOne => '关闭前是否要保存对 1 个文档的更改？';

  @override
  String get closeAllDialogSaveAll => '全部保存';

  @override
  String get closeAllDialogDontSave => '不保存';

  @override
  String get closeAllDialogCancel => '取消';

  @override
  String get saveFailedDialogTitle => '保存失败';

  @override
  String saveFailedDialogMessage(int count) {
    return '无法保存 $count 个文档。仍然关闭？';
  }

  @override
  String get saveFailedDialogClose => '仍然关闭';

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
  String get menuWindow => '窗口';

  @override
  String get menuMinimize => '最小化';

  @override
  String get menuZoom => '缩放';

  @override
  String get menuBringAllToFront => '前置全部窗口';

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
  String get settingsGeneral => '通用';

  @override
  String get addImage => '添加图片';

  @override
  String get selectImages => '选择图片';

  @override
  String get zoomFitWidth => '适应宽度';

  @override
  String get zoomIn => '放大';

  @override
  String get zoomOut => '缩小';

  @override
  String get selectZoomLevel => '选择缩放级别';

  @override
  String get goToPage => '跳转到页面';

  @override
  String get go => '跳转';

  @override
  String get savePdfAs => 'PDF另存为';

  @override
  String get incorrectPassword => '密码错误';

  @override
  String get saveFailed => '保存失败';

  @override
  String savedTo(String path) {
    return '已保存至：$path';
  }

  @override
  String get noOriginalPdfStored => '未存储原始PDF';

  @override
  String get waitingForFolderPermission => '正在等待文件夹访问权限...';

  @override
  String get deleteButtonLabel => '删除';

  @override
  String get deleteButtonTooltip => '删除所选对象';

  @override
  String get documentProtectedTitle => '此文稿受保护';

  @override
  String get documentProtectedBody => '请输入密码以打开它。';

  @override
  String get passwordFieldLabel => '密码';

  @override
  String get openDocumentButton => '打开';

  @override
  String get documentReadOnlyTitle => '此文稿不允许更改';

  @override
  String get documentReadOnlyBody => '可以阅读和打印，但其所有者未允许更改。请输入所有者密码以进行编辑。';

  @override
  String get enterOwnerPassword => '输入所有者密码';

  @override
  String get ownerPasswordFieldLabel => '所有者密码';

  @override
  String get menuPrint => '打印…';

  @override
  String get menuPrintCurrentPage => '打印当前页';

  @override
  String get printingIsTheOwnersTitle => '只有所有者可以打印此文稿';

  @override
  String get printingNotAllowed => '此文稿不允许打印。';

  @override
  String get printingFailed => '无法打印此文稿。';

  @override
  String get protectionIsTheOwnersTitle => '只有所有者可以更改此文稿的保护';

  @override
  String get continueButton => '继续';

  @override
  String largeProtectedDocumentBody(String size) {
    return '受保护的文稿从内存中显示，而此文稿大小为 $size。打开它将占用大致相同的内存。';
  }

  @override
  String get shareProtectedNotice => '共享的副本会保留文稿的密码。';

  @override
  String get unsupportedProtection =>
      '不支持此文稿的保护方式。PDFSign 可以打开使用密码保护的文稿，但不支持使用证书保护的文稿。';

  @override
  String get menuBringToFront => '移到最前';

  @override
  String get menuBringForward => '前移一层';

  @override
  String get menuSendBackward => '后移一层';

  @override
  String get menuSendToBack => '移到最后';

  @override
  String get zOrderGroupLabel => '排列';

  @override
  String get menuUndo => '撤销';

  @override
  String get menuRedo => '重做';

  @override
  String get dragToReorder => '拖移以调整顺序';

  @override
  String get protectDocumentTitle => '保护文稿';

  @override
  String get requirePasswordToOpen => '打开文稿时需要密码';

  @override
  String get verifyFieldLabel => '确认';

  @override
  String get permissionsHeading => '权限';

  @override
  String get permissionsNote => '允许在不输入所有者密码的情况下进行以下更改。';

  @override
  String get permissionPrinting => '打印';

  @override
  String get permissionCopying => '拷贝文本或图形';

  @override
  String get permissionPageAssembly => '插入、删除或旋转页面';

  @override
  String get permissionAnnotations => '添加标注或签名';

  @override
  String get permissionChangingContent => '更改文稿';

  @override
  String get permissionFormFilling => '填写现有的表单栏位';

  @override
  String get changingContentIncludes => '更改文稿包含标注和填写表单，二者随之一并允许。';

  @override
  String get ownerPasswordHeading => '所有者密码';

  @override
  String get removeProtection => '移除保护';

  @override
  String get applyButton => '应用';

  @override
  String get passwordsDoNotMatch => '两次输入的密码不一致';

  @override
  String get passwordCannotBeEmpty => '请输入密码';

  @override
  String get restrictionsNeedOwnerPassword => '限制需要所有者密码。没有它，任何人都可以解除这些限制。';

  @override
  String get signingNeedsChangingContent => '若不勾选“更改文稿”，没有所有者密码就无法在此再次签名。';

  @override
  String get menuProtectDocument => '保护文稿…';

  @override
  String get protectButtonLabel => '保护';

  @override
  String get protectButtonTooltip => '设置此文稿的密码和权限';
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
  String get menuSaveAll => '全部保存';

  @override
  String get menuShare => '分享...';

  @override
  String get menuCloseWindow => '關閉視窗';

  @override
  String get menuCloseAll => '全部關閉';

  @override
  String get menuEdit => '編輯';

  @override
  String get menuDelete => '刪除';

  @override
  String get menuView => '顯示方式';

  @override
  String goToPagePrompt(int total) {
    return '輸入頁碼（1–$total）：';
  }

  @override
  String get goToPageHint => '頁碼';

  @override
  String get goToPageInvalid => '請輸入有效的數字';

  @override
  String goToPageOutOfRange(int total) {
    return '頁碼必須介於 1 和 $total 之間';
  }

  @override
  String get menuRotateLeft => '向左旋轉';

  @override
  String get menuRotateRight => '向右旋轉';

  @override
  String get menuCut => '剪下';

  @override
  String get menuCopy => '拷貝';

  @override
  String get menuPaste => '貼上';

  @override
  String imagesTooLarge(int count, String limit) {
    return '未加入 $count 張影像：超過 $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return '未加入 $count 張影像：超過 $limit 像素';
  }

  @override
  String imagesNotAdded(int count) {
    return '未加入 $count 張影像';
  }

  @override
  String get clipboardUnavailable => '剪貼板無法使用';

  @override
  String get pasteImageFailed => '無法加入該影像';

  @override
  String get menuQuit => '結束 PDFSign';

  @override
  String get closeAllDialogTitle => '儲存更動？';

  @override
  String closeAllDialogMessage(int count) {
    return '關閉前是否要儲存對 $count 個文件的更動？';
  }

  @override
  String get closeAllDialogMessageOne => '關閉前是否要儲存對 1 個文件的更動？';

  @override
  String get closeAllDialogSaveAll => '全部儲存';

  @override
  String get closeAllDialogDontSave => '不儲存';

  @override
  String get closeAllDialogCancel => '取消';

  @override
  String get saveFailedDialogTitle => '儲存失敗';

  @override
  String saveFailedDialogMessage(int count) {
    return '無法儲存 $count 個文件。仍然關閉？';
  }

  @override
  String get saveFailedDialogClose => '仍然關閉';

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
  String get menuWindow => '視窗';

  @override
  String get menuMinimize => '縮小';

  @override
  String get menuZoom => '縮放';

  @override
  String get menuBringAllToFront => '將所有視窗移至最前';

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

  @override
  String get settingsGeneral => '一般';

  @override
  String get addImage => '新增圖片';

  @override
  String get selectImages => '選擇圖片';

  @override
  String get zoomFitWidth => '符合寬度';

  @override
  String get zoomIn => '放大';

  @override
  String get zoomOut => '縮小';

  @override
  String get selectZoomLevel => '選擇縮放級別';

  @override
  String get goToPage => '前往頁面';

  @override
  String get go => '前往';

  @override
  String get savePdfAs => 'PDF另存新檔';

  @override
  String get incorrectPassword => '密碼錯誤';

  @override
  String get saveFailed => '儲存失敗';

  @override
  String savedTo(String path) {
    return '已儲存至：$path';
  }

  @override
  String get noOriginalPdfStored => '未儲存原始PDF';

  @override
  String get waitingForFolderPermission => '正在等待資料夾存取權限...';

  @override
  String get deleteButtonLabel => '刪除';

  @override
  String get deleteButtonTooltip => '刪除所選物件';

  @override
  String get documentProtectedTitle => '此文件受保護';

  @override
  String get documentProtectedBody => '請輸入密碼來打開它。';

  @override
  String get passwordFieldLabel => '密碼';

  @override
  String get openDocumentButton => '打開';

  @override
  String get documentReadOnlyTitle => '此文件不允許更動';

  @override
  String get documentReadOnlyBody => '可以閱讀和列印，但其擁有者未允許更動。請輸入擁有者密碼來編輯。';

  @override
  String get enterOwnerPassword => '輸入擁有者密碼';

  @override
  String get ownerPasswordFieldLabel => '擁有者密碼';

  @override
  String get menuPrint => '列印…';

  @override
  String get menuPrintCurrentPage => '列印目前頁面';

  @override
  String get printingIsTheOwnersTitle => '只有擁有者可以列印此文件';

  @override
  String get printingNotAllowed => '此文件不允許列印。';

  @override
  String get printingFailed => '無法列印此文件。';

  @override
  String get protectionIsTheOwnersTitle => '只有擁有者可以更改此文件的保護';

  @override
  String get continueButton => '繼續';

  @override
  String largeProtectedDocumentBody(String size) {
    return '受保護的文件是從記憶體顯示的，而此文件大小為 $size。打開它會佔用大致相同的記憶體。';
  }

  @override
  String get shareProtectedNotice => '分享的拷貝會保留文件的密碼。';

  @override
  String get unsupportedProtection =>
      '不支援此文件的保護方式。PDFSign 可以打開以密碼保護的文件，但不支援以憑證保護的文件。';

  @override
  String get menuBringToFront => '移到最前面';

  @override
  String get menuBringForward => '向前移一層';

  @override
  String get menuSendBackward => '向後移一層';

  @override
  String get menuSendToBack => '移到最後面';

  @override
  String get zOrderGroupLabel => '排列';

  @override
  String get menuUndo => '還原';

  @override
  String get menuRedo => '重做';

  @override
  String get dragToReorder => '拖移來調整順序';

  @override
  String get protectDocumentTitle => '保護文件';

  @override
  String get requirePasswordToOpen => '打開文件時需要密碼';

  @override
  String get verifyFieldLabel => '確認';

  @override
  String get permissionsHeading => '權限';

  @override
  String get permissionsNote => '允許在不輸入擁有者密碼的情況下進行下列更動。';

  @override
  String get permissionPrinting => '列印';

  @override
  String get permissionCopying => '拷貝文字或圖形';

  @override
  String get permissionPageAssembly => '插入、刪除或旋轉頁面';

  @override
  String get permissionAnnotations => '加入註解或簽名';

  @override
  String get permissionChangingContent => '更動文件';

  @override
  String get permissionFormFilling => '填寫現有的表單欄位';

  @override
  String get changingContentIncludes => '更動文件包含註解和填寫表單，兩者會一併允許。';

  @override
  String get ownerPasswordHeading => '擁有者密碼';

  @override
  String get removeProtection => '移除保護';

  @override
  String get applyButton => '套用';

  @override
  String get passwordsDoNotMatch => '兩次輸入的密碼不一致';

  @override
  String get passwordCannotBeEmpty => '請輸入密碼';

  @override
  String get restrictionsNeedOwnerPassword => '限制需要擁有者密碼。沒有它，任何人都可以解除這些限制。';

  @override
  String get signingNeedsChangingContent => '若不勾選「更動文件」，沒有擁有者密碼就無法在此再次簽名。';

  @override
  String get menuProtectDocument => '保護文件…';

  @override
  String get protectButtonLabel => '保護';

  @override
  String get protectButtonTooltip => '設定此文件的密碼和權限';
}
