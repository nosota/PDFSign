// Basic widget test for PDFSign app

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pdfsign/main.dart';

void main() {
  testWidgets('App initializes and shows welcome screen', (tester) async {
    // Build app and trigger frame
    await tester.pumpWidget(const PDFSignApp());

    // Wait for async operations
    await tester.pumpAndSettle();

    // Verify welcome screen elements exist
    expect(find.text('PDFSign'), findsOneWidget);
    expect(find.byIcon(Icons.picture_as_pdf), findsWidgets);
  });
}
