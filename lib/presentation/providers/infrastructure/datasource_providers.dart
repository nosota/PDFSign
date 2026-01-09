import 'package:pdfsign/data/datasources/local/settings_local_datasource.dart';
import 'package:pdfsign/presentation/providers/infrastructure/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datasource_providers.g.dart';

/// Provider for SettingsLocalDataSource
///
/// Provides access to application settings stored in SharedPreferences.
@Riverpod(keepAlive: true)
SettingsLocalDataSource settingsLocalDataSource(
  SettingsLocalDataSourceRef ref,
) {
  final prefs = ref.watch(sharedPreferencesProvider).requireValue;
  return SettingsLocalDataSourceImpl(prefs);
}
