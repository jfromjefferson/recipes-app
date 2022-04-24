import 'package:hive/hive.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/database/models/favorite/favorite.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/database/models/settings/settings.dart';

void registerAdapter() {
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(FavoriteAdapter());
  Hive.registerAdapter(SettingsAdapter());
}