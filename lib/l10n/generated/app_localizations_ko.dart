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
  String get menuShare => '공유...';

  @override
  String get menuCloseWindow => '윈도우 닫기';

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
}
