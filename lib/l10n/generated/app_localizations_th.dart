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
  String get menuView => 'มุมมอง';

  @override
  String goToPagePrompt(int total) {
    return 'ป้อนหมายเลขหน้า (1–$total):';
  }

  @override
  String get goToPageHint => 'หมายเลขหน้า';

  @override
  String get goToPageInvalid => 'โปรดป้อนตัวเลขที่ถูกต้อง';

  @override
  String goToPageOutOfRange(int total) {
    return 'หน้าต้องอยู่ระหว่าง 1 ถึง $total';
  }

  @override
  String get menuRotateLeft => 'หมุนซ้าย';

  @override
  String get menuRotateRight => 'หมุนขวา';

  @override
  String get menuCut => 'ตัด';

  @override
  String get menuCopy => 'คัดลอก';

  @override
  String get menuPaste => 'วาง';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'ไม่ได้เพิ่ม: รูปภาพ $count รูปมีขนาดเกิน $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'ไม่ได้เพิ่ม: รูปภาพ $count รูปมีขนาดเกิน $limit พิกเซล';
  }

  @override
  String imagesNotAdded(int count) {
    return 'ไม่ได้เพิ่ม: รูปภาพ $count รูป';
  }

  @override
  String get clipboardUnavailable => 'ใช้คลิปบอร์ดไม่ได้';

  @override
  String get pasteImageFailed => 'ไม่สามารถเพิ่มรูปภาพนี้ได้';

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
  String get documentProtectedTitle => 'เอกสารนี้ได้รับการป้องกัน';

  @override
  String get documentProtectedBody => 'ป้อนรหัสผ่านเพื่อเปิดเอกสาร';

  @override
  String get passwordFieldLabel => 'รหัสผ่าน';

  @override
  String get openDocumentButton => 'เปิด';

  @override
  String get documentReadOnlyTitle => 'เอกสารนี้ไม่อนุญาตให้แก้ไข';

  @override
  String get documentReadOnlyBody =>
      'อ่านและพิมพ์ได้ แต่เจ้าของไม่อนุญาตให้แก้ไข ป้อนรหัสผ่านของเจ้าของเพื่อแก้ไขเอกสาร';

  @override
  String get enterOwnerPassword => 'ป้อนรหัสผ่านของเจ้าของ';

  @override
  String get ownerPasswordFieldLabel => 'รหัสผ่านของเจ้าของ';

  @override
  String get menuPrint => 'พิมพ์…';

  @override
  String get menuPrintCurrentPage => 'พิมพ์หน้าปัจจุบัน';

  @override
  String get printingIsTheOwnersTitle =>
      'เฉพาะเจ้าของเท่านั้นที่พิมพ์เอกสารนี้ได้';

  @override
  String get printingNotAllowed => 'เอกสารนี้ไม่อนุญาตให้พิมพ์';

  @override
  String get printingFailed => 'ไม่สามารถพิมพ์เอกสารได้';

  @override
  String get protectionIsTheOwnersTitle =>
      'เฉพาะเจ้าของเท่านั้นที่เปลี่ยนการป้องกันของเอกสารนี้ได้';

  @override
  String get continueButton => 'ดำเนินการต่อ';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'เอกสารที่ได้รับการป้องกันจะแสดงจากหน่วยความจำ และเอกสารนี้มีขนาด $size การเปิดจะใช้หน่วยความจำประมาณเท่านี้';
  }

  @override
  String get shareProtectedNotice => 'สำเนาที่แบ่งปันยังคงมีรหัสผ่านของเอกสาร';

  @override
  String get unsupportedProtection =>
      'ไม่รองรับการป้องกันของเอกสารนี้ PDFSign เปิดเอกสารที่ป้องกันด้วยรหัสผ่าน ไม่ใช่เอกสารที่ป้องกันด้วยใบรับรอง';

  @override
  String get menuBringToFront => 'ย้ายไปด้านหน้าสุด';

  @override
  String get menuBringForward => 'ย้ายไปด้านหน้า';

  @override
  String get menuSendBackward => 'ย้ายไปด้านหลัง';

  @override
  String get menuSendToBack => 'ย้ายไปด้านหลังสุด';

  @override
  String get zOrderGroupLabel => 'จัดเรียง';

  @override
  String get menuUndo => 'เลิกทำ';

  @override
  String get menuRedo => 'ทำซ้ำ';

  @override
  String get dragToReorder => 'ลากเพื่อเปลี่ยนลำดับ';

  @override
  String get protectDocumentTitle => 'ป้องกันเอกสาร';

  @override
  String get requirePasswordToOpen => 'ต้องใช้รหัสผ่านเพื่อเปิดเอกสาร';

  @override
  String get verifyFieldLabel => 'ยืนยัน';

  @override
  String get permissionsHeading => 'สิทธิ์';

  @override
  String get permissionsNote =>
      'อนุญาตการเปลี่ยนแปลงต่อไปนี้โดยไม่ต้องป้อนรหัสผ่านของเจ้าของ';

  @override
  String get permissionPrinting => 'การพิมพ์';

  @override
  String get permissionCopying => 'การคัดลอกข้อความหรือกราฟิก';

  @override
  String get permissionPageAssembly => 'การแทรก ลบ และหมุนหน้า';

  @override
  String get permissionAnnotations => 'การเพิ่มคำอธิบายประกอบหรือลายเซ็น';

  @override
  String get permissionChangingContent => 'การเปลี่ยนแปลงเอกสาร';

  @override
  String get permissionFormFilling => 'การกรอกช่องแบบฟอร์มที่มีอยู่';

  @override
  String get changingContentIncludes =>
      'การเปลี่ยนแปลงเอกสารรวมถึงการใส่คำอธิบายประกอบและการกรอกแบบฟอร์ม ซึ่งได้รับอนุญาตไปพร้อมกัน';

  @override
  String get ownerPasswordHeading => 'รหัสผ่านของเจ้าของ';

  @override
  String get removeProtection => 'ลบการป้องกัน';

  @override
  String get applyButton => 'ใช้';

  @override
  String get passwordsDoNotMatch => 'รหัสผ่านไม่ตรงกัน';

  @override
  String get passwordCannotBeEmpty => 'ป้อนรหัสผ่าน';

  @override
  String get restrictionsNeedOwnerPassword =>
      'ข้อจำกัดต้องมีรหัสผ่านของเจ้าของ หากไม่มี ใครก็สามารถยกเลิกข้อจำกัดได้';

  @override
  String get signingNeedsChangingContent =>
      'หากไม่มี “การเปลี่ยนแปลงเอกสาร” จะไม่สามารถลงลายเซ็นไฟล์นี้ที่นี่ได้อีกหากไม่มีรหัสผ่านของเจ้าของ';

  @override
  String get menuProtectDocument => 'ป้องกันเอกสาร…';

  @override
  String get protectButtonLabel => 'ป้องกัน';

  @override
  String get protectButtonTooltip => 'ตั้งรหัสผ่านและสิทธิ์ของเอกสารนี้';
}
