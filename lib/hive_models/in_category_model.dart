import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'in_category_model.g.dart';

@HiveType(typeId: 3)
class InCategory extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  final String assetUid;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  String description;

  @HiveField(5)
  int orderBy;

  @HiveField(6)
  TypeOfInCategory type;

  @HiveField(7)
  String? parentId;

  InCategory(
    this.assetUid, {
    required this.name,
    required this.createdAt,
    required this.description,
    required this.orderBy,
    required this.type,
    required this.parentId,
  });

  @override
  String toString() {
    return 'InCategory(name: $name, assetUid: $assetUid, createdAt: $createdAt, description: $description, orderBy: $orderBy, type: $type, parentId: $parentId)\n';
  }

  InCategory copyWith({
    String? name,
    // String? assetUid,
    // DateTime? createdAt,
    String? description,
    // int? orderBy,
    // TypeOfInCategory? type,
    // String? parentId,
  }) {
    return InCategory(
      assetUid,
      name: name ?? this.name,
      createdAt: createdAt,
      description: description ?? this.description,
      orderBy: orderBy,
      type: type,
      parentId: parentId,
    );
  }
}

@HiveType(typeId: 4)
enum TypeOfInCategory {
  @HiveField(0)
  main,
  @HiveField(1)
  sub,
}
