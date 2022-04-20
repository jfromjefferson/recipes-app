import 'package:hive/hive.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/database/models/recipe/recipe.dart';

Future<void> saveRecipe({required Recipe recipe}) async {
  final box = await Hive.openBox<Recipe>('recipe');

  final recipeFilter = box.values.where((element) => element.uuid == recipe.uuid).toList();

  if(recipeFilter.length > 0){
    int index = recipeFilter.first.key;

    await box.putAt(index, recipe);
  }else {
    await box.add(recipe);
  }
}

Future<List<Recipe>> getRecipeList() async {
  final box = await Hive.openBox<Recipe>('recipe');

  // box.clear();

  List<Recipe> recipeList = [];

  box.toMap().forEach((key, recipe) {
    recipeList.add(recipe);
  });

  return recipeList;
}

Future<List<Recipe>> getRecipeByCategory({required Category category}) async {
  final box = await Hive.openBox<Recipe>('recipe');

  List<Recipe> recipeList = [];

  final filteredList = box.values.where((element) => element.category.uuid == category.uuid).toList();

  filteredList.forEach((recipe) {
    recipeList.add(recipe);
  });

  return recipeList;
}