import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../hive_models/expense_category_model.dart';
import 'add_expense_item_screen.dart';
import 'expense_category_notifier.dart';
import 'sub_ex_category_screen.dart';

class ManageExCategoryPage extends ConsumerWidget {
  const ManageExCategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exMainCategories =
        ref.watch(expenseCategoryProvider).getInMainCategory();
    return ListView.builder(
      itemCount: exMainCategories.length,
      itemBuilder: (context, index) {
        ExpenseCategory exCategory = exMainCategories[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            borderOnForeground: true,
            child: ListTile(
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProviderScope(
                      overrides: [
                        exCatProvidertoSubCategory.overrideWithValue(exCategory)
                      ],
                      child: const SubExCategoryScreen(),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
