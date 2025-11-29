import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:pdfsign/core/errors/exceptions.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/data/datasources/local/signature_local_datasource.dart';
import 'package:pdfsign/data/models/signature_item_model.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:pdfsign/domain/repositories/signature_repository.dart';

/// Implementation of SignatureRepository
class SignatureRepositoryImpl implements SignatureRepository {
  final SignatureLocalDataSource _localDataSource;

  const SignatureRepositoryImpl(this._localDataSource);

  @override
  ResultFuture<List<SignatureItem>> getSignatures() async {
    try {
      final models = await _localDataSource.getSignatures();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<SignatureItem>> getStamps() async {
    try {
      final models = await _localDataSource.getStamps();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<SignatureItem> getItemById(String id) async {
    try {
      final model = await _localDataSource.getItemById(id);
      if (model == null) {
        return const Left(FileNotFoundFailure('Item not found'));
      }
      return Right(model.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<SignatureItem> addSignature({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  }) async {
    try {
      final model = await _localDataSource.addSignature(
        imageData: imageData,
        name: name,
        originalFileName: originalFileName,
        mimeType: mimeType,
      );
      return Right(model.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<SignatureItem> addStamp({
    required Uint8List imageData,
    required String name,
    required String originalFileName,
    required String mimeType,
  }) async {
    try {
      final model = await _localDataSource.addStamp(
        imageData: imageData,
        name: name,
        originalFileName: originalFileName,
        mimeType: mimeType,
      );
      return Right(model.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid updateItem(SignatureItem item) async {
    try {
      final model = await _localDataSource.getItemById(item.id);
      if (model == null) {
        return const Left(FileNotFoundFailure('Item not found'));
      }

      // Update model fields
      model
        ..name = item.name
        ..imageData = item.imageData.toList()
        ..order = item.order
        ..mimeType = item.mimeType
        ..originalFileName = item.originalFileName;

      await _localDataSource.updateItem(model);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid deleteItem(String id) async {
    try {
      await _localDataSource.deleteItem(id);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid reorderItems(List<SignatureItem> items) async {
    try {
      final models = items.map((item) {
        return _localDataSource.getItemById(item.id);
      }).toList();

      final resolvedModels = await Future.wait(models);
      final nonNullModels = resolvedModels.whereType<SignatureItemModel>().toList();

      // Update order
      for (var i = 0; i < nonNullModels.length; i++) {
        nonNullModels[i].order = i;
      }

      await _localDataSource.reorderItems(nonNullModels);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<int> getNextOrder(SignatureType type) async {
    try {
      final order = await _localDataSource.getNextOrder(type);
      return Right(order);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<List<SignatureItem>> watchSignatures() {
    try {
      return _localDataSource
          .watchSignatures()
          .map((models) => models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Stream.error(DatabaseFailure(e.toString()));
    }
  }

  @override
  Stream<List<SignatureItem>> watchStamps() {
    try {
      return _localDataSource
          .watchStamps()
          .map((models) => models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Stream.error(DatabaseFailure(e.toString()));
    }
  }
}
