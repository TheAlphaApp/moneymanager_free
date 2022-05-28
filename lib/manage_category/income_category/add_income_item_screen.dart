import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneymanager_free/hive_models/income_category_model.dart';
import 'income_category_db_notifier.dart';

class AddIncomeItemScreen extends StatefulWidget {
  const AddIncomeItemScreen({this.inCategory, this.parentId, Key? key})
      : super(key: key);
  final String? parentId;
  final IncomeCategory? inCategory;
  @override
  State<AddIncomeItemScreen> createState() => _AddIncomeItemScreenState();
}

class _AddIncomeItemScreenState extends State<AddIncomeItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controllerNameField = TextEditingController();
  final TextEditingController controllerDescField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String name = widget.inCategory?.name ?? '';
    String description = widget.inCategory?.description ?? '';
    controllerNameField.text = name;
    controllerDescField.text = description;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.parentId != null || widget.inCategory?.parentId != null
                ? 'Subcategory'
                : 'Income Category'),
        actions: [
          widget.inCategory != null
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
                                      .read(incomeCategoryProvider)
                                      .deleteItem(widget.inCategory!)
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
              if (widget.inCategory != null) {
                final inCategoryItem = widget.inCategory!.copyWith(
                  name: name,
                  description: description,
                );

                ref
                    .read(incomeCategoryProvider)
                    .updateItem(inCategoryItem)
                    .then((value) => Navigator.of(context).pop());
              } else {
                ref
                    .read(incomeCategoryProvider)
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
