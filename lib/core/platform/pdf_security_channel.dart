import 'package:flutter/services.dart';

/// What a PDF file says about its own protection, before anything opens it.
class PdfFileSecurity {
  const PdfFileSecurity({
    required this.isEncrypted,
    required this.needsPassword,
  });

  /// Whether the file carries encryption of any kind.
  ///
  /// True even for a document anyone may read: one that carries only an owner
  /// password, to restrict what may be done with it.
  final bool isEncrypted;

  /// Whether a password must be supplied before the document can be read.
  final bool needsPassword;
}

/// Platform channel for reading a PDF's protection.
///
/// The question has to be put to CoreGraphics rather than to either PDF
/// library in use. The renderer refuses encrypted documents without saying
/// why, and the writer has no public way to report that a document was
/// encrypted at all — for a plain file it reports a default algorithm, which
/// cannot be told from a real one. CoreGraphics is what the renderer answers
/// to, so its verdict is the one that predicts what the renderer will do.
class PdfSecurityChannel {
  PdfSecurityChannel._();

  static const _channel = MethodChannel('com.pdfsign/pdf_security');

  /// Reads the protection on the PDF at [path].
  ///
  /// Returns null when there is no answer — the file is not a PDF the system
  /// can parse, or the platform side is unavailable. A caller that gets null
  /// should go on and let the renderer speak for itself.
  static Future<PdfFileSecurity?> inspect(String path) async {
    try {
      final result =
          await _channel.invokeMapMethod<String, dynamic>('inspect', path);
      if (result == null) return null;

      final isEncrypted = result['isEncrypted'] as bool? ?? false;
      final isUnlocked = result['isUnlocked'] as bool? ?? true;
      return PdfFileSecurity(
        isEncrypted: isEncrypted,
        needsPassword: isEncrypted && !isUnlocked,
      );
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }
}
