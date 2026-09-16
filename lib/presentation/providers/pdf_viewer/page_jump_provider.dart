import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_jump_provider.g.dart';

/// A request to bring one page into view.
///
/// Carries a [token] because the same page may be asked for twice in a row,
/// and two identical requests have to be two events: the viewer acts on a
/// change, and without the token the second one would look like no change at
/// all.
class PageJump extends Equatable {
  const PageJump({required this.pageNumber, required this.token});

  /// 1-based page to show.
  final int pageNumber;

  /// Distinguishes one request from the next.
  final int token;

  @override
  List<Object?> get props => [pageNumber, token];
}

/// Asks the viewer to scroll to a page.
///
/// The Go to Page dialog is opened from the menu, which lives at the window
/// root, while the scrolling belongs to the page column deep inside the tree.
/// Rather than reach through the widgets, the root leaves a request here and
/// the viewer picks it up.
@Riverpod(keepAlive: true)
class PageJumpRequest extends _$PageJumpRequest {
  int _issued = 0;

  @override
  PageJump? build() => null;

  /// Asks for [pageNumber] to be brought into view.
  void request(int pageNumber) {
    state = PageJump(pageNumber: pageNumber, token: ++_issued);
  }
}
