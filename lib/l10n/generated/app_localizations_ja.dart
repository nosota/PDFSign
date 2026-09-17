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
  String get menuSaveAll => 'すべて保存';

  @override
  String get menuShare => '共有...';

  @override
  String get menuCloseWindow => 'ウインドウを閉じる';

  @override
  String get menuCloseAll => 'すべて閉じる';

  @override
  String get menuEdit => '編集';

  @override
  String get menuDelete => '削除';

  @override
  String get menuView => 'View';

  @override
  String goToPagePrompt(int total) {
    return 'Enter page number (1-$total):';
  }

  @override
  String get goToPageHint => 'Page number';

  @override
  String get goToPageInvalid => 'Please enter a valid number';

  @override
  String goToPageOutOfRange(int total) {
    return 'Page must be between 1 and $total';
  }

  @override
  String get menuRotateLeft => 'Rotate Left';

  @override
  String get menuRotateRight => 'Rotate Right';

  @override
  String get menuCut => 'Cut';

  @override
  String get menuCopy => 'Copy';

  @override
  String get menuPaste => 'Paste';

  @override
  String imagesTooLarge(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images are',
      one: 'image is',
    );
    return 'Not added: $count $_temp0 larger than $limit pixels';
  }

  @override
  String imagesNotAdded(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'images',
      one: 'image',
    );
    return 'Not added: $count $_temp0';
  }

  @override
  String get clipboardUnavailable => 'The clipboard is unavailable';

  @override
  String get pasteImageFailed => 'That image could not be added';

  @override
  String get menuQuit => 'PDFSignを終了';

  @override
  String get closeAllDialogTitle => '変更を保存しますか？';

  @override
  String closeAllDialogMessage(int count) {
    return '閉じる前に$count個のドキュメントの変更を保存しますか？';
  }

  @override
  String get closeAllDialogMessageOne => '閉じる前に1個のドキュメントの変更を保存しますか？';

  @override
  String get closeAllDialogSaveAll => 'すべて保存';

  @override
  String get closeAllDialogDontSave => '保存しない';

  @override
  String get closeAllDialogCancel => 'キャンセル';

  @override
  String get saveFailedDialogTitle => '保存に失敗しました';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count件のドキュメントの保存に失敗しました。それでも閉じますか？';
  }

  @override
  String get saveFailedDialogClose => 'それでも閉じる';

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
  String get menuWindow => 'ウインドウ';

  @override
  String get menuMinimize => 'しまう';

  @override
  String get menuZoom => '拡大/縮小';

  @override
  String get menuBringAllToFront => 'すべてを手前に移動';

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
  String get settingsGeneral => '一般';

  @override
  String get addImage => '画像を追加';

  @override
  String get selectImages => '画像を選択';

  @override
  String get zoomFitWidth => '幅に合わせる';

  @override
  String get zoomIn => '拡大';

  @override
  String get zoomOut => '縮小';

  @override
  String get selectZoomLevel => 'ズームレベルを選択';

  @override
  String get goToPage => 'ページに移動';

  @override
  String get go => '移動';

  @override
  String get savePdfAs => 'PDFを別名で保存';

  @override
  String get incorrectPassword => 'パスワードが正しくありません';

  @override
  String get saveFailed => '保存に失敗しました';

  @override
  String savedTo(String path) {
    return '保存先: $path';
  }

  @override
  String get noOriginalPdfStored => '元のPDFが保存されていません';

  @override
  String get waitingForFolderPermission => 'フォルダアクセス許可を待っています...';

  @override
  String get deleteButtonLabel => '削除';

  @override
  String get deleteButtonTooltip => '選択したオブジェクトを削除';

  @override
  String get documentProtectedTitle => 'This document is protected';

  @override
  String get documentProtectedBody => 'Enter its password to open it.';

  @override
  String get passwordFieldLabel => 'Password';

  @override
  String get openDocumentButton => 'Open';

  @override
  String get documentReadOnlyTitle => 'This document does not allow changes';

  @override
  String get documentReadOnlyBody =>
      'It can be read and printed, but its owner has not allowed it to be changed. Enter the owner password to edit it.';

  @override
  String get enterOwnerPassword => 'Enter owner password';

  @override
  String get ownerPasswordFieldLabel => 'Owner password';

  @override
  String get menuPrint => 'Print…';

  @override
  String get menuPrintCurrentPage => 'Print Current Page';

  @override
  String get printingIsTheOwnersTitle =>
      'Only the owner may print this document';

  @override
  String get printingNotAllowed => 'This document does not allow printing.';

  @override
  String get printingFailed => 'The document could not be printed.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Only the owner may change this document\'s protection';

  @override
  String get continueButton => 'Continue';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'A protected document has to be held in memory to be shown, and this one is $size. Opening it will use about that much.';
  }

  @override
  String get shareProtectedNotice =>
      'The shared copy keeps the document\'s password.';

  @override
  String get unsupportedProtection =>
      'This document\'s protection is not supported. PDFSign opens password-protected documents, not those protected by a certificate.';

  @override
  String get menuBringToFront => 'Bring to Front';

  @override
  String get menuBringForward => 'Bring Forward';

  @override
  String get menuSendBackward => 'Send Backward';

  @override
  String get menuSendToBack => 'Send to Back';

  @override
  String get zOrderGroupLabel => 'Arrange';

  @override
  String get menuUndo => 'Undo';

  @override
  String get menuRedo => 'Redo';

  @override
  String get dragToReorder => 'Drag to reorder';

  @override
  String get protectDocumentTitle => 'Protect Document';

  @override
  String get requirePasswordToOpen => 'Require Password To Open Document';

  @override
  String get verifyFieldLabel => 'Verify';

  @override
  String get permissionsHeading => 'Permissions';

  @override
  String get permissionsNote =>
      'Allow the following changes to be made without entering the owner password.';

  @override
  String get permissionPrinting => 'Printing';

  @override
  String get permissionCopying => 'Copying Text or Graphics';

  @override
  String get permissionPageAssembly => 'Inserting, Deleting, or Rotating Pages';

  @override
  String get permissionAnnotations => 'Adding Annotations or Signatures';

  @override
  String get permissionChangingContent => 'Changing the Document';

  @override
  String get permissionFormFilling => 'Filling Existing Form Fields';

  @override
  String get changingContentIncludes =>
      'Changing the document includes annotating and filling in forms, so those are granted with it.';

  @override
  String get ownerPasswordHeading => 'Owner Password';

  @override
  String get removeProtection => 'Remove Protection';

  @override
  String get applyButton => 'Apply';

  @override
  String get passwordsDoNotMatch => 'The passwords do not match';

  @override
  String get passwordCannotBeEmpty => 'Enter a password';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Restrictions need an owner password. Without one, anyone can lift them.';

  @override
  String get signingNeedsChangingContent =>
      'Without “Changing the Document”, this file cannot be signed here again unless the owner password is given.';

  @override
  String get menuProtectDocument => 'Protect Document…';

  @override
  String get protectButtonLabel => 'Protect';

  @override
  String get protectButtonTooltip =>
      'Set this document\'s passwords and permissions';
}
