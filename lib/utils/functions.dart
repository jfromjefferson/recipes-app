import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/database/queries/category/queries.dart';
import 'package:recipes/database/queries/recipe/queries.dart';
import 'package:recipes/screens/recipe_screen.dart';
import 'package:recipes/services/requests.dart';
import 'package:recipes/utils/colors.dart';
import 'package:recipes/utils/urls.dart';
import 'package:recipes/widgets/customText.dart';

Future<List<Widget>> categoryCardList() async {
  List<Category> categoryList = await getCategoryList();
  List<Widget> categoryWidgetList = [];

  categoryList.shuffle();
  categoryList.getRange(0, 6).forEach((categoryTemp) {
    Color cardColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    Color textColor = Color(cardColor.value).computeLuminance() > 0.5 ? Colors.black : primaryColor;

    categoryWidgetList.add(
      GestureDetector(
        onTap: (){},
        child: Container(
            width: Get.mediaQuery.size.width/2.2,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomText(text: categoryTemp.title.capitalizeFirst!, size: 18, color: textColor, align: TextAlign.center),
                    CustomText(text: '${categoryTemp.recipeCount} ${categoryTemp.recipeCount == 1 ? 'receita': 'receitas'}', size: 16, color: textColor),
                  ],
                ),
                SvgPicture.network(categoryTemp.iconSrc, height: 100),
              ],
            )
        ),
      )
    );
  });

  return categoryWidgetList;
}

Future<List<Widget>> recipeCardList() async {
  List<Recipe> recipeList = await getRecipeList();
  List<Widget> recipeWidgetList = [];

  recipeList.shuffle();
  recipeList.getRange(0, 10).forEach((recipeTemp) {
    Color cardColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    Color textColor = Color(cardColor.value).computeLuminance() > 0.5 ? Colors.black : primaryColor;

    recipeWidgetList.add(
        GestureDetector(
          onTap: (){
            Get.to(() => RecipeScreen(recipe: recipeTemp, color: cardColor), transition: Transition.cupertino);
          },
          child: Container(
              width: Get.mediaQuery.size.width/2.2,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: recipeTemp.title.capitalizeFirst!, size: 18, align: TextAlign.center, color: textColor),
                  SizedBox(height: 10),
                  CustomText(text: '${recipeTemp.likes} pessoas gostaram disso', align: TextAlign.center, color: textColor),
                ],
              )
          ),
        )
    );
  });

  return recipeWidgetList;
}

Future<void> createCategoryCache() async {
  try {
    final response = await fetchData(path: RecipeApiUrl.categoryUrl);

    if(response == null){
      return;
    }

    if(response.statusCode == 200){
      List<dynamic> categoryInfo = response.data['category_info'];

      categoryInfo.forEach((categoryInfoTemp) {
        Category category = Category(
          iconSrc: categoryInfoTemp['icon_src'],
          recipeCount: categoryInfoTemp['recipe_count'],
          title: categoryInfoTemp['name'],
          uuid: categoryInfoTemp['uuid'],
        );

        saveCategory(category: category);
      });
    }

  } catch(e) {
    // TODO: Show snack bar with error message
  }
}

Future<void> createRecipeCache() async {
  try {
    final response = await fetchData(path: RecipeApiUrl.recipeUrl);

    if(response == null){
      return;
    }

    if(response.statusCode == 200){
      List<dynamic> recipeInfo = response.data['recipe_info'];

      recipeInfo.forEach((recipeInfoTemp) async {
        Recipe recipe = Recipe(
          title: recipeInfoTemp['title'],
          serve: recipeInfoTemp['serve'],
          uuid: recipeInfoTemp['uuid'],
          ingredientList: recipeInfoTemp['ingredient_list'].cast<String>(),
          instructions: recipeInfoTemp['instructions'].cast<String>(),
          likes: recipeInfoTemp['likes'],
          category: await getOneCategory(uuid: recipeInfoTemp['category_uuid'])
        );

        saveRecipe(recipe: recipe);
      });

    }

  } catch(e) {
    // TODO: Show snack bar with error message
  }
}

Widget formatItems({required List<String> itemList}) {
  List<Widget> widgetList = [];

  itemList.forEach((element) {
    widgetList.add(
      element == 'Massa:' || element == 'Cobertura:'
          ? Column(
            children: [
              SizedBox(height: 10),
              CustomText(text: element.replaceAll(':', ''), size: 19, weight: FontWeight.bold, align: TextAlign.center),
              SizedBox(height: 10)
            ],
          )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText(text: element, size: 17),
                Divider(height: 10, color: Colors.grey)
              ],
          )

    );
  });

  Column column = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: widgetList,
  );

  return column;
}