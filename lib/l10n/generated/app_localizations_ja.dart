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
  String get menuView => '表示';

  @override
  String goToPagePrompt(int total) {
    return 'ページ番号を入力してください（1–$total）:';
  }

  @override
  String get goToPageHint => 'ページ番号';

  @override
  String get goToPageInvalid => '有効な数字を入力してください';

  @override
  String goToPageOutOfRange(int total) {
    return 'ページは 1 から $total の間で指定してください';
  }

  @override
  String get menuRotateLeft => '左に回転';

  @override
  String get menuRotateRight => '右に回転';

  @override
  String get menuCut => 'カット';

  @override
  String get menuCopy => 'コピー';

  @override
  String get menuPaste => 'ペースト';

  @override
  String imagesTooLarge(int count, String limit) {
    return '追加されませんでした：$count 件の画像が $limit を超えています';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return '追加されませんでした：$count 件の画像が $limit ピクセルを超えています';
  }

  @override
  String imagesNotAdded(int count) {
    return '追加されませんでした：$count 件の画像';
  }

  @override
  String get clipboardUnavailable => 'クリップボードを使用できません';

  @override
  String get pasteImageFailed => 'この画像は追加できませんでした';

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
  String get documentProtectedTitle => 'この書類は保護されています';

  @override
  String get documentProtectedBody => '開くにはパスワードを入力してください。';

  @override
  String get passwordFieldLabel => 'パスワード';

  @override
  String get openDocumentButton => '開く';

  @override
  String get documentReadOnlyTitle => 'この書類は変更を許可していません';

  @override
  String get documentReadOnlyBody =>
      '閲覧と印刷はできますが、所有者が変更を許可していません。編集するには所有者パスワードを入力してください。';

  @override
  String get enterOwnerPassword => '所有者パスワードを入力';

  @override
  String get ownerPasswordFieldLabel => '所有者パスワード';

  @override
  String get menuPrint => 'プリント…';

  @override
  String get menuPrintCurrentPage => '現在のページをプリント';

  @override
  String get printingIsTheOwnersTitle => 'この書類をプリントできるのは所有者だけです';

  @override
  String get printingNotAllowed => 'この書類はプリントを許可していません。';

  @override
  String get printingFailed => '書類をプリントできませんでした。';

  @override
  String get protectionIsTheOwnersTitle => 'この書類の保護を変更できるのは所有者だけです';

  @override
  String get continueButton => '続ける';

  @override
  String largeProtectedDocumentBody(String size) {
    return '保護された書類はメモリから表示され、この書類のサイズは $size です。開くと同程度のメモリを使用します。';
  }

  @override
  String get shareProtectedNotice => '共有されたコピーは書類のパスワードを保持します。';

  @override
  String get unsupportedProtection =>
      'この書類の保護には対応していません。PDFSign はパスワードで保護された書類を開きますが、証明書で保護された書類には対応していません。';

  @override
  String get menuBringToFront => '最前面へ移動';

  @override
  String get menuBringForward => '前面へ移動';

  @override
  String get menuSendBackward => '背面へ移動';

  @override
  String get menuSendToBack => '最背面へ移動';

  @override
  String get zOrderGroupLabel => '配置';

  @override
  String get menuUndo => '取り消す';

  @override
  String get menuRedo => 'やり直す';

  @override
  String get dragToReorder => 'ドラッグして順序を変更';

  @override
  String get protectDocumentTitle => '書類を保護';

  @override
  String get requirePasswordToOpen => '書類を開くときにパスワードを要求';

  @override
  String get verifyFieldLabel => '確認';

  @override
  String get permissionsHeading => 'アクセス権';

  @override
  String get permissionsNote => '所有者パスワードを入力しなくても次の変更を許可します。';

  @override
  String get permissionPrinting => 'プリント';

  @override
  String get permissionCopying => 'テキストまたはグラフィックのコピー';

  @override
  String get permissionPageAssembly => 'ページの挿入、削除、回転';

  @override
  String get permissionAnnotations => '注釈または署名の追加';

  @override
  String get permissionChangingContent => '書類の変更';

  @override
  String get permissionFormFilling => '既存のフォームフィールドへの入力';

  @override
  String get changingContentIncludes => '書類の変更には注釈とフォームへの入力が含まれ、これらも併せて許可されます。';

  @override
  String get ownerPasswordHeading => '所有者パスワード';

  @override
  String get removeProtection => '保護を解除';

  @override
  String get applyButton => '適用';

  @override
  String get passwordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get passwordCannotBeEmpty => 'パスワードを入力してください';

  @override
  String get restrictionsNeedOwnerPassword =>
      '制限には所有者パスワードが必要です。パスワードがなければ、誰でも制限を解除できます。';

  @override
  String get signingNeedsChangingContent =>
      '「書類の変更」を許可しない場合、所有者パスワードなしでこのファイルにここで再び署名することはできません。';

  @override
  String get menuProtectDocument => '書類を保護…';

  @override
  String get protectButtonLabel => '保護';

  @override
  String get protectButtonTooltip => 'この書類のパスワードとアクセス権を設定します';
}
