import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/page_jump_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  PageJumpRequest notifier() => container.read(pageJumpRequestProvider.notifier);

  PageJump? current() => container.read(pageJumpRequestProvider);

  test('should start with nothing asked for', () {
    expect(current(), isNull);
  });

  test('should carry the page that was asked for', () {
    notifier().request(7);
    expect(current()?.pageNumber, 7);
  });

  test('should make two requests for the same page distinguishable', () {
    // The viewer acts on a change. Without something to tell one request from
    // the next, asking for the same page twice would look like no change at
    // all and the second ask would be ignored.
    notifier().request(6);
    final first = current();

    notifier().request(6);

    expect(current(), isNot(first));
    expect(current()?.pageNumber, 6);
  });

  test('should compare equal to itself', () {
    notifier().request(3);
    final held = current();
    expect(held, current());
  });
}
