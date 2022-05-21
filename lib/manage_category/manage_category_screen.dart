import 'package:flutter/material.dart';
import 'package:moneymanager_free/hive_models/in_category_model.dart';
import 'package:moneymanager_free/manage_category/expense_category/manage_expense_category.dart';
import 'package:moneymanager_free/manage_category/income_category/manage_in_category.dart';

import 'income_category/add_screen_content.dart';

class ManageCategoryScreen extends StatefulWidget {
  const ManageCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ManageCategoryScreen> createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen> {
  int index = 0;
  List<Widget> get _pages => const [
        ManageInCategoryPage(),
        ManageExCategoryPage(),
      ];
  String get _title => index == 0 ? 'Income' : 'Expense';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage $_title Category'),
      ),
      body: _pages[index],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        selectedIndex: index,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.arrow_circle_down_outlined),
            label: 'Income',
            selectedIcon: Icon(Icons.arrow_downward),
          ),
          NavigationDestination(
            icon: Icon(Icons.arrow_circle_up_outlined),
            label: 'Expense',
            selectedIcon: Icon(Icons.arrow_upward),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddItemScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
