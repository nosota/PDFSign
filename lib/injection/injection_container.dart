/// Dependency Injection Container
///
/// NOTE: This project uses Riverpod for dependency injection.
/// Riverpod providers handle DI automatically via @riverpod annotation.
///
/// This file is kept for backwards compatibility and potential
/// future needs for non-Riverpod dependencies.
///
/// To add a new dependency:
/// 1. Create a provider with @riverpod annotation
/// 2. Define the dependency creation logic in the provider
/// 3. Use ref.watch() or ref.read() to access dependencies
///
/// Example:
/// ```dart
/// @riverpod
/// MyRepository myRepository(MyRepositoryRef ref) {
///   final dataSource = ref.watch(myDataSourceProvider);
///   return MyRepositoryImpl(dataSource);
/// }
/// ```
library injection_container;
