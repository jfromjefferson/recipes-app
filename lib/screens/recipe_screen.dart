import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/controllers/app_controller.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';

class RecipeScreen extends StatelessWidget {
  final AppController appController = Get.put(AppController());

  final Recipe recipe;
  final Color color;

  RecipeScreen({Key? key, required this.recipe, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: recipe.title.capitalizeFirst!),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.favorite),
          )
        ],
        backgroundColor: color,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListView(
          children: [
            CustomText(text: recipe.title, size: 28, align: TextAlign.center),
            CustomText(text: 'Serve ${recipe.serve}', size: 20, align: TextAlign.center),
            Divider(
              height: 15,
              color: color,
            ),
            CustomText(text: 'Ingredientes', size: 18, align: TextAlign.center),
            SizedBox(height: 15),
            formatItems(itemList: recipe.ingredientList, appController: appController, color: color),
            CustomText(text: 'Modo de preparo', size: 18, align: TextAlign.center),
            SizedBox(height: 15),
            formatItems(itemList: recipe.instructions, appController: appController, color: color),
          ],
        ),
      ),
    );
  }
}
