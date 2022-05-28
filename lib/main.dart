import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanager_free/manage_category/income_category/income_category_db_notifier.dart';
import 'package:moneymanager_free/manage_category/manage_category_screen.dart';
import 'hive_models/asset_model.dart';
import 'hive_models/income_category_model.dart';
import 'hive_models/expense_category_model.dart';
import 'manage_category/income_category/manage_in_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AssetAdapter());
  Hive.registerAdapter(ExpenseCategoryAdapter());
  Hive.registerAdapter(IncomeCategoryAdapter());
  Hive.registerAdapter(TypeOfIncomeCategoryAdapter());
  Hive.registerAdapter(TypeOfExpenseCategoryAdapter());

  await Hive.openBox<ExpenseCategory>(expenseCategoryBoxName);
  await Hive.openBox<IncomeCategory>(incomeCategoryBoxName);
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

const String expenseCategoryBoxName = 'ex_category_box';
const String incomeCategoryBoxName = 'in_category_box';
const String assetBoxName = 'asset_box';
