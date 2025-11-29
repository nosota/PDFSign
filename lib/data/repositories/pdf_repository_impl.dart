import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:pdfsign/core/errors/exceptions.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/data/datasources/storage/pdf_datasource.dart';
import 'package:pdfsign/domain/entities/placed_object.dart';
import 'package:pdfsign/domain/repositories/pdf_repository.dart';

/// Implementation of PdfRepository
class PdfRepositoryImpl implements PdfRepository {
  final PdfDataSource _dataSource;

  const PdfRepositoryImpl(this._dataSource);

  @override
  ResultFuture<int> openPdf({
    required String path,
    String? password,
  }) async {
    try {
      final pageCount = await _dataSource.openPdf(
        path: path,
        password: password,
      );
      return Right(pageCount);
    } on FileNotFoundException catch (e) {
      return Left(FileNotFoundFailure(e.message));
    } on PasswordRequiredException catch (e) {
      return Left(PasswordRequiredFailure(e.message));
    } on PasswordIncorrectException catch (e) {
      return Left(PasswordIncorrectFailure(
        attemptsRemaining: e.attemptsRemaining,
        message: e.message,
      ));
    } on CorruptedPdfException catch (e) {
      return Left(CorruptedPdfFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid closePdf() async {
    try {
      await _dataSource.closePdf();
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<String?> getCurrentPdfPath() async {
    try {
      final path = _dataSource.getCurrentPdfPath();
      return Right(path);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<int> getPageCount() async {
    try {
      final count = _dataSource.getPageCount();
      return Right(count);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<bool> requiresPassword(String path) async {
    try {
      final requires = await _dataSource.requiresPassword(path);
      return Right(requires);
    } on FileNotFoundException catch (e) {
      return Left(FileNotFoundFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<bool> verifyPassword({
    required String path,
    required String password,
  }) async {
    try {
      final isValid = await _dataSource.verifyPassword(
        path: path,
        password: password,
      );
      return Right(isValid);
    } on FileNotFoundException catch (e) {
      return Left(FileNotFoundFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<Uint8List> renderPage({
    required int pageNumber,
    int dpi = 150,
  }) async {
    try {
      final imageData = await _dataSource.renderPage(
        pageNumber: pageNumber,
        dpi: dpi,
      );
      return Right(imageData);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<Size> getPageSize(int pageNumber) async {
    try {
      final size = await _dataSource.getPageSize(pageNumber);
      return Right(size);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFutureVoid savePdf({
    required List<PlacedObject> placedObjects,
    required Map<String, Uint8List> signatureItems,
    String? outputPath,
  }) async {
    try {
      await _dataSource.savePdf(
        placedObjects: placedObjects,
        signatureItems: signatureItems,
        outputPath: outputPath,
      );
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } on SaveException catch (e) {
      return Left(SaveFailure(e.message));
    } on InsufficientSpaceException catch (e) {
      return Left(InsufficientSpaceFailure(e.message));
    } on ReadOnlyLocationException catch (e) {
      return Left(ReadOnlyLocationFailure(e.message));
    } on WriteProtectedException catch (e) {
      return Left(WriteProtectedFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<bool> isWriteProtected() async {
    try {
      final isProtected = await _dataSource.isWriteProtected();
      return Right(isProtected);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<PdfMetadata> getMetadata() async {
    try {
      final metadata = await _dataSource.getMetadata();
      return Right(metadata);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
