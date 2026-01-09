import 'package:pdfsign/data/repositories/settings_repository_impl.dart';
import 'package:pdfsign/domain/repositories/settings_repository.dart';
import 'package:pdfsign/presentation/providers/infrastructure/datasource_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

/// Provider for SettingsRepository
///
/// Provides application settings and preferences management.
@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  final dataSource = ref.watch(settingsLocalDataSourceProvider);
  return SettingsRepositoryImpl(dataSource);
}
