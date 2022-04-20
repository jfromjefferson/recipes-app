import 'package:get/get.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/database/queries/favorite/queries.dart';

class AppController extends GetxController {
  var itemToCheckMap = {}.obs;
  var isRecipeFavorite = false.obs;

  void checkItem({required String element}) {
    itemToCheckMap[element] = !itemToCheckMap[element];

    return itemToCheckMap[element];
  }

  Future<void> setRecipeFavorite({required Recipe recipe}) async {
    List<Recipe> recipeList = await getFavoriteList();

    if(recipeList.contains(recipe)){
      isRecipeFavorite.value = true;
    }else {
      isRecipeFavorite.value = false;
    }
  }

}