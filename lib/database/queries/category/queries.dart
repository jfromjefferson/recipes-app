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

Future<void> saveCategory({required Category category}) async {
  final box = await Hive.openBox<Category>('category');

  final categoryFilter = box.values.where((element) => element.uuid == category.uuid).toList();

  if(categoryFilter.length > 0){
    int categoryIndex = categoryFilter.first.key;

    await box.putAt(categoryIndex, category);
  }else {
    await box.add(category);
  }
}