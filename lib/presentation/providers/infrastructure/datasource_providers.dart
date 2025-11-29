import 'package:pdfsign/data/datasources/local/settings_local_datasource.dart';
import 'package:pdfsign/data/datasources/local/signature_local_datasource.dart';
import 'package:pdfsign/data/datasources/storage/pdf_datasource.dart';
import 'package:pdfsign/presentation/providers/infrastructure/isar_provider.dart';
import 'package:pdfsign/presentation/providers/infrastructure/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datasource_providers.g.dart';

/// Provider for SignatureLocalDataSource
///
/// Provides access to signature and stamp data stored in Isar database.
@Riverpod(keepAlive: true)
SignatureLocalDataSource signatureLocalDataSource(
  SignatureLocalDataSourceRef ref,
) {
  final isar = ref.watch(isarProvider).requireValue;
  return SignatureLocalDataSourceImpl(isar);
}

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

/// Provider for PdfDataSource
///
/// Provides PDF operations using Syncfusion PDF library.
/// Note: This is not kept alive as it manages document lifecycle.
@riverpod
PdfDataSource pdfDataSource(PdfDataSourceRef ref) {
  return PdfDataSourceImpl();
}
