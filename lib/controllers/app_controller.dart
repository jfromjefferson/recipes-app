import 'package:get/get.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/database/queries/favorite/queries.dart';
import 'package:recipes/database/queries/recipe/queries.dart';

class AppController extends GetxController {
  var itemToCheckMap = {}.obs;
  var isRecipeFavorite = false.obs;
  var favoriteObject;
  var searchedRecipes = [].obs;
  String? recipeSearched;

  @override
  void onInit() async {
    favoriteObject = await getFavoriteObject();

    super.onInit();
  }

  void checkItem({required String element}) {
    itemToCheckMap[element] = !itemToCheckMap[element];

    return itemToCheckMap[element];
  }

  Future<bool> setRecipeFavorite({required Recipe recipe}) async {
    List<Recipe> recipeList = await getFavoriteList();
    List<String> uuidList = [];

    recipeList.forEach((element) {
      uuidList.add(element.uuid);
    });

    if(uuidList.contains(recipe.uuid)){
      isRecipeFavorite.value = true;
    }else {
      isRecipeFavorite.value = false;
    }

    return isRecipeFavorite.value;
  }

  Future<void> searchRecipe({required String recipeTitle}) async {
    List<Recipe> recipeList = await getRecipeBySearch(recipeTitle: recipeTitle);

    searchedRecipes.value = recipeList;
    recipeSearched = recipeTitle;
  }

}