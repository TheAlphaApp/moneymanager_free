import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'asset_model.g.dart';

@HiveType(typeId: 0)
class Asset extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  final String assetUid = const Uuid().v4();

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  String description;

  @HiveField(5)
  int orderBy;

  @HiveField(6)
  String typeId;

  Asset({
    required this.name,
    required this.typeId,
    required this.description,
    required this.orderBy,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Asset(name: $name, createdAt: $createdAt, description: $description, orderBy: $orderBy, typeId: $typeId)';
  }
}
