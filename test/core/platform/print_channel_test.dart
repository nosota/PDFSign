import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/core/platform/print_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('com.pdfsign/print');
  late List<MethodCall> calls;
  Object? answer;

  setUp(() {
    calls = [];
    answer = 'printed';
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      if (answer is Exception) throw answer! as Object;
      return answer;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  Future<PrintOutcome> print({
    int? firstPage,
    int? lastPage,
    String? password,
  }) =>
      PrintChannel.printDocument(
        bytes: Uint8List.fromList([1, 2, 3]),
        jobName: 'Contract.pdf',
        firstPage: firstPage,
        lastPage: lastPage,
        password: password,
      );

  group('what it sends', () {
    test('should send the document and the name of the job', () async {
      await print();

      final arguments = calls.single.arguments as Map<Object?, Object?>;
      expect(calls.single.method, 'print');
      expect(arguments['bytes'], isA<Uint8List>());
      expect(arguments['jobName'], 'Contract.pdf');
    });

    test('should leave the range out when there is none', () async {
      // Absent means every page, which is what the panel opens on.
      await print();

      final arguments = calls.single.arguments as Map<Object?, Object?>;
      expect(arguments.containsKey('firstPage'), isFalse);
      expect(arguments.containsKey('lastPage'), isFalse);
    });

    test('should send the range it was given', () async {
      await print(firstPage: 4, lastPage: 4);

      final arguments = calls.single.arguments as Map<Object?, Object?>;
      expect(arguments['firstPage'], 4);
      expect(arguments['lastPage'], 4);
    });

    test('should leave the password out when there is none', () async {
      // A password is only ever sent when the document needs one.
      await print();

      expect(
        (calls.single.arguments as Map<Object?, Object?>).containsKey('password'),
        isFalse,
      );
    });
  });

  group('what it makes of the answer', () {
    test('should report a job that was printed', () async {
      answer = 'printed';
      expect(await print(), PrintOutcome.printed);
    });

    test('should report a panel that was closed', () async {
      answer = 'cancelled';
      expect(await print(), PrintOutcome.cancelled);
    });

    test('should report a document that withholds printing', () async {
      answer = 'notAllowed';
      expect(await print(), PrintOutcome.notAllowed);
    });

    test('should report a document the system could not read', () async {
      answer = 'unreadable';
      expect(await print(), PrintOutcome.unreadable);
    });

    test('should treat an answer it does not know as no answer', () async {
      answer = 'something else entirely';
      expect(await print(), PrintOutcome.unavailable);
    });

    test('should survive a platform that is not there', () async {
      answer = MissingPluginException('no print channel');
      expect(await print(), PrintOutcome.unavailable);
    });

    test('should survive a platform that fails', () async {
      answer = PlatformException(code: 'INVALID_ARGUMENT');
      expect(await print(), PrintOutcome.unavailable);
    });
  });
}
