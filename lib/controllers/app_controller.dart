import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/database/models/settings/settings.dart';
import 'package:recipes/database/queries/category/queries.dart';
import 'package:recipes/database/queries/favorite/queries.dart';
import 'package:recipes/database/queries/recipe/queries.dart';
import 'package:recipes/database/queries/settings/queries.dart';
import 'package:recipes/utils/functions.dart';

class AppController extends GetxController {
  var itemToCheckMap = {}.obs;
  var isRecipeFavorite = false.obs;
  var favoriteObject;
  var searchedRecipes = [].obs;
  var showSearchField = false.obs;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  String? recipeSearched;

  @override
  void onInit() async {
    favoriteObject = await getFavoriteObject();

    bool refreshCache = await refreshCachedData();

    if(refreshCache){
      print('refresh');
      await removeAllCategories();
      await removeAllRecipes();

      await createCategoryCache();
      await createRecipeCache();

      Settings? settings = await getSettingsObject();

      if(settings != null){
        settings.lastSync = DateTime.now().add(Duration(days: 7));

        settings.save();
      }
    }else{
      print('not refresh');
    }

    super.onInit();
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
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

  Future<void> searchRecipe({required String recipeTitle, Category? category}) async {
    List<Recipe> recipeList = await getRecipeBySearch(recipeTitle: recipeTitle, category: category);

    searchedRecipes.value = recipeList;
    recipeSearched = recipeTitle;
  }

  void toggleSearchFieldVisibility() {
    showSearchField.value = !showSearchField.value;
  }

}