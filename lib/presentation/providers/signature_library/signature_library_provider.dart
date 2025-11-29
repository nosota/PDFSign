import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:pdfsign/domain/repositories/signature_repository.dart';

part 'signature_library_provider.g.dart';

/// Provider for signature repository
@riverpod
SignatureRepository signatureRepository(SignatureRepositoryRef ref) {
  throw UnimplementedError('SignatureRepository implementation not provided');
}

/// State notifier for managing signatures
@riverpod
class Signatures extends _$Signatures {
  @override
  Future<List<SignatureItem>> build() async {
    final repository = ref.watch(signatureRepositoryProvider);
    final result = await repository.getSignatures();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (signatures) => signatures,
    );
  }

  /// Add a new signature
  Future<void> addSignature({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  }) async {
    final repository = ref.read(signatureRepositoryProvider);
    final result = await repository.addSignature(
      imageData: imageData,
      name: name,
      originalFileName: originalFileName,
      mimeType: mimeType,
    );

    result.fold(
      (failure) => throw Exception(failure.message),
      (signature) {
        state = AsyncData([...?state.value, signature]);
      },
    );
  }

  /// Update signature
  Future<void> updateSignature(SignatureItem item) async {
    final repository = ref.read(signatureRepositoryProvider);
    final result = await repository.updateItem(item);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = AsyncData(
          state.value?.map((s) => s.id == item.id ? item : s).toList() ?? [],
        );
      },
    );
  }

  /// Delete signature
  Future<void> deleteSignature(String id) async {
    final repository = ref.read(signatureRepositoryProvider);
    final result = await repository.deleteItem(id);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = AsyncData(
          state.value?.where((s) => s.id != id).toList() ?? [],
        );
      },
    );
  }

  /// Reorder signatures
  Future<void> reorderSignatures(List<SignatureItem> items) async {
    final repository = ref.read(signatureRepositoryProvider);
    final result = await repository.reorderItems(items);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = AsyncData(items);
      },
    );
  }
}

/// State notifier for managing stamps
@riverpod
class Stamps extends _$Stamps {
  @override
  Future<List<SignatureItem>> build() async {
    final repository = ref.watch(signatureRepositoryProvider);
    final result = await repository.getStamps();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (stamps) => stamps,
    );
  }

  /// Add a new stamp
  Future<void> addStamp({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  }) async {
    final repository = ref.read(signatureRepositoryProvider);
    final result = await repository.addStamp(
      imageData: imageData,
      name: name,
      originalFileName: originalFileName,
      mimeType: mimeType,
    );

    result.fold(
      (failure) => throw Exception(failure.message),
      (stamp) {
        state = AsyncData([...?state.value, stamp]);
      },
    );
  }

  /// Update stamp
  Future<void> updateStamp(SignatureItem item) async {
    final repository = ref.read(signatureRepositoryProvider);
    final result = await repository.updateItem(item);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = AsyncData(
          state.value?.map((s) => s.id == item.id ? item : s).toList() ?? [],
        );
      },
    );
  }

  /// Delete stamp
  Future<void> deleteStamp(String id) async {
    final repository = ref.read(signatureRepositoryProvider);
    final result = await repository.deleteItem(id);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = AsyncData(
          state.value?.where((s) => s.id != id).toList() ?? [],
        );
      },
    );
  }

  /// Reorder stamps
  Future<void> reorderStamps(List<SignatureItem> items) async {
    final repository = ref.read(signatureRepositoryProvider);
    final result = await repository.reorderItems(items);

    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state = AsyncData(items);
      },
    );
  }
}
