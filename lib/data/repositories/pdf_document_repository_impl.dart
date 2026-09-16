import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import 'package:pdfsign/core/errors/exceptions.dart';
import 'package:pdfsign/core/errors/failure.dart';
import 'package:pdfsign/core/errors/failures.dart';
import 'package:pdfsign/data/datasources/pdf_data_source.dart';
import 'package:pdfsign/domain/entities/pdf_document_info.dart';
import 'package:pdfsign/domain/repositories/pdf_document_repository.dart';

/// Implementation of [PdfDocumentRepository] using [PdfDataSource].
class PdfDocumentRepositoryImpl implements PdfDocumentRepository {
  PdfDocumentRepositoryImpl({
    required PdfDataSource dataSource,
  }) : _dataSource = dataSource;

  final PdfDataSource _dataSource;

  @override
  bool get isDocumentLoaded => _dataSource.isDocumentLoaded;

  @override
  PdfDocumentInfo? get currentDocument => _dataSource.currentDocument;

  @override
  Future<Either<Failure, PdfDocumentInfo>> openDocument(String filePath) =>
      _open(() => _dataSource.openDocument(filePath));

  @override
  Future<Either<Failure, PdfDocumentInfo>> openProtectedDocument(
    String filePath,
    String password,
  ) =>
      _open(() => _dataSource.openProtectedDocument(filePath, password));

  /// Runs [open] and turns what it throws into a typed failure.
  ///
  /// Every case here is told apart by the type of what was thrown, never by
  /// looking for words inside a message. The renderer describes a protected
  /// document as "Invalid PDF format", so reading its prose used to send an
  /// encrypted file down the path for a corrupt one.
  Future<Either<Failure, PdfDocumentInfo>> _open(
    Future<PdfDocumentInfo> Function() open,
  ) async {
    try {
      return Right(await open());
    } on PdfPasswordRequiredException catch (e) {
      return e.passwordWasGiven
          ? const Left(PasswordIncorrectFailure())
          : const Left(PasswordRequiredFailure());
    } on PdfUnsupportedProtectionException catch (e) {
      return Left(UnsupportedProtectionFailure(message: e.detail));
    } on PathNotFoundException {
      return const Left(FileNotFoundFailure());
    } on FileSystemException {
      return const Left(FileAccessFailure());
    } on Exception catch (e) {
      return Left(PdfLoadFailure(message: 'Failed to open PDF: $e'));
    }
  }

  @override
  Future<Either<Failure, Uint8List>> renderPage({
    required int pageNumber,
    required double scale,
  }) async {
    try {
      final bytes = await _dataSource.renderPage(
        pageNumber: pageNumber,
        scale: scale,
      );
      return Right(bytes);
    } on RenderCancelledException catch (e) {
      return Left(RenderCancelledFailure(pageNumber: e.pageNumber));
    } on Exception catch (e) {
      return Left(PdfRenderFailure(
        pageNumber: pageNumber,
        message: 'Failed to render page $pageNumber: $e',
      ));
    }
  }

  @override
  void cancelRender(int pageNumber) {
    _dataSource.cancelRender(pageNumber);
  }

  @override
  Future<void> closeDocument() async {
    await _dataSource.closeDocument();
  }
}
