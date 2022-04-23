import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:recipes/controllers/app_controller.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';

class RecipeBySearchScreen extends StatefulWidget {
  final String recipeTitle;

  RecipeBySearchScreen({Key? key, required this.recipeTitle}) : super(key: key);

  @override
  State<RecipeBySearchScreen> createState() => _RecipeBySearchScreenState();
}

class _RecipeBySearchScreenState extends State<RecipeBySearchScreen> {
  final AppController appController = Get.put(AppController());

  @override
  void dispose() {
    appController.searchedRecipes.value = [];
    appController.recipeSearched = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Resultados para ${widget.recipeTitle}'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, top: 10, right: 5),
        child: FutureBuilder(
          future: recipeCardList(searchedRecipes: appController.searchedRecipes.value as List<Recipe>),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length > 0){
                return ListView(
                  children: [
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
                  child: CustomText(text: 'Não achei nenhuma receita de ${widget.recipeTitle} :(', size: 19, weight: FontWeight.bold, align: TextAlign.center,),
                );
              }
            }else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
