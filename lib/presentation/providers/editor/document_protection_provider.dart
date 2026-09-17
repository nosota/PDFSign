import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pdfsign/domain/entities/document_protection.dart';

part 'document_protection_provider.g.dart';

/// The protection the reader has asked for, not yet written to the file.
///
/// Null means the panel has not been used: whatever protection the document
/// arrived with is what a save will keep.
///
/// Held rather than applied at once for the same reason a page's turn is: a
/// save starts from the bytes the document was read from (ADR-0002), and until
/// it happens the file on disk is still protected the way it was. Confusing
/// the two would mean asking the new password for a file that still wants the
/// old one.
@Riverpod(keepAlive: true)
class PendingProtection extends _$PendingProtection {
  @override
  DocumentProtection? build() => null;

  /// Records what the reader asked the panel for.
  // ignore: use_setters_to_change_properties
  void set(DocumentProtection protection) => state = protection;

  /// Forgets it, leaving the document's own protection to stand.
  void clear() => state = null;
}

/// The protection as of the last write, or null for a document that has not
/// been written in this session.
///
/// The counterpart of `SavedPlacedImages`: it is what the pending protection
/// is measured against, so that a document written and not touched since
/// reports itself clean.
@Riverpod(keepAlive: true)
class SavedProtection extends _$SavedProtection {
  @override
  DocumentProtection? build() => null;

  /// Records [protection] as written to disk.
  // ignore: use_setters_to_change_properties
  void markSaved(DocumentProtection? protection) => state = protection;

  /// Resets to a document whose protection has not been changed here.
  void reset() => state = null;
}

/// Whether the document's protection differs from what was last written.
@Riverpod(keepAlive: true)
bool protectionChanged(ProtectionChangedRef ref) =>
    ref.watch(pendingProtectionProvider) != ref.watch(savedProtectionProvider);
