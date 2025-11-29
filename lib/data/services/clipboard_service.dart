import 'dart:async';
import 'dart:typed_data';

import 'package:super_clipboard/super_clipboard.dart';

/// Service for clipboard operations with images
class ClipboardService {
  /// Copy image data to clipboard
  Future<bool> copyImage(Uint8List imageData) async {
    try {
      final clipboard = SystemClipboard.instance;
      if (clipboard == null) return false;

      final item = DataWriterItem();
      item.add(Formats.png(imageData));

      await clipboard.write([item]);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Check if clipboard has image data
  Future<bool> hasImage() async {
    try {
      final clipboard = SystemClipboard.instance;
      if (clipboard == null) return false;

      final reader = await clipboard.read();
      return reader.canProvide(Formats.png) || reader.canProvide(Formats.jpeg);
    } catch (e) {
      return false;
    }
  }

  /// Read image data from clipboard
  Future<Uint8List?> readImage() async {
    try {
      final clipboard = SystemClipboard.instance;
      if (clipboard == null) return null;

      final reader = await clipboard.read();

      // Try PNG first
      if (reader.canProvide(Formats.png)) {
        final completer = Completer<Uint8List?>();
        final progress = reader.getFile(
          Formats.png,
          (file) async {
            try {
              final data = await file.readAll();
              completer.complete(data);
            } catch (e) {
              completer.complete(null);
            }
          },
          onError: (error) {
            completer.complete(null);
          },
        );
        if (progress != null) {
          final data = await completer.future;
          if (data != null) return data;
        }
      }

      // Try JPEG
      if (reader.canProvide(Formats.jpeg)) {
        final completer = Completer<Uint8List?>();
        final progress = reader.getFile(
          Formats.jpeg,
          (file) async {
            try {
              final data = await file.readAll();
              completer.complete(data);
            } catch (e) {
              completer.complete(null);
            }
          },
          onError: (error) {
            completer.complete(null);
          },
        );
        if (progress != null) {
          final data = await completer.future;
          if (data != null) return data;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get MIME type from clipboard image
  Future<String?> getImageMimeType() async {
    try {
      final clipboard = SystemClipboard.instance;
      if (clipboard == null) return null;

      final reader = await clipboard.read();

      if (reader.canProvide(Formats.png)) {
        return 'image/png';
      } else if (reader.canProvide(Formats.jpeg)) {
        return 'image/jpeg';
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
