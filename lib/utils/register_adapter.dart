import 'package:hive/hive.dart';
import 'package:recipes/database/models/category/category.dart';

void registerAdapter() {
  Hive.registerAdapter(CategoryAdapter());
}