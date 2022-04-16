import 'package:hive/hive.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/database/models/recipe/recipe.dart';

void registerAdapter() {
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(RecipeAdapter());
}