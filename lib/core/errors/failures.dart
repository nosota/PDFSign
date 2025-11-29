import 'package:equatable/equatable.dart';

/// Abstract class representing a failure in the application.
/// All failures should extend this class.
abstract class Failure extends Equatable {
  /// Message describing the failure
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Failure when a file is not found
class FileNotFoundFailure extends Failure {
  const FileNotFoundFailure([super.message = 'File not found']);
}

/// Failure when file access is denied
class FileAccessFailure extends Failure {
  const FileAccessFailure([super.message = 'File access denied']);
}

/// Failure when file format is invalid
class InvalidFileFormatFailure extends Failure {
  const InvalidFileFormatFailure([
    super.message = 'Invalid file format',
  ]);
}

/// Failure when file size exceeds limit
class FileSizeLimitFailure extends Failure {
  const FileSizeLimitFailure([
    super.message = 'File size exceeds limit',
  ]);
}

/// Failure when file resolution exceeds limit
class FileResolutionLimitFailure extends Failure {
  const FileResolutionLimitFailure([
    super.message = 'File resolution exceeds limit',
  ]);
}

/// Failure when password is required
class PasswordRequiredFailure extends Failure {
  const PasswordRequiredFailure([
    super.message = 'Password required',
  ]);
}

/// Failure when password is incorrect
class PasswordIncorrectFailure extends Failure {
  final int attemptsRemaining;

  const PasswordIncorrectFailure({
    this.attemptsRemaining = 0,
    String message = 'Incorrect password',
  }) : super(message);

  @override
  List<Object?> get props => [message, attemptsRemaining];
}

/// Failure when PDF is write-protected
class WriteProtectedFailure extends Failure {
  const WriteProtectedFailure([
    super.message = 'PDF is write-protected',
  ]);
}

/// Failure when PDF is corrupted
class CorruptedPdfFailure extends Failure {
  const CorruptedPdfFailure([
    super.message = 'PDF is corrupted',
  ]);
}

/// Failure when storage operation fails
class StorageFailure extends Failure {
  const StorageFailure([super.message = 'Storage operation failed']);
}

/// Failure when save operation fails
class SaveFailure extends Failure {
  const SaveFailure([super.message = 'Failed to save file']);
}

/// Failure when there's insufficient disk space
class InsufficientSpaceFailure extends Failure {
  const InsufficientSpaceFailure([
    super.message = 'Insufficient disk space',
  ]);
}

/// Failure when trying to save to read-only location
class ReadOnlyLocationFailure extends Failure {
  const ReadOnlyLocationFailure([
    super.message = 'Cannot save to read-only location',
  ]);
}

/// Failure when out of memory
class OutOfMemoryFailure extends Failure {
  const OutOfMemoryFailure([super.message = 'Out of memory']);
}

/// Failure when database operation fails
class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'Database operation failed']);
}

/// Generic unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unknown error occurred']);
}

/// Failure when validation fails
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}

/// Failure when operation is cancelled by user
class CancelledFailure extends Failure {
  const CancelledFailure([super.message = 'Operation cancelled']);
}