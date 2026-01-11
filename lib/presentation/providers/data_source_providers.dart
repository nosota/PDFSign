import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/data/datasources/file_picker_data_source.dart';
import 'package:pdfsign/data/datasources/recent_files_local_data_source.dart';
import 'package:pdfsign/presentation/providers/shared_preferences_provider.dart';

part 'data_source_providers.g.dart';

/// Provider for [RecentFilesLocalDataSource].
@riverpod
RecentFilesLocalDataSource recentFilesLocalDataSource(
  RecentFilesLocalDataSourceRef ref,
) {
  final prefs = ref.watch(sharedPreferencesProvider).requireValue;
  return RecentFilesLocalDataSourceImpl(prefs);
}

/// Provider for [FilePickerDataSource].
@riverpod
FilePickerDataSource filePickerDataSource(FilePickerDataSourceRef ref) {
  return FilePickerDataSourceImpl();
}
