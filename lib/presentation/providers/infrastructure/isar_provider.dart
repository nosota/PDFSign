import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfsign/data/models/recent_file_model.dart';
import 'package:pdfsign/data/models/signature_item_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_provider.g.dart';

/// Provider for Isar database instance
///
/// This provider initializes the Isar database with all schemas
/// and ensures it's properly configured for the application.
@Riverpod(keepAlive: true)
Future<Isar> isar(IsarRef ref) async {
  // Get application documents directory
  final dir = await getApplicationDocumentsDirectory();

  // Open Isar database with schemas
  final isar = await Isar.open(
    [
      SignatureItemModelSchema,
      RecentFileModelSchema,
    ],
    directory: dir.path,
    name: 'pdfsign',
  );

  // Register dispose callback to close database when provider is disposed
  ref.onDispose(() {
    isar.close();
  });

  return isar;
}
