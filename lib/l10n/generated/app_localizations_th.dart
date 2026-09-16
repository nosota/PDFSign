// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get openPdf => 'เปิด PDF';

  @override
  String get selectPdf => 'เลือก PDF';

  @override
  String get recentFiles => 'ไฟล์ล่าสุด';

  @override
  String get removeFromList => 'ลบออกจากรายการ';

  @override
  String get openedNow => 'เพิ่งเปิด';

  @override
  String openedMinutesAgo(int count) {
    return 'เปิดเมื่อ $count นาทีที่แล้ว';
  }

  @override
  String openedHoursAgo(int count) {
    return 'เปิดเมื่อ $count ชั่วโมงที่แล้ว';
  }

  @override
  String get openedYesterday => 'เปิดเมื่อวานนี้';

  @override
  String openedDaysAgo(int count) {
    return 'เปิดเมื่อ $count วันที่แล้ว';
  }

  @override
  String get fileNotFound => 'ไม่พบไฟล์';

  @override
  String get fileAccessDenied => 'การเข้าถึงถูกปฏิเสธ';

  @override
  String get clearRecentFiles => 'ล้างไฟล์ล่าสุด';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get confirm => 'ยืนยัน';

  @override
  String get error => 'ข้อผิดพลาด';

  @override
  String get ok => 'ตกลง';

  @override
  String get menuFile => 'ไฟล์';

  @override
  String get menuOpen => 'เปิด...';

  @override
  String get menuOpenRecent => 'เปิดล่าสุด';

  @override
  String get menuNoRecentFiles => 'ไม่มีไฟล์ล่าสุด';

  @override
  String get menuClearMenu => 'ล้างเมนู';

  @override
  String get menuSave => 'บันทึก';

  @override
  String get menuSaveAs => 'บันทึกเป็น...';

  @override
  String get menuSaveAll => 'บันทึกทั้งหมด';

  @override
  String get menuShare => 'แชร์...';

  @override
  String get menuCloseWindow => 'ปิดหน้าต่าง';

  @override
  String get menuCloseAll => 'ปิดทั้งหมด';

  @override
  String get menuEdit => 'แก้ไข';

  @override
  String get menuDelete => 'ลบ';

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
  String get menuQuit => 'ออกจาก PDFSign';

  @override
  String get closeAllDialogTitle => 'บันทึกการเปลี่ยนแปลง?';

  @override
  String closeAllDialogMessage(int count) {
    return 'คุณต้องการบันทึกการเปลี่ยนแปลงใน $count เอกสารก่อนปิดหรือไม่?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'คุณต้องการบันทึกการเปลี่ยนแปลงใน 1 เอกสารก่อนปิดหรือไม่?';

  @override
  String get closeAllDialogSaveAll => 'บันทึกทั้งหมด';

  @override
  String get closeAllDialogDontSave => 'ไม่บันทึก';

  @override
  String get closeAllDialogCancel => 'ยกเลิก';

  @override
  String get saveFailedDialogTitle => 'บันทึกล้มเหลว';

  @override
  String saveFailedDialogMessage(int count) {
    return 'บันทึก $count เอกสารไม่สำเร็จ ปิดต่อไปหรือไม่?';
  }

  @override
  String get saveFailedDialogClose => 'ปิดต่อไป';

  @override
  String get saveChangesTitle => 'บันทึกการเปลี่ยนแปลง?';

  @override
  String saveChangesMessage(String fileName) {
    return 'คุณต้องการบันทึกการเปลี่ยนแปลงใน \"$fileName\" ก่อนปิดหรือไม่?';
  }

  @override
  String get saveButton => 'บันทึก';

  @override
  String get discardButton => 'ไม่บันทึก';

  @override
  String get documentEdited => 'แก้ไขแล้ว';

  @override
  String get documentSaved => 'บันทึกแล้ว';

  @override
  String get menuSettings => 'การตั้งค่า...';

  @override
  String get menuWindow => 'หน้าต่าง';

  @override
  String get menuMinimize => 'ย่อเล็กสุด';

  @override
  String get menuZoom => 'ซูม';

  @override
  String get menuBringAllToFront => 'นำทั้งหมดมาข้างหน้า';

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get settingsLanguage => 'ภาษา';

  @override
  String get settingsLanguageSystem => 'ค่าเริ่มต้นของระบบ';

  @override
  String get settingsUnits => 'หน่วย';

  @override
  String get settingsUnitsCentimeters => 'เซนติเมตร';

  @override
  String get settingsUnitsInches => 'นิ้ว';

  @override
  String get settingsSearchLanguages => 'ค้นหาภาษา...';

  @override
  String get settingsGeneral => 'ทั่วไป';

  @override
  String get addImage => 'เพิ่มรูปภาพ';

  @override
  String get selectImages => 'เลือกรูปภาพ';

  @override
  String get zoomFitWidth => 'พอดีความกว้าง';

  @override
  String get zoomIn => 'ซูมเข้า';

  @override
  String get zoomOut => 'ซูมออก';

  @override
  String get selectZoomLevel => 'เลือกระดับการซูม';

  @override
  String get goToPage => 'ไปที่หน้า';

  @override
  String get go => 'ไป';

  @override
  String get savePdfAs => 'บันทึก PDF เป็น';

  @override
  String get incorrectPassword => 'รหัสผ่านไม่ถูกต้อง';

  @override
  String get saveFailed => 'บันทึกล้มเหลว';

  @override
  String savedTo(String path) {
    return 'บันทึกที่: $path';
  }

  @override
  String get noOriginalPdfStored => 'ไม่มี PDF ต้นฉบับถูกจัดเก็บ';

  @override
  String get waitingForFolderPermission => 'กำลังรอสิทธิ์การเข้าถึงโฟลเดอร์...';

  @override
  String get deleteButtonLabel => 'ลบ';

  @override
  String get deleteButtonTooltip => 'ลบวัตถุที่เลือก';

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
  String get largeProtectedDocumentTitle => 'This protected document is large';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'A protected document has to be held in memory to be shown, and this one is $size. Opening it will use about that much.';
  }

  @override
  String get openAnyway => 'Open';

  @override
  String get shareProtectedNotice =>
      'The shared copy keeps the document\'s password.';

  @override
  String get unsupportedProtection =>
      'This document\'s protection is not supported. PDFSign opens password-protected documents, not those protected by a certificate.';
}
