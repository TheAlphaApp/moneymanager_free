import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../hive_models/expense_category_model.dart';
import 'expense_category_notifier.dart';

class AddExpenseItemScreen extends StatefulWidget {
  const AddExpenseItemScreen({this.exCategory, this.parentId, Key? key})
      : super(key: key);
  final String? parentId;
  final ExpenseCategory? exCategory;
  @override
  State<AddExpenseItemScreen> createState() => _AddExpenseItemScreenState();
}

class _AddExpenseItemScreenState extends State<AddExpenseItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controllerNameField = TextEditingController();
  final TextEditingController controllerDescField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name = widget.exCategory?.name ?? '';
    String description = widget.exCategory?.description ?? '';
    controllerNameField.text = name;
    controllerDescField.text = description;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.parentId != null || widget.exCategory?.parentId != null
                ? 'Subcategory'
                : 'OutCome Category'),
        actions: [
          widget.exCategory != null
              ? Consumer(builder: (context, ref, _) {
                  return TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text('Delete'),
                            content: const Text(
                              "Are you sure you want to delete this category?",
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                child: const Text('DELETE'),
                                onPressed: () async {
                                  await ref
                                      .read(expenseCategoryProvider)
                                      .deleteItem(widget.exCategory!)
                                      .then(
                                    (value) {
                                      //pop from alert dialog
                                      Navigator.of(context).pop();
                                      //pop from AddItemScreen
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text('CANCEL'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    // child: const Text("Delete"),
                    style: TextButton.styleFrom(
                      primary: Colors.red,
                      // onPrimary: Colors.red,
                    ),

                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  );
                })
              : Container(),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: controllerNameField,
                // initialValue: name,

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.category),
                  hintText: 'Enter name of category',
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: controllerDescField,
                // initialValue: description,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some description';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: 'Enter description of category',
                  labelText: 'Description',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, _) {
        return FloatingActionButton.extended(
          onPressed: () async {
            name = controllerNameField.text;
            description = controllerDescField.text;
            if (_formKey.currentState!.validate()) {
              if (widget.exCategory != null) {
                final exCategoryItem = widget.exCategory!.copyWith(
                  name: name,
                  description: description,
                );

                ref
                    .read(expenseCategoryProvider)
                    .updateItem(exCategoryItem)
                    .then((value) => Navigator.of(context).pop());
              } else {
                ref
                    .read(expenseCategoryProvider)
                    .add(
                      name: name,
                      description: description,
                      parentId: widget.parentId,
                    )
                    .then((value) => Navigator.of(context).pop());
              }
            }
          },
          label: Row(
            children: const [
              Icon(Icons.check),
              SizedBox(
                width: 8,
              ),
              Text('Submit'),
            ],
          ),
        );
      }),
    );
  }
}
