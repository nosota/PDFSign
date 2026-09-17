import 'dart:typed_data';

import 'package:flutter/services.dart';

/// What came of asking to print.
enum PrintOutcome {
  /// The job went to the printer.
  printed,

  /// The reader closed the panel without printing.
  cancelled,

  /// The document withholds printing from whoever opened it.
  notAllowed,

  /// The system could not read the document, or the password did not fit.
  unreadable,

  /// The platform side did not answer at all.
  unavailable,
}

/// Platform channel for printing a document held in memory.
///
/// The bytes go to macOS as they are: printing is the one thing this app hands
/// to the system whole, because the panel it shows for a PDF already carries
/// copies, page range, paper, orientation, scaling, layout and a preview, and
/// the printer's own settings besides.
///
/// Nothing is written to a file on the way. A protected document is decrypted
/// only in memory (ADR-0011); what the printing system spools afterwards is
/// its own business, exactly as it is for any other app.
class PrintChannel {
  PrintChannel._();

  static const _channel = MethodChannel('com.pdfsign/print');

  /// Shows the print panel for [bytes] and answers what came of it.
  ///
  /// [jobName] is what the print queue shows — the document's file name.
  ///
  /// [password] opens [bytes] when they are protected; the owner's raises the
  /// rights, which is what lets whoever owns a document print it however its
  /// permissions read.
  ///
  /// [firstPage] and [lastPage] pre-fill the panel's range; both null leaves
  /// it at every page.
  static Future<PrintOutcome> printDocument({
    required Uint8List bytes,
    required String jobName,
    int? firstPage,
    int? lastPage,
    String? password,
  }) async {
    try {
      final outcome = await _channel.invokeMethod<String>('print', {
        'bytes': bytes,
        'jobName': jobName,
        if (firstPage != null) 'firstPage': firstPage,
        if (lastPage != null) 'lastPage': lastPage,
        if (password != null) 'password': password,
      });

      return switch (outcome) {
        'printed' => PrintOutcome.printed,
        'cancelled' => PrintOutcome.cancelled,
        'notAllowed' => PrintOutcome.notAllowed,
        'unreadable' => PrintOutcome.unreadable,
        _ => PrintOutcome.unavailable,
      };
    } on PlatformException {
      return PrintOutcome.unavailable;
    } on MissingPluginException {
      return PrintOutcome.unavailable;
    }
  }
}
