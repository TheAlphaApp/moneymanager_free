// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'out_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutCategoryAdapter extends TypeAdapter<OutCategory> {
  @override
  final int typeId = 1;

  @override
  OutCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OutCategory(
      fields[1] as String,
      name: fields[0] as String,
      createdAt: fields[3] as DateTime,
      description: fields[4] as String,
      orderBy: fields[5] as int,
      type: fields[6] as TypeOfOutCategory,
      parentId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OutCategory obj) {
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
      other is OutCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TypeOfOutCategoryAdapter extends TypeAdapter<TypeOfOutCategory> {
  @override
  final int typeId = 2;

  @override
  TypeOfOutCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeOfOutCategory.main;
      case 1:
        return TypeOfOutCategory.sub;
      default:
        return TypeOfOutCategory.main;
    }
  }

  @override
  void write(BinaryWriter writer, TypeOfOutCategory obj) {
    switch (obj) {
      case TypeOfOutCategory.main:
        writer.writeByte(0);
        break;
      case TypeOfOutCategory.sub:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeOfOutCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
