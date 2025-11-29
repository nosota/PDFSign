import 'package:dartz/dartz.dart';
import 'package:pdfsign/core/errors/failures.dart';

/// Type alias for result pattern with Either
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// Type alias for synchronous result pattern
typedef ResultVoid = Either<Failure, void>;

/// Type alias for future void result
typedef ResultFutureVoid = Future<Either<Failure, void>>;

/// Type alias for data maps
typedef DataMap = Map<String, dynamic>;
