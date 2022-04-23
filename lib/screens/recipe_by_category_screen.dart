import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:recipes/controllers/app_controller.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';
import 'package:recipes/widgets/customTextField.dart';
import 'package:recipes/widgets/custom_ads.dart';

class RecipeByCategoryScreen extends StatefulWidget {
  final Category category;

  RecipeByCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<RecipeByCategoryScreen> createState() => _RecipeByCategoryScreenState();
}

class _RecipeByCategoryScreenState extends State<RecipeByCategoryScreen> {
  final AppController appController = Get.put(AppController());

  @override
  void dispose() {
    appController.searchedRecipes.value = [];
    appController.recipeSearched = null;
    appController.showSearchField.value = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: widget.category.title, size: 18),
        actions: [
          IconButton(
            onPressed: (){
              appController.toggleSearchFieldVisibility();
              print(appController.showSearchField.value);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Obx(() => FutureBuilder(
          future: appController.searchedRecipes.value.length > 0
              ? recipeCardList(searchedRecipes: appController.searchedRecipes.value as List<Recipe>)
              : recipeCardList(category: widget.category),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              if(snapshot.data.length > 0){
                return RefreshIndicator(
                  onRefresh: (){
                    return Future.delayed(Duration(milliseconds: 500)).then((value) {
                      setState(() {});
                    });
                  },
                  child: ListView(
                    children: [
                      Obx(() => appController.showSearchField.value
                        ? CustomTextField(
                            onChanged: (String value) async {
                              appController.searchRecipe(recipeTitle: value, category: widget.category);
                            },
                            hintText: 'Procurar receita',
                            fillColor: Colors.white,
                            textColor: Colors.black,
                            borderRadius: 10,
                          )
                        : SizedBox()
                      ),
                      SizedBox(height: 10),
                      BannerAds(),
                      appController.searchedRecipes.value.length == 0 && appController.recipeSearched?.trim() != null && appController.recipeSearched?.trim() != ''
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
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              }else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: 'Nenhuma receita encontrada :(', weight: FontWeight.bold, size: 18),
                      SizedBox(height: 20),
                      LargerBanner()
                    ],
                  ),
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
