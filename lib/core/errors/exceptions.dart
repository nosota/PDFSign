/// Base exception class for the application
class AppException implements Exception {
  final String message;
  final dynamic cause;

  const AppException(this.message, [this.cause]);

  @override
  String toString() => 'AppException: $message${cause != null ? ' ($cause)' : ''}';
}

/// Exception when file is not found
class FileNotFoundException extends AppException {
  const FileNotFoundException([String message = 'File not found', dynamic cause])
      : super(message, cause);
}

/// Exception when file access is denied
class FileAccessException extends AppException {
  const FileAccessException([String message = 'File access denied', dynamic cause])
      : super(message, cause);
}

/// Exception when file format is invalid
class InvalidFileFormatException extends AppException {
  const InvalidFileFormatException([
    String message = 'Invalid file format',
    dynamic cause,
  ]) : super(message, cause);
}

/// Exception when file size exceeds limit
class FileSizeLimitException extends AppException {
  const FileSizeLimitException([
    String message = 'File size exceeds limit',
    dynamic cause,
  ]) : super(message, cause);
}

/// Exception when file resolution exceeds limit
class FileResolutionLimitException extends AppException {
  const FileResolutionLimitException([
    String message = 'File resolution exceeds limit',
    dynamic cause,
  ]) : super(message, cause);
}

/// Exception when password is required
class PasswordRequiredException extends AppException {
  const PasswordRequiredException([
    String message = 'Password required',
    dynamic cause,
  ]) : super(message, cause);
}

/// Exception when password is incorrect
class PasswordIncorrectException extends AppException {
  final int attemptsRemaining;

  const PasswordIncorrectException({
    this.attemptsRemaining = 0,
    String message = 'Incorrect password',
    dynamic cause,
  }) : super(message, cause);
}

/// Exception when PDF is write-protected
class WriteProtectedException extends AppException {
  const WriteProtectedException([
    String message = 'PDF is write-protected',
    dynamic cause,
  ]) : super(message, cause);
}

/// Exception when PDF is corrupted
class CorruptedPdfException extends AppException {
  const CorruptedPdfException([
    String message = 'PDF is corrupted',
    dynamic cause,
  ]) : super(message, cause);
}

/// Exception when storage operation fails
class StorageException extends AppException {
  const StorageException([String message = 'Storage operation failed', dynamic cause])
      : super(message, cause);
}

/// Exception when save operation fails
class SaveException extends AppException {
  const SaveException([String message = 'Failed to save file', dynamic cause])
      : super(message, cause);
}

/// Exception when there's insufficient disk space
class InsufficientSpaceException extends AppException {
  const InsufficientSpaceException([
    String message = 'Insufficient disk space',
    dynamic cause,
  ]) : super(message, cause);
}

/// Exception when trying to save to read-only location
class ReadOnlyLocationException extends AppException {
  const ReadOnlyLocationException([
    String message = 'Cannot save to read-only location',
    dynamic cause,
  ]) : super(message, cause);
}

/// Exception when out of memory
class OutOfMemoryException extends AppException {
  const OutOfMemoryException([String message = 'Out of memory', dynamic cause])
      : super(message, cause);
}

/// Exception when database operation fails
class DatabaseException extends AppException {
  const DatabaseException([String message = 'Database operation failed', dynamic cause])
      : super(message, cause);
}

/// Exception when cache operation fails
class CacheException extends AppException {
  const CacheException([String message = 'Cache operation failed', dynamic cause])
      : super(message, cause);
}

/// Exception when validation fails
class ValidationException extends AppException {
  const ValidationException([String message = 'Validation failed', dynamic cause])
      : super(message, cause);
}

/// Exception when network operation fails (currently not used but included for future)
class NetworkException extends AppException {
  const NetworkException([String message = 'Network operation failed', dynamic cause])
      : super(message, cause);
}