import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanager_free/manage_category/income_category/in_category_db_notifier.dart';
import 'package:moneymanager_free/manage_category/manage_category_screen.dart';
import 'hive_models/asset_model.dart';
import 'hive_models/in_category_model.dart';
import 'hive_models/out_category_model.dart';
import 'manage_category/income_category/manage_in_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AssetAdapter());
  Hive.registerAdapter(OutCategoryAdapter());
  Hive.registerAdapter(InCategoryAdapter());
  Hive.registerAdapter(TypeOfInCategoryAdapter());
  Hive.registerAdapter(TypeOfOutCategoryAdapter());

  await Hive.openBox<OutCategory>(outCategoryBoxName);
  await Hive.openBox<InCategory>(inCategoryBoxName);
  await Hive.openBox<Asset>(assetBoxName);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const ManageCategoryScreen(),
    );
  }
}

const String outCategoryBoxName = 'out_category_box';
const String inCategoryBoxName = 'in_category_box';
const String assetBoxName = 'asset_box';
