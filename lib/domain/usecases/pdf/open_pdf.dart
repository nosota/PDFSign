import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/domain/repositories/pdf_repository.dart';

/// Use case for opening a PDF file
class OpenPdf {
  final PdfRepository _repository;

  const OpenPdf(this._repository);

  /// Execute the use case
  ///
  /// [path] - Absolute path to the PDF file
  /// [password] - Optional password if the PDF is protected
  ///
  /// Returns the number of pages in the PDF
  ResultFuture<int> call({
    required String path,
    String? password,
  }) async {
    return _repository.openPdf(path: path, password: password);
  }
}
