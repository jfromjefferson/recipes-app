import 'package:hive/hive.dart';
import 'package:recipes/database/models/category/category.dart';

Future<List<Category>> getCategoryList() async {
  final box = await Hive.openBox<Category>('category');
  // box.clear();
  List<Category> categoryList = [];

  box.toMap().forEach((key, category) {
    categoryList.add(category);
  });

  return categoryList;
}

Future<Category> getOneCategory({required String uuid}) async {
  final box = await Hive.openBox<Category>('category');

  final categoryFilter = box.values.where((element) => element.uuid == uuid).toList();

  return categoryFilter.first;
}

Future<void> saveCategory({required Category category}) async {
  final box = await Hive.openBox<Category>('category');

  final categoryFilter = box.values.where((element) => element.uuid == category.uuid).toList();

  if(categoryFilter.length > 0){
    int index = categoryFilter.first.key;

    await box.putAt(index, category);
  }else {
    await box.add(category);
  }
}

Future<void> removeAllCategories() async {
  final box = await Hive.openBox<Category>('category');

  await box.clear();
}