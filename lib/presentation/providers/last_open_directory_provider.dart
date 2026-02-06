import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';

const _key = 'last_open_directory';

/// Default directory for file picker when no previous directory is saved.
String get _defaultDirectory {
  final home = Platform.environment['HOME'] ?? '/';
  return path.join(home, 'Documents');
}

/// Provider for managing the last used directory in File->Open dialog.
///
/// Persists the path in SharedPreferences.
/// Falls back to ~/Documents if saved directory doesn't exist.
final lastOpenDirectoryProvider =
    NotifierProvider<LastOpenDirectoryNotifier, String?>(
  LastOpenDirectoryNotifier.new,
);

/// Notifier for last open directory state.
class LastOpenDirectoryNotifier extends Notifier<String?> {
  @override
  String? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString(_key);
  }

  /// Gets the directory to use for file picker.
  ///
  /// Returns saved directory if it exists, otherwise ~/Documents.
  Future<String> getDirectoryForPicker() async {
    final saved = state;

    if (saved != null && saved.isNotEmpty) {
      // Check if directory still exists
      final dir = Directory(saved);
      if (await dir.exists()) {
        return saved;
      }
    }

    // Fall back to default
    return _defaultDirectory;
  }

  /// Saves the directory from a selected file path.
  ///
  /// Extracts the parent directory from the file path and saves it.
  void saveFromFilePath(String filePath) {
    final directory = path.dirname(filePath);
    _save(directory);
  }

  /// Saves the directory path.
  void _save(String directory) {
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setString(_key, directory);
    state = directory;
  }
}
