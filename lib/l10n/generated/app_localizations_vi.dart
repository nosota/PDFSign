// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get openPdf => 'Mo PDF';

  @override
  String get selectPdf => 'Chon PDF';

  @override
  String get recentFiles => 'Tap tin gan day';

  @override
  String get removeFromList => 'Xoa khoi danh sach';

  @override
  String get openedNow => 'Vua mo';

  @override
  String openedMinutesAgo(int count) {
    return 'Da mo $count phut truoc';
  }

  @override
  String openedHoursAgo(int count) {
    return 'Da mo $count gio truoc';
  }

  @override
  String get openedYesterday => 'Da mo hom qua';

  @override
  String openedDaysAgo(int count) {
    return 'Da mo $count ngay truoc';
  }

  @override
  String get fileNotFound => 'Khong tim thay tap tin';

  @override
  String get fileAccessDenied => 'Truy cap bi tu choi';

  @override
  String get clearRecentFiles => 'Xoa tap tin gan day';

  @override
  String get cancel => 'Huy';

  @override
  String get confirm => 'Xac nhan';

  @override
  String get error => 'Loi';

  @override
  String get ok => 'OK';

  @override
  String get menuFile => 'Tap tin';

  @override
  String get menuOpen => 'Mo...';

  @override
  String get menuOpenRecent => 'Mo gan day';

  @override
  String get menuNoRecentFiles => 'Khong co tap tin gan day';

  @override
  String get menuClearMenu => 'Xoa menu';

  @override
  String get menuSave => 'Luu';

  @override
  String get menuSaveAs => 'Luu nhu...';

  @override
  String get menuSaveAll => 'Lưu Tất Cả';

  @override
  String get menuShare => 'Chia se...';

  @override
  String get menuCloseWindow => 'Dong cua so';

  @override
  String get menuCloseAll => 'Đóng tất cả';

  @override
  String get menuEdit => 'Chỉnh sửa';

  @override
  String get menuDelete => 'Xóa';

  @override
  String get menuView => 'Hiển thị';

  @override
  String goToPagePrompt(int total) {
    return 'Nhập số trang (1–$total):';
  }

  @override
  String get goToPageHint => 'Số trang';

  @override
  String get goToPageInvalid => 'Hãy nhập một số hợp lệ';

  @override
  String goToPageOutOfRange(int total) {
    return 'Trang phải nằm trong khoảng từ 1 đến $total';
  }

  @override
  String get menuRotateLeft => 'Xoay sang trái';

  @override
  String get menuRotateRight => 'Xoay sang phải';

  @override
  String get menuCut => 'Cắt';

  @override
  String get menuCopy => 'Sao chép';

  @override
  String get menuPaste => 'Dán';

  @override
  String imagesTooLarge(int count, String limit) {
    return 'Không thêm được: $count ảnh vượt quá $limit';
  }

  @override
  String imagesTooManyPixels(int count, String limit) {
    return 'Không thêm được: $count ảnh vượt quá $limit pixel';
  }

  @override
  String imagesNotAdded(int count) {
    return 'Không thêm được: $count ảnh';
  }

  @override
  String get clipboardUnavailable => 'Không dùng được bảng nháp';

  @override
  String get pasteImageFailed => 'Không thể thêm ảnh này';

  @override
  String get menuQuit => 'Thoát PDFSign';

  @override
  String get closeAllDialogTitle => 'Lưu thay đổi?';

  @override
  String closeAllDialogMessage(int count) {
    return 'Bạn có muốn lưu thay đổi trong $count tài liệu trước khi đóng không?';
  }

  @override
  String get closeAllDialogMessageOne =>
      'Bạn có muốn lưu thay đổi trong 1 tài liệu trước khi đóng không?';

  @override
  String get closeAllDialogSaveAll => 'Lưu tất cả';

  @override
  String get closeAllDialogDontSave => 'Không lưu';

  @override
  String get closeAllDialogCancel => 'Hủy';

  @override
  String get saveFailedDialogTitle => 'Lưu thất bại';

  @override
  String saveFailedDialogMessage(int count) {
    return 'Không thể lưu $count tài liệu. Vẫn đóng?';
  }

  @override
  String get saveFailedDialogClose => 'Vẫn Đóng';

  @override
  String get saveChangesTitle => 'Luu thay doi?';

  @override
  String saveChangesMessage(String fileName) {
    return 'Ban co muon luu thay doi trong \"$fileName\" truoc khi dong?';
  }

  @override
  String get saveButton => 'Luu';

  @override
  String get discardButton => 'Khong luu';

  @override
  String get documentEdited => 'Da chinh sua';

  @override
  String get documentSaved => 'Da luu';

  @override
  String get menuSettings => 'Cai dat...';

  @override
  String get menuWindow => 'Cửa sổ';

  @override
  String get menuMinimize => 'Thu nhỏ';

  @override
  String get menuZoom => 'Phóng to';

  @override
  String get menuBringAllToFront => 'Đưa tất cả ra phía trước';

  @override
  String get settingsTitle => 'Cai dat';

  @override
  String get settingsLanguage => 'Ngon ngu';

  @override
  String get settingsLanguageSystem => 'Mac dinh he thong';

  @override
  String get settingsUnits => 'Don vi';

  @override
  String get settingsUnitsCentimeters => 'Centimet';

  @override
  String get settingsUnitsInches => 'Inch';

  @override
  String get settingsSearchLanguages => 'Tìm kiếm ngôn ngữ...';

  @override
  String get settingsGeneral => 'Chung';

  @override
  String get addImage => 'Thêm hình ảnh';

  @override
  String get selectImages => 'Chọn hình ảnh';

  @override
  String get zoomFitWidth => 'Vừa chiều rộng';

  @override
  String get zoomIn => 'Phóng to';

  @override
  String get zoomOut => 'Thu nhỏ';

  @override
  String get selectZoomLevel => 'Chọn mức thu phóng';

  @override
  String get goToPage => 'Đi đến trang';

  @override
  String get go => 'Đi';

  @override
  String get savePdfAs => 'Lưu PDF thành';

  @override
  String get incorrectPassword => 'Mật khẩu không đúng';

  @override
  String get saveFailed => 'Lưu thất bại';

  @override
  String savedTo(String path) {
    return 'Đã lưu tại: $path';
  }

  @override
  String get noOriginalPdfStored => 'Không có PDF gốc được lưu';

  @override
  String get waitingForFolderPermission => 'Đang chờ quyền truy cập thư mục...';

  @override
  String get deleteButtonLabel => 'Xóa';

  @override
  String get deleteButtonTooltip => 'Xóa đối tượng đã chọn';

  @override
  String get documentProtectedTitle => 'Tài liệu này được bảo vệ';

  @override
  String get documentProtectedBody => 'Hãy nhập mật khẩu để mở tài liệu.';

  @override
  String get passwordFieldLabel => 'Mật khẩu';

  @override
  String get openDocumentButton => 'Mở';

  @override
  String get documentReadOnlyTitle => 'Tài liệu này không cho phép thay đổi';

  @override
  String get documentReadOnlyBody =>
      'Có thể đọc và in tài liệu, nhưng chủ sở hữu không cho phép thay đổi. Hãy nhập mật khẩu của chủ sở hữu để chỉnh sửa.';

  @override
  String get enterOwnerPassword => 'Nhập mật khẩu của chủ sở hữu';

  @override
  String get ownerPasswordFieldLabel => 'Mật khẩu của chủ sở hữu';

  @override
  String get menuPrint => 'In…';

  @override
  String get menuPrintCurrentPage => 'In trang hiện tại';

  @override
  String get printingIsTheOwnersTitle =>
      'Chỉ chủ sở hữu mới có thể in tài liệu này';

  @override
  String get printingNotAllowed => 'Tài liệu này không cho phép in.';

  @override
  String get printingFailed => 'Không thể in tài liệu.';

  @override
  String get protectionIsTheOwnersTitle =>
      'Chỉ chủ sở hữu mới có thể thay đổi bảo vệ của tài liệu này';

  @override
  String get continueButton => 'Tiếp tục';

  @override
  String largeProtectedDocumentBody(String size) {
    return 'Tài liệu được bảo vệ sẽ hiển thị từ bộ nhớ, và tài liệu này có dung lượng $size. Việc mở nó sẽ dùng khoảng chừng ấy bộ nhớ.';
  }

  @override
  String get shareProtectedNotice =>
      'Bản sao được chia sẻ vẫn giữ mật khẩu của tài liệu.';

  @override
  String get unsupportedProtection =>
      'Bảo vệ của tài liệu này không được hỗ trợ. PDFSign mở các tài liệu được bảo vệ bằng mật khẩu, không mở tài liệu được bảo vệ bằng chứng chỉ.';

  @override
  String get menuBringToFront => 'Đưa lên trên cùng';

  @override
  String get menuBringForward => 'Đưa lên trên';

  @override
  String get menuSendBackward => 'Đưa xuống dưới';

  @override
  String get menuSendToBack => 'Đưa xuống dưới cùng';

  @override
  String get zOrderGroupLabel => 'Sắp xếp';

  @override
  String get menuUndo => 'Hoàn tác';

  @override
  String get menuRedo => 'Làm lại';

  @override
  String get dragToReorder => 'Kéo để thay đổi thứ tự';

  @override
  String get protectDocumentTitle => 'Bảo vệ tài liệu';

  @override
  String get requirePasswordToOpen => 'Yêu cầu mật khẩu để mở tài liệu';

  @override
  String get verifyFieldLabel => 'Xác nhận';

  @override
  String get permissionsHeading => 'Quyền';

  @override
  String get permissionsNote =>
      'Cho phép những thay đổi sau mà không cần nhập mật khẩu của chủ sở hữu.';

  @override
  String get permissionPrinting => 'In';

  @override
  String get permissionCopying => 'Sao chép văn bản hoặc đồ họa';

  @override
  String get permissionPageAssembly => 'Chèn, xóa và xoay trang';

  @override
  String get permissionAnnotations => 'Thêm chú thích hoặc chữ ký';

  @override
  String get permissionChangingContent => 'Thay đổi tài liệu';

  @override
  String get permissionFormFilling => 'Điền vào các trường biểu mẫu hiện có';

  @override
  String get changingContentIncludes =>
      'Thay đổi tài liệu bao gồm chú thích và điền biểu mẫu — chúng được cho phép cùng với nó.';

  @override
  String get ownerPasswordHeading => 'Mật khẩu của chủ sở hữu';

  @override
  String get removeProtection => 'Gỡ bảo vệ';

  @override
  String get applyButton => 'Áp dụng';

  @override
  String get passwordsDoNotMatch => 'Mật khẩu không khớp';

  @override
  String get passwordCannotBeEmpty => 'Hãy nhập mật khẩu';

  @override
  String get restrictionsNeedOwnerPassword =>
      'Các hạn chế cần mật khẩu của chủ sở hữu. Không có mật khẩu đó, bất kỳ ai cũng có thể gỡ bỏ chúng.';

  @override
  String get signingNeedsChangingContent =>
      'Nếu không có “Thay đổi tài liệu”, tệp này sẽ không thể được ký lại ở đây nếu thiếu mật khẩu của chủ sở hữu.';

  @override
  String get menuProtectDocument => 'Bảo vệ tài liệu…';

  @override
  String get protectButtonLabel => 'Bảo vệ';

  @override
  String get protectButtonTooltip => 'Đặt mật khẩu và quyền cho tài liệu này';
}
