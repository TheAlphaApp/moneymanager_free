import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'out_category_model.g.dart';

@HiveType(typeId: 1)
class OutCategory extends HiveObject {
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
  TypeOfOutCategory type;

  @HiveField(7)
  String? parentId;

  OutCategory(
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
    return 'OutCategory(name: $name, assetUid: $assetUid, createdAt: $createdAt, description: $description, orderBy: $orderBy, type: $type, parentId: $parentId)';
  }
}

@HiveType(typeId: 2)
enum TypeOfOutCategory {
  @HiveField(0)
  main,
  @HiveField(1)
  sub,
}
