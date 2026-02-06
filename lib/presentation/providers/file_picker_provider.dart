import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/presentation/providers/last_open_directory_provider.dart';
import 'package:pdfsign/presentation/providers/repository_providers.dart';

part 'file_picker_provider.g.dart';

/// Provider for file picking operations.
///
/// Handles opening the native file picker and returning selected file path.
/// Remembers and restores the last used directory.
@riverpod
class PdfFilePicker extends _$PdfFilePicker {
  @override
  String? build() => null;

  /// Opens file picker and returns selected PDF file path.
  ///
  /// Opens the picker in the last used directory (or ~/Documents if none).
  /// Saves the directory of the selected file for next time.
  /// Returns null if user cancelled the picker.
  /// Throws exception if there was an error.
  Future<String?> pickPdf() async {
    final repository = ref.read(filePickerRepositoryProvider);
    final directoryNotifier = ref.read(lastOpenDirectoryProvider.notifier);

    // Get the directory to open picker in
    final initialDirectory = await directoryNotifier.getDirectoryForPicker();

    final result = await repository.pickPdfFile(
      initialDirectory: initialDirectory,
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (path) {
        if (path != null) {
          // Save directory for next time
          directoryNotifier.saveFromFilePath(path);
        }
        state = path;
        return path;
      },
    );
  }

  /// Checks if a file exists at the given path.
  Future<bool> fileExists(String path) async {
    final repository = ref.read(filePickerRepositoryProvider);
    final result = await repository.fileExists(path);

    return result.fold(
      (failure) => false,
      (exists) => exists,
    );
  }

  /// Clears the selected file state.
  void clear() {
    state = null;
  }
}
