import 'package:hive/hive.dart';
part 'income_category_model.g.dart';

@HiveType(typeId: 3)
class IncomeCategory extends HiveObject {
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
  TypeOfIncomeCategory type;

  @HiveField(7)
  String? parentId;

  IncomeCategory(
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
    return 'IncomeCategory(name: $name, assetUid: $assetUid, createdAt: $createdAt, description: $description, orderBy: $orderBy, type: $type, parentId: $parentId)';
  }

  IncomeCategory copyWith({
    String? name,
    String? description,
  }) {
    return IncomeCategory(
      assetUid,
      name: name ?? this.name,
      createdAt: createdAt,
      description: description ?? this.description,
      orderBy: orderBy,
      type: type,
      parentId: parentId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IncomeCategory &&
        other.name == name &&
        other.assetUid == assetUid &&
        other.createdAt == createdAt &&
        other.description == description &&
        other.orderBy == orderBy &&
        other.type == type &&
        other.parentId == parentId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        assetUid.hashCode ^
        createdAt.hashCode ^
        description.hashCode ^
        orderBy.hashCode ^
        type.hashCode ^
        parentId.hashCode;
  }
}

@HiveType(typeId: 4)
enum TypeOfIncomeCategory {
  @HiveField(0)
  main,
  @HiveField(1)
  sub,
}
