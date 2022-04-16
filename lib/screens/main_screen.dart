import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:recipes/controllers/app_controller.dart';
import 'package:recipes/database/queries/category/queries.dart';
import 'package:recipes/database/queries/recipe/queries.dart';
import 'package:recipes/utils/colors.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';
import 'package:recipes/widgets/customTextField.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainScreen extends StatelessWidget {
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            getRecipeList().then((value) {
              print(value);
            });
            Get.focusScope?.unfocus();
          },
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Column(
              children: [
                CustomTextField(
                  onChanged: (String value){},
                  onPressed: (){
                    print('oii');
                  },
                  hintText: 'Procurar receita',
                  fillColor: Colors.white,
                  textColor: Colors.black,
                  icon: Icons.search,
                  borderRadius: 10,
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      CustomText(
                        text: 'Categorias adicionadas recentemente',
                        size: 20,
                        align: TextAlign.center,
                        weight: FontWeight.bold,
                        color: textColor,
                      ),
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
                      SizedBox(height: 20),
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
                    ],
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
