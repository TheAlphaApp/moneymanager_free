import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_income_item_screen.dart';
import '../../hive_models/income_category_model.dart';
import 'income_category_db_notifier.dart';

final inCatProvidertoSubCategory = Provider<IncomeCategory>((ref) {
  throw UnimplementedError();
});

class SubInCategoryScreen extends ConsumerWidget {
  const SubInCategoryScreen({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final parentId = ref.watch(inCatProvidertoSubCategory).assetUid;
    final inSubCategories =
        ref.watch(incomeCategoryProvider).getInSubCategory(parentId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ref.watch(inCatProvidertoSubCategory).name,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          IncomeCategory inCategory = inSubCategories[index];
          return ListTile(
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
          );
        },
        itemCount: inSubCategories.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddIncomeItemScreen(
                parentId: ref.watch(inCatProvidertoSubCategory).assetUid,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
