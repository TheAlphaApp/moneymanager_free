import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager_free/hive_models/expense_category_model.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';

final expenseCategoryProvider = ChangeNotifierProvider<ExpenseCategoryDB>((ref) {
  return ExpenseCategoryDB();
});

class ExpenseCategoryDB extends ChangeNotifier {
  ExpenseCategoryDB._privateConstructor();
  static final ExpenseCategoryDB _instance = ExpenseCategoryDB._privateConstructor();
  factory ExpenseCategoryDB() {
    return _instance;
  }

  final _box = Hive.box<ExpenseCategory>(expenseCategoryBoxName);

  List<ExpenseCategory> getInMainCategory() {
    return _box.values
        .where((element) => element.type == TypeOfExpenseCategory.main)
        .toList();
  }

  Future<void> updateItem(ExpenseCategory inCategory) async {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k)?.assetUid == inCategory.assetUid,
      orElse: () => null,
    );
    await _box.put(key, inCategory);
    notifyListeners();
  }

  Future<void> add(
      {required String name,
      required String description,
      String? parentId}) async {
    ExpenseCategory exCategory = ExpenseCategory(
      const Uuid().v4(),
      name: name,
      description: description,
      parentId: parentId,
      createdAt: DateTime.now(),
      type: parentId != null
          ? TypeOfExpenseCategory.sub
          : TypeOfExpenseCategory.main,
      orderBy: 0,
    );
    await _box.add(exCategory);
    notifyListeners();
  }

  List<ExpenseCategory> getInSubCategory(String parentId) {
    return _box.values
        .where((element) =>
            element.type == TypeOfExpenseCategory.sub &&
            element.parentId == parentId)
        .toList();
  }

  Future<void> deleteItem(ExpenseCategory inCategory) async {
    final item = _box.values.firstWhere((element) =>
        element.assetUid == inCategory.assetUid &&
        element.name == inCategory.name);
    if (item.parentId == null) {
      final listOfSubItem = _box.values.where((element) =>
          element.type == TypeOfExpenseCategory.sub &&
          element.parentId == inCategory.assetUid);

      for (var element in listOfSubItem) {
        await _box.delete(element.key);
      }
    }

    print('deleted: ${item.toString()}');
    await _box.delete(item.key);
    print(_box.toMap());
    notifyListeners();
  }
}
