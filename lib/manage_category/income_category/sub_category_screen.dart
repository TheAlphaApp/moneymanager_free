import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_screen_content.dart';
import '../../hive_models/in_category_model.dart';
import 'in_category_db_notifier.dart';

final inCatProvidertoSubCategory = Provider<InCategory>((ref) {
  throw UnimplementedError();
});

class SubCategoryScreen extends ConsumerWidget {
  const SubCategoryScreen({super.key});
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
          InCategory inCategory = inSubCategories[index];
          return ListTile(
            title: Text(inCategory.name),
            subtitle: Text(inCategory.description),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddItemScreen(inCategory: inCategory),
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
              builder: (context) => AddItemScreen(
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
