import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pdfsign/injection/injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)

/// Initialize dependency injection
Future<void> configureDependencies() async => getIt.init();

/// Reset all dependencies (mainly for testing)
Future<void> resetDependencies() async {
  await getIt.reset();
}
