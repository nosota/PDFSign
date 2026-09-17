// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get openPdf => 'PDF 열기';

  @override
  String get selectPdf => 'PDF 선택';

  @override
  String get recentFiles => '최근 파일';

  @override
  String get removeFromList => '목록에서 제거';

  @override
  String get openedNow => '방금 열림';

  @override
  String openedMinutesAgo(int count) {
    return '$count분 전에 열림';
  }

  @override
  String openedHoursAgo(int count) {
    return '$count시간 전에 열림';
  }

  @override
  String get openedYesterday => '어제 열림';

  @override
  String openedDaysAgo(int count) {
    return '$count일 전에 열림';
  }

  @override
  String get fileNotFound => '파일을 찾을 수 없음';

  @override
  String get fileAccessDenied => '접근이 거부됨';

  @override
  String get clearRecentFiles => '최근 파일 지우기';

  @override
  String get cancel => '취소';

  @override
  String get confirm => '확인';

  @override
  String get error => '오류';

  @override
  String get ok => '확인';

  @override
  String get menuFile => '파일';

  @override
  String get menuOpen => '열기...';

  @override
  String get menuOpenRecent => '최근 항목 열기';

  @override
  String get menuNoRecentFiles => '최근 파일 없음';

  @override
  String get menuClearMenu => '메뉴 지우기';

  @override
  String get menuSave => '저장';

  @override
  String get menuSaveAs => '다른 이름으로 저장...';

  @override
  String get menuSaveAll => '모두 저장';

  @override
  String get menuShare => '공유...';

  @override
  String get menuCloseWindow => '윈도우 닫기';

  @override
  String get menuCloseAll => '모두 닫기';

  @override
  String get menuEdit => '편집';

  @override
  String get menuDelete => '삭제';

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
  String get menuQuit => 'PDFSign 종료';

  @override
  String get closeAllDialogTitle => '변경사항을 저장하시겠습니까?';

  @override
  String closeAllDialogMessage(int count) {
    return '닫기 전에 $count개 문서의 변경사항을 저장하시겠습니까?';
  }

  @override
  String get closeAllDialogMessageOne => '닫기 전에 1개 문서의 변경사항을 저장하시겠습니까?';

  @override
  String get closeAllDialogSaveAll => '모두 저장';

  @override
  String get closeAllDialogDontSave => '저장 안 함';

  @override
  String get closeAllDialogCancel => '취소';

  @override
  String get saveFailedDialogTitle => '저장 실패';

  @override
  String saveFailedDialogMessage(int count) {
    return '$count개 문서를 저장하지 못했습니다. 그래도 닫으시겠습니까?';
  }

  @override
  String get saveFailedDialogClose => '그래도 닫기';

  @override
  String get saveChangesTitle => '변경사항을 저장하시겠습니까?';

  @override
  String saveChangesMessage(String fileName) {
    return '닫기 전에 \"$fileName\"의 변경사항을 저장하시겠습니까?';
  }

  @override
  String get saveButton => '저장';

  @override
  String get discardButton => '저장 안 함';

  @override
  String get documentEdited => '편집됨';

  @override
  String get documentSaved => '저장됨';

  @override
  String get menuSettings => '설정...';

  @override
  String get menuWindow => '윈도우';

  @override
  String get menuMinimize => '최소화';

  @override
  String get menuZoom => '확대/축소';

  @override
  String get menuBringAllToFront => '모두 앞으로 가져오기';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsLanguage => '언어';

  @override
  String get settingsLanguageSystem => '시스템 기본값';

  @override
  String get settingsUnits => '단위';

  @override
  String get settingsUnitsCentimeters => '센티미터';

  @override
  String get settingsUnitsInches => '인치';

  @override
  String get settingsSearchLanguages => '언어 검색...';

  @override
  String get settingsGeneral => '일반';

  @override
  String get addImage => '이미지 추가';

  @override
  String get selectImages => '이미지 선택';

  @override
  String get zoomFitWidth => '너비에 맞춤';

  @override
  String get zoomIn => '확대';

  @override
  String get zoomOut => '축소';

  @override
  String get selectZoomLevel => '확대/축소 수준 선택';

  @override
  String get goToPage => '페이지로 이동';

  @override
  String get go => '이동';

  @override
  String get savePdfAs => 'PDF 다른 이름으로 저장';

  @override
  String get incorrectPassword => '잘못된 비밀번호';

  @override
  String get saveFailed => '저장 실패';

  @override
  String savedTo(String path) {
    return '저장 위치: $path';
  }

  @override
  String get noOriginalPdfStored => '원본 PDF가 저장되지 않음';

  @override
  String get waitingForFolderPermission => '폴더 접근 권한을 기다리는 중...';

  @override
  String get deleteButtonLabel => '삭제';

  @override
  String get deleteButtonTooltip => '선택한 개체 삭제';

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
