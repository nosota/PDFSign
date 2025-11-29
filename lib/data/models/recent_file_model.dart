import 'package:isar/isar.dart';
import 'package:pdfsign/domain/entities/recent_file.dart';

part 'recent_file_model.g.dart';

@collection
class RecentFileModel {
  // Unnamed constructor required by Isar
  RecentFileModel();

  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String path;

  late String fileName;

  @Index()
  late DateTime lastOpened;

  late int pageCount;

  late bool isPasswordProtected;

  /// Convert to domain entity
  RecentFile toEntity() {
    return RecentFile(
      path: path,
      fileName: fileName,
      lastOpened: lastOpened,
      pageCount: pageCount,
      isPasswordProtected: isPasswordProtected,
    );
  }

  /// Create from domain entity
  factory RecentFileModel.fromEntity(RecentFile entity) {
    return RecentFileModel()
      ..path = entity.path
      ..fileName = entity.fileName
      ..lastOpened = entity.lastOpened
      ..pageCount = entity.pageCount
      ..isPasswordProtected = entity.isPasswordProtected;
  }

  /// Create new model
  factory RecentFileModel.create({
    required String path,
    required String fileName,
    required DateTime lastOpened,
    required int pageCount,
    required bool isPasswordProtected,
  }) {
    return RecentFileModel()
      ..path = path
      ..fileName = fileName
      ..lastOpened = lastOpened
      ..pageCount = pageCount
      ..isPasswordProtected = isPasswordProtected;
  }
}
