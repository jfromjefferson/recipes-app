import 'package:hive/hive.dart';
import 'package:recipes/database/models/favorite/favorite.dart';
import 'package:recipes/database/models/recipe/recipe.dart';

Future<void> createFavoriteObject() async {
  final box = await Hive.openBox<Favorite>('favorite');

  getFavoriteObject().then((value) async {
    if(value == null){
      Favorite favorite = Favorite(recipeList: []);

      await box.add(favorite);
    }
  });
}

Future<Favorite?> getFavoriteObject() async {
  final box = await Hive.openBox<Favorite>('favorite');

  Favorite? favorite = box.get(0);

  return favorite;
}

Future<void> recipeToFavorite({required Recipe recipe}) async {
  await Hive.openBox<Favorite>('favorite');

  Favorite? favorite = await getFavoriteObject();

  if(favorite != null){
    List<Recipe> recipeList = favorite.recipeList;

    if(recipeList.contains(recipe)){
      recipeList.remove(recipe);
    }else {
      recipeList.add(recipe);
    }

    favorite.recipeList = recipeList;

    favorite.save();
  }
}

Future<List<Recipe>> getFavoriteList() async {
  Favorite? favorite = await getFavoriteObject();

  if(favorite != null){
    return favorite.recipeList;
  }

  return [];
}