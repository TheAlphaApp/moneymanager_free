import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneymanager_free/manage_category/expense_category/expense_category_notifier.dart';

import '../../hive_models/expense_category_model.dart';
import 'add_expense_item_screen.dart';


final exCatProvidertoSubCategory = Provider<ExpenseCategory>((ref) {
  throw UnimplementedError();
});

class SubExCategoryScreen extends ConsumerWidget {
  const SubExCategoryScreen({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final parentId = ref.watch(exCatProvidertoSubCategory).assetUid;
    final exSubCategories =
        ref.watch(expenseCategoryProvider).getInSubCategory(parentId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ref.watch(exCatProvidertoSubCategory).name,
        ),
      ),
      body: ListView.builder(
        itemCount: exSubCategories.length,
        itemBuilder: (context, index) {
          ExpenseCategory exCategory = exSubCategories[index];
          return ListTile(
            title: Text(exCategory.name),
            subtitle: Text(exCategory.description),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddExpenseItemScreen(exCategory: exCategory),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExpenseItemScreen(
                parentId: ref.watch(exCatProvidertoSubCategory).assetUid,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
