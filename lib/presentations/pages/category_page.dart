import 'package:finly/core/injection_container.dart';
import 'package:finly/presentations/cubits/category/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _categoryController = TextEditingController();

  bool _isSwitchOn = true;

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoryCubit>()..getCategories(),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to Add Category'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Categories', style: TextStyle(fontSize: 20)),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Switch(
                          value: _isSwitchOn,
                          onChanged: (value) {
                            setState(() {
                              _isSwitchOn = value;
                            });
                          },
                          activeThumbColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          activeTrackColor: Colors.green,
                          inactiveTrackColor: Colors.red,
                          trackOutlineColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(_isSwitchOn == true ? 'Income' : 'Outcome'),
                        Spacer(),

                        IconButton(
                          onPressed: () {
                            insertCategoryDialog(context);
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    if (state is CategoryLoading &&
                        state is! CategorySuccess) ...[
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            onTap: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ] else if (state is CategorySuccess) ...[
                      (() {
                        final targetType = _isSwitchOn ? 0 : 1;
                        final filteredCategories =
                            state.categories
                                ?.where((cat) => cat.type == targetType)
                                .toList() ??
                            [];
                        if (filteredCategories.isNotEmpty) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: filteredCategories.length,
                              itemBuilder: (context, index) {
                                final category = filteredCategories[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 10,
                                    child: ListTile(
                                      onTap: () {},
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      tileColor: Colors.white,
                                      title: Text(category.name ?? ''),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              context
                                                  .read<CategoryCubit>()
                                                  .deleteCategory(category.id!);
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                          SizedBox(width: 10),

                                          IconButton(
                                            onPressed: () {
                                              context
                                                  .read<CategoryCubit>()
                                                  .updateCategory(category);
                                            },
                                            icon: Icon(Icons.edit),
                                          ),
                                        ],
                                      ),
                                      leading: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Icon(
                                          category.type == 0
                                              ? Icons.download
                                              : Icons.upload,
                                          color: category.type == 0
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Expanded(child: Text('No categories yet'));
                        }
                      }()),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> insertCategoryDialog(BuildContext pageContext) {
    _categoryController.clear();
    return showDialog(
      context: pageContext,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Add ${_isSwitchOn ? 'Income' : 'Outcome'}',
            style: TextStyle(color: _isSwitchOn ? Colors.green : Colors.red),
          ),
          content: TextFormField(
            controller: _categoryController,
            decoration: InputDecoration(
              hintText: 'Add a new category...',
              hintStyle: TextStyle(fontSize: 12),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                final text = _categoryController.text.trim();
                if (text.isNotEmpty) {
                  pageContext.read<CategoryCubit>().addCategory(
                    text,
                    _isSwitchOn == true ? 0 : 1,
                  );
                }
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
