import 'package:finly/core/injection_container.dart';
import 'package:finly/domain/entities/category/category_entity.dart';
import 'package:finly/presentation/cubits/category/category_cubit.dart';
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
        builder: (pageContext, state) {
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
                            insertCategoryDialog(
                              pageContext: pageContext,
                              category: null,
                            );
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    if (state is CategoryLoading) ...[
                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (_, _) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
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
                                              showDeleteDialog(
                                                pageContext,
                                                category,
                                              );
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                          SizedBox(width: 10),

                                          IconButton(
                                            onPressed: () {
                                              insertCategoryDialog(
                                                pageContext: pageContext,
                                                category: category,
                                              );
                                              pageContext
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

  Future<dynamic> showDeleteDialog(
    BuildContext pageContext,
    CategoryEntity category,
  ) {
    return showDialog(
      context: pageContext,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.error_outline, color: Colors.red, size: 28),
          ),
          title: Text(
            'Delete Category',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text(
            'Are you sure you want to delete that category?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.red),
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                pageContext.read<CategoryCubit>().deleteCategory(category.id!);
              },
              child: Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> insertCategoryDialog({
    required BuildContext pageContext,
    CategoryEntity? category,
  }) {
    final isEditMode = category != null;

    if (isEditMode) {
      _categoryController.text = category.name ?? '';
    } else {
      _categoryController.clear();
    }
    return showDialog(
      context: pageContext,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            isEditMode
                ? 'Edit Category'
                : 'Add ${_isSwitchOn ? 'Income' : 'Outcome'}',
            style: TextStyle(color: _isSwitchOn ? Colors.green : Colors.red),
          ),
          content: TextFormField(
            controller: _categoryController,
            decoration: InputDecoration(
              hintText: isEditMode
                  ? 'Rename Category'
                  : 'Add a new category...',
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
                  if (isEditMode) {
                    final updatedCategory = CategoryEntity(
                      name: text,
                      type: category.type,
                      id: category.id,
                    );
                    pageContext.read<CategoryCubit>().updateCategory(
                      updatedCategory,
                    );
                  } else {
                    pageContext.read<CategoryCubit>().addCategory(
                      text,
                      _isSwitchOn == true ? 0 : 1,
                    );
                  }
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
