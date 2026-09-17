import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pdfsign/core/platform/print_channel.dart';
import 'package:pdfsign/domain/entities/document_protection.dart';
import 'package:pdfsign/domain/entities/document_security.dart';
import 'package:pdfsign/presentation/providers/editor/document_protection_provider.dart';
import 'package:pdfsign/presentation/providers/editor/original_pdf_provider.dart';
import 'package:pdfsign/presentation/providers/editor/pdf_save_service_provider.dart';
import 'package:pdfsign/presentation/providers/editor/placed_images_provider.dart';
import 'package:pdfsign/presentation/providers/pdf_viewer/pdf_document_provider.dart';

/// How much of the document the reader asked for.
enum PrintScope {
  /// Every page, which is what the panel opens on.
  wholeDocument,

  /// The page in view, pre-filled as the panel's range.
  currentPage,
}

/// Whether printing is the reader's to do.
///
/// A document may be read and still withhold printing. Whoever holds the owner
/// password may print it anyway, which is the same rule the rest of the app
/// follows, and a protection the reader has just set here is theirs by
/// definition: they typed the owner password into the panel.
bool mayPrint(DocumentSecurity security, DocumentProtection? pending) {
  if (security.hasOwnerRights || pending != null) return true;
  final protection = pending ?? security.current;
  if (protection == null) return true;
  return protection.permissions.contains(DocumentPermission.printing);
}

/// Prints the document as the reader sees it.
///
/// Composes the same bytes a save would write — objects embedded, pages turned
/// — and hands them to the system's print panel. Nothing is written to disk on
/// the way (ADR-0011).
///
/// Returns what came of it, so the caller can say so in the reader's language.
/// [PrintOutcome.cancelled] is silent by design: closing the panel is an
/// ordinary thing to do.
///
/// A top-level helper rather than a method on a notifier because it reads four
/// providers and writes none, which is where `CLAUDE.md` puts this work.
Future<PrintOutcome> printDocument(
  WidgetRef ref, {
  PrintScope scope = PrintScope.wholeDocument,
}) async {
  final state = ref.read(pdfDocumentProvider);
  final document = state.documentOrNull;
  if (document == null) return PrintOutcome.unavailable;

  final pending = ref.read(pendingProtectionProvider);
  if (!mayPrint(document.security, pending)) return PrintOutcome.notAllowed;

  final storage = ref.read(originalPdfStorageProvider);
  if (!storage.hasData) return PrintOutcome.unavailable;

  final composed = await ref.read(pdfSaveServiceProvider).composePdfBytes(
        originalBytes: await storage.getBytes(),
        placedImages: ref.read(placedImagesProvider),
        pages: document.pages,
        password: document.security.password,
        protection: pending,
      );

  return composed.fold(
    (_) async => PrintOutcome.unreadable,
    (bytes) async {
      final page = scope == PrintScope.currentPage ? state.currentPageOrNull : null;
      return PrintChannel.printDocument(
        bytes: bytes,
        jobName: document.fileName,
        firstPage: page,
        lastPage: page,
        password: passwordFor(document.security, pending),
      );
    },
  );
}

/// The password that opens the composed document.
///
/// The composed bytes carry whatever protection the saved file would: the
/// document's own, or the one the reader has asked for and not yet saved. The
/// owner password comes first — it is what lets an owner print a document
/// whose permissions withhold printing from everybody else.
String? passwordFor(DocumentSecurity security, DocumentProtection? pending) {
  if (pending == null) return security.password;
  if (pending.ownerPassword.isNotEmpty) return pending.ownerPassword;
  if (pending.userPassword.isNotEmpty) return pending.userPassword;
  return null;
}
