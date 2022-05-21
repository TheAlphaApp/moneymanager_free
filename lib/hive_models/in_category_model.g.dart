// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InCategoryAdapter extends TypeAdapter<InCategory> {
  @override
  final int typeId = 3;

  @override
  InCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InCategory(
      fields[1] as String,
      name: fields[0] as String,
      createdAt: fields[3] as DateTime,
      description: fields[4] as String,
      orderBy: fields[5] as int,
      type: fields[6] as TypeOfInCategory,
      parentId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InCategory obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.assetUid)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.orderBy)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.parentId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TypeOfInCategoryAdapter extends TypeAdapter<TypeOfInCategory> {
  @override
  final int typeId = 4;

  @override
  TypeOfInCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeOfInCategory.main;
      case 1:
        return TypeOfInCategory.sub;
      default:
        return TypeOfInCategory.main;
    }
  }

  @override
  void write(BinaryWriter writer, TypeOfInCategory obj) {
    switch (obj) {
      case TypeOfInCategory.main:
        writer.writeByte(0);
        break;
      case TypeOfInCategory.sub:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeOfInCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
