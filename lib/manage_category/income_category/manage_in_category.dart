import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneymanager_free/manage_category/income_category/sub_in_category_screen.dart';

import '../../hive_models/income_category_model.dart';
import 'add_income_item_screen.dart';
import 'income_category_db_notifier.dart';

class ManageInCategoryPage extends ConsumerWidget {
  const ManageInCategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inMainCategories =
        ref.watch(incomeCategoryProvider).getInMainCategory();
    return ListView.builder(
      itemCount: inMainCategories.length,
      itemBuilder: (context, index) {
        IncomeCategory inCategory = inMainCategories[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            borderOnForeground: true,
            child: ListTile(
              title: Text(inCategory.name),
              subtitle: Text(inCategory.description),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddIncomeItemScreen(inCategory: inCategory),
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
                        inCatProvidertoSubCategory.overrideWithValue(inCategory)
                      ],
                      child: const SubInCategoryScreen(),
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
