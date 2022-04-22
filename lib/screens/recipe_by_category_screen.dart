import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:recipes/controllers/app_controller.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';
import 'package:recipes/widgets/customTextField.dart';

class RecipeByCategoryScreen extends StatelessWidget {
  final AppController appController = Get.put(AppController());

  final Category category;

  RecipeByCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: category.title),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Obx(() => FutureBuilder(
          future: appController.searchedRecipes.value.length > 0 ? recipeCardList(searchedRecipes: appController.searchedRecipes.value as List<Recipe>) : recipeCardList(category: category),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length > 0){
                return ListView(
                  children: [
                    SizedBox(height: 5),
                    CustomTextField(
                      onChanged: (String value) async {
                        appController.searchRecipe(recipeTitle: value);
                      },
                      hintText: 'Procurar receita',
                      fillColor: Colors.white,
                      textColor: Colors.black,
                      borderRadius: 10,
                    ),
                    appController.searchedRecipes.value.length == 0
                        ? Column(
                          children: [
                            SizedBox(height: 10),
                            CustomText(text: 'Nenhuma receita de ${appController.recipeSearched}', align: TextAlign.center, size: 18, color: Colors.red),
                            SizedBox(height: 20),
                          ],
                        )
                        : SizedBox(),
                    SizedBox(height: 10),
                    StaggeredGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: snapshot.data,
                    )
                  ],
                );
              }else {
                return Center(
                  child: CustomText(text: 'Nenhuma receita encontrada :(', weight: FontWeight.bold, size: 18),
                );
              }
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )),
      ),
    );
  }
}
