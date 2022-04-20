import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';

class RecipeByCategoryScreen extends StatelessWidget {
  final Category category;

  const RecipeByCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: category.title),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: FutureBuilder(
          future: recipeCardList(category: category),
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
                  child: CustomText(text: 'Nenhuma receita encontrada :(', weight: FontWeight.bold, size: 18),
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
