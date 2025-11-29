import 'package:pdfsign/data/repositories/pdf_repository_impl.dart';
import 'package:pdfsign/data/repositories/settings_repository_impl.dart';
import 'package:pdfsign/data/repositories/signature_repository_impl.dart';
import 'package:pdfsign/domain/repositories/pdf_repository.dart';
import 'package:pdfsign/domain/repositories/settings_repository.dart';
import 'package:pdfsign/domain/repositories/signature_repository.dart';
import 'package:pdfsign/presentation/providers/infrastructure/datasource_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

/// Provider for SignatureRepository
///
/// Provides signature and stamp management operations with error handling.
@Riverpod(keepAlive: true)
SignatureRepository signatureRepository(SignatureRepositoryRef ref) {
  final dataSource = ref.watch(signatureLocalDataSourceProvider);
  return SignatureRepositoryImpl(dataSource);
}

/// Provider for SettingsRepository
///
/// Provides application settings and preferences management.
@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  final dataSource = ref.watch(settingsLocalDataSourceProvider);
  return SettingsRepositoryImpl(dataSource);
}

/// Provider for PdfRepository
///
/// Provides PDF document operations with error handling.
@riverpod
PdfRepository pdfRepository(PdfRepositoryRef ref) {
  final dataSource = ref.watch(pdfDataSourceProvider);
  return PdfRepositoryImpl(dataSource);
}
