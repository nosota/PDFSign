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
  String get menuView => '보기';

  @override
  String goToPagePrompt(int total) {
    return '페이지 번호를 입력하십시오(1–$total):';
  }

  @override
  String get goToPageHint => '페이지 번호';

  @override
  String get goToPageInvalid => '올바른 숫자를 입력하십시오';

  @override
  String goToPageOutOfRange(int total) {
    return '페이지는 1에서 $total 사이여야 합니다';
  }

  @override
  String get menuRotateLeft => '왼쪽으로 회전';

  @override
  String get menuRotateRight => '오른쪽으로 회전';

  @override
  String get menuCut => '오려두기';

  @override
  String get menuCopy => '복사하기';

  @override
  String get menuPaste => '붙여넣기';

  @override
  String imagesTooLarge(int count, String limit) {
    return '추가되지 않음: 이미지 $count개가 $limit을(를) 초과합니다';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return '추가되지 않음: 이미지 $count개가 $limit픽셀을 초과합니다';
  }

  @override
  String imagesNotAdded(int count) {
    return '추가되지 않음: 이미지 $count개';
  }

  @override
  String get clipboardUnavailable => '클립보드를 사용할 수 없습니다';

  @override
  String get pasteImageFailed => '이 이미지를 추가할 수 없습니다';

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
  String get documentProtectedTitle => '이 서류는 보호되어 있습니다';

  @override
  String get documentProtectedBody => '열려면 암호를 입력하십시오.';

  @override
  String get passwordFieldLabel => '암호';

  @override
  String get openDocumentButton => '열기';

  @override
  String get documentReadOnlyTitle => '이 서류는 변경을 허용하지 않습니다';

  @override
  String get documentReadOnlyBody =>
      '읽고 프린트할 수 있지만 소유자가 변경을 허용하지 않았습니다. 편집하려면 소유자 암호를 입력하십시오.';

  @override
  String get enterOwnerPassword => '소유자 암호 입력';

  @override
  String get ownerPasswordFieldLabel => '소유자 암호';

  @override
  String get menuPrint => '프린트…';

  @override
  String get menuPrintCurrentPage => '현재 페이지 프린트';

  @override
  String get printingIsTheOwnersTitle => '이 서류는 소유자만 프린트할 수 있습니다';

  @override
  String get printingNotAllowed => '이 서류는 프린트를 허용하지 않습니다.';

  @override
  String get printingFailed => '서류를 프린트할 수 없습니다.';

  @override
  String get protectionIsTheOwnersTitle => '이 서류의 보호는 소유자만 변경할 수 있습니다';

  @override
  String get continueButton => '계속';

  @override
  String largeProtectedDocumentBody(String size) {
    return '보호된 서류는 메모리에서 표시되며, 이 서류의 크기는 $size입니다. 여는 데 비슷한 크기의 메모리가 사용됩니다.';
  }

  @override
  String get shareProtectedNotice => '공유된 사본은 서류의 암호를 유지합니다.';

  @override
  String get unsupportedProtection =>
      '이 서류의 보호 방식은 지원되지 않습니다. PDFSign은 암호로 보호된 서류를 열며, 인증서로 보호된 서류는 지원하지 않습니다.';

  @override
  String get menuBringToFront => '맨 앞으로 가져오기';

  @override
  String get menuBringForward => '앞으로 가져오기';

  @override
  String get menuSendBackward => '뒤로 보내기';

  @override
  String get menuSendToBack => '맨 뒤로 보내기';

  @override
  String get zOrderGroupLabel => '정렬';

  @override
  String get menuUndo => '실행 취소';

  @override
  String get menuRedo => '다시 실행';

  @override
  String get dragToReorder => '드래그하여 순서 변경';

  @override
  String get protectDocumentTitle => '서류 보호';

  @override
  String get requirePasswordToOpen => '서류를 열 때 암호 요구';

  @override
  String get verifyFieldLabel => '확인';

  @override
  String get permissionsHeading => '권한';

  @override
  String get permissionsNote => '소유자 암호를 입력하지 않아도 다음 변경을 허용합니다.';

  @override
  String get permissionPrinting => '프린트';

  @override
  String get permissionCopying => '텍스트 또는 그래픽 복사';

  @override
  String get permissionPageAssembly => '페이지 삽입, 삭제 및 회전';

  @override
  String get permissionAnnotations => '주석 또는 서명 추가';

  @override
  String get permissionChangingContent => '서류 변경';

  @override
  String get permissionFormFilling => '기존 양식 필드 입력';

  @override
  String get changingContentIncludes => '서류 변경에는 주석 달기와 양식 작성이 포함되며, 함께 허용됩니다.';

  @override
  String get ownerPasswordHeading => '소유자 암호';

  @override
  String get removeProtection => '보호 제거';

  @override
  String get applyButton => '적용';

  @override
  String get passwordsDoNotMatch => '암호가 일치하지 않습니다';

  @override
  String get passwordCannotBeEmpty => '암호를 입력하십시오';

  @override
  String get restrictionsNeedOwnerPassword =>
      '제한에는 소유자 암호가 필요합니다. 암호가 없으면 누구나 제한을 해제할 수 있습니다.';

  @override
  String get signingNeedsChangingContent =>
      '‘서류 변경’을 허용하지 않으면 소유자 암호 없이 이 파일에 여기서 다시 서명할 수 없습니다.';

  @override
  String get menuProtectDocument => '서류 보호…';

  @override
  String get protectButtonLabel => '보호';

  @override
  String get protectButtonTooltip => '이 서류의 암호와 권한을 설정합니다';
}
