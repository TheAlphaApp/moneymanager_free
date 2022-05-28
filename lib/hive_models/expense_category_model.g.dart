// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseCategoryAdapter extends TypeAdapter<ExpenseCategory> {
  @override
  final int typeId = 1;

  @override
  ExpenseCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseCategory(
      fields[1] as String,
      name: fields[0] as String,
      createdAt: fields[3] as DateTime,
      description: fields[4] as String,
      orderBy: fields[5] as int,
      type: fields[6] as TypeOfExpenseCategory,
      parentId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseCategory obj) {
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
      other is ExpenseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TypeOfExpenseCategoryAdapter extends TypeAdapter<TypeOfExpenseCategory> {
  @override
  final int typeId = 2;

  @override
  TypeOfExpenseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeOfExpenseCategory.main;
      case 1:
        return TypeOfExpenseCategory.sub;
      default:
        return TypeOfExpenseCategory.main;
    }
  }

  @override
  void write(BinaryWriter writer, TypeOfExpenseCategory obj) {
    switch (obj) {
      case TypeOfExpenseCategory.main:
        writer.writeByte(0);
        break;
      case TypeOfExpenseCategory.sub:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeOfExpenseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
