import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:moneymanager_free/hive_models/in_category_model.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';

final incomeCategoryProvider = ChangeNotifierProvider<InCategoryDB>((ref) {
  return InCategoryDB();
});

class InCategoryDB extends ChangeNotifier {
  InCategoryDB._privateConstructor();
  static final InCategoryDB _instance = InCategoryDB._privateConstructor();
  factory InCategoryDB() {
    return _instance;
  }

  final _box = Hive.box<InCategory>(inCategoryBoxName);

  List<InCategory> getInMainCategory() {
    return _box.values
        .where((element) => element.type == TypeOfInCategory.main)
        .toList();
  }

  Future<void> updateItem(InCategory inCategory) async {
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
    InCategory inCategory = InCategory(
      const Uuid().v4(),
      name: name,
      description: description,
      parentId: parentId,
      createdAt: DateTime.now(),
      type: parentId != null ? TypeOfInCategory.sub : TypeOfInCategory.main,
      orderBy: 0,
    );
    await _box.add(inCategory);
    notifyListeners();
  }

  List<InCategory> getInSubCategory(String parentId) {
    return _box.values
        .where((element) =>
            element.type == TypeOfInCategory.sub &&
            element.parentId == parentId)
        .toList();
  }

  Future<void> deleteItem(InCategory inCategory) async {
    final item = _box.values.firstWhere((element) =>
        element.assetUid == inCategory.assetUid &&
        element.name == inCategory.name);
    if (item.parentId == null) {
      final listOfSubItem = _box.values.where((element) =>
          element.type == TypeOfInCategory.sub &&
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
