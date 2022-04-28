import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/controllers/app_controller.dart';
import 'package:recipes/database/models/settings/settings.dart';
import 'package:recipes/screens/favorite_recipe_screen.dart';
import 'package:recipes/screens/recipe_by_search_screen.dart';
import 'package:recipes/utils/colors.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customButton.dart';
import 'package:recipes/widgets/customText.dart';
import 'package:recipes/widgets/customTextField.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipes/widgets/custom_ads.dart';

import '../database/queries/settings/queries.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: appController.scaffoldKey,
      drawer: Drawer(
        backgroundColor: primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(child: CustomText(text: 'Receitas', size: 19)),
            ),
            GestureDetector(
              onTap: (){
                Get.to(() => FavoriteRecipeScreen(favorite: appController.favoriteObject), transition: Transition.cupertino);
              },
              child: Container(
                child: ListTile(
                  leading: Icon(Icons.favorite, size: 30),
                  title: CustomText(text: 'Receitas salvas'),
                  trailing: Icon(Icons.arrow_forward_outlined),
                ),
              ),
            ),
            SizedBox(height: 15),
            CustomText(text: 'Todas as categorias', align: TextAlign.center, size: 17),
            SizedBox(height: 15),
            FutureBuilder(
              future: getDrawerItemList(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return Column(children: snapshot.data);
                }else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            GestureDetector(
              onLongPress: () async {
                Settings? settings = await getSettingsObject();

                if(settings != null){
                  settings.showAds = !settings.showAds;

                  settings.save();

                  // print(settings.toMap());
                }
              },
              child: CustomText(
                text: '-------------------',
                color: primaryColor,
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            Get.focusScope?.unfocus();
          },
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
            child: Column(
              children: [
                CustomTextField(
                  onChanged: (String value) async {
                    appController.searchRecipe(recipeTitle: value);
                  },
                  onPressed: (){
                    if(appController.recipeSearched?.trim() != '' && appController.recipeSearched != null){
                      Get.to(() => RecipeBySearchScreen(recipeTitle: appController.recipeSearched!), transition: Transition.cupertino);
                    }
                  },
                  onSubmitted: (String value){
                    if(value.trim() != '' && appController.recipeSearched != null){
                      Get.to(() => RecipeBySearchScreen(recipeTitle: appController.recipeSearched!), transition: Transition.cupertino);
                    }
                  },
                  hintText: 'Procurar receita',
                  fillColor: Colors.white,
                  textColor: Colors.black,
                  icon: Icons.search,
                  borderRadius: 10,
                ),
                SizedBox(height: 10),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: (){
                      return Future.delayed(Duration(seconds: 3)).then((value) {
                        setState(() {});
                      });
                    },
                    child: ListView(
                      children: [
                        CustomText(
                          text: 'Categorias adicionadas recentemente',
                          size: 20,
                          align: TextAlign.center,
                          weight: FontWeight.bold,
                          color: textColor,
                        ),
                        CustomAds(size: AdmobBannerSize.FULL_BANNER),
                        SizedBox(height: 10),
                        FutureBuilder(
                          future: categoryCardList(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.hasData){
                              return StaggeredGrid.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: snapshot.data,
                              );
                            }else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                        SizedBox(height: 30),
                        CustomButton(
                          onPressed: (){
                            appController.openDrawer();
                          },
                          text: 'Todas as categorias',
                          buttonColor: Colors.blue,
                        ),
                        SizedBox(height: 30),
                        CustomText(
                          text: 'Últimas receitas',
                          size: 20,
                          align: TextAlign.center,
                          weight: FontWeight.bold,
                          color: textColor,
                        ),
                        SizedBox(height: 10),
                        FutureBuilder(
                          future: recipeCardList(),
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if(snapshot.hasData){
                              return StaggeredGrid.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: snapshot.data,
                              );
                            }else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        CustomAds(size: AdmobBannerSize.LARGE_BANNER),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
