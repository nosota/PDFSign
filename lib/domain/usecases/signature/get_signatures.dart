import 'package:pdfsign/core/utils/typedef.dart';
import 'package:pdfsign/domain/entities/signature_item.dart';
import 'package:pdfsign/domain/repositories/signature_repository.dart';

/// Use case for retrieving all signatures from the library
class GetSignatures {
  final SignatureRepository _repository;

  const GetSignatures(this._repository);

  /// Execute the use case
  ResultFuture<List<SignatureItem>> call() async {
    return _repository.getSignatures();
  }
}
