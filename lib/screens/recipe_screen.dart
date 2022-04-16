import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;
  final Color color;

  const RecipeScreen({Key? key, required this.recipe, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: recipe.title.capitalizeFirst!),
        backgroundColor: color,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: ListView(
            children: [
              CustomText(text: recipe.toMap().toString()),
              CustomText(text: recipe.title, size: 28, align: TextAlign.center),
              CustomText(text: 'Serve ${recipe.serve}', size: 20, align: TextAlign.center),
              Divider(
                height: 15,
                color: color,
              ),
              CustomText(text: 'Ingredientes', size: 18, align: TextAlign.center),
              SizedBox(height: 10),
              formatItems(itemList: recipe.ingredientList),
            ],
          ),
        ),
      ),
    );
  }
}
