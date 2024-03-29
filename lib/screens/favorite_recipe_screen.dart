import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:recipes/database/models/favorite/favorite.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';
import 'package:recipes/widgets/custom_ads.dart';

class FavoriteRecipeScreen extends StatefulWidget {
  final Favorite favorite;

  const FavoriteRecipeScreen({Key? key, required this.favorite}) : super(key: key);

  @override
  State<FavoriteRecipeScreen> createState() => _FavoriteRecipeScreenState();
}

class _FavoriteRecipeScreenState extends State<FavoriteRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Receitas salvas'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, top: 10, right: 5),
        child: FutureBuilder(
          future: recipeCardList(favorite: widget.favorite),
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
                      CustomAds(size: AdmobBannerSize.FULL_BANNER),
                      SizedBox(height: 10),
                      StaggeredGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: snapshot.data,
                      )
                    ],
                  ),
                );
              }else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: 'Nenhuma receita salva :(', size: 19, weight: FontWeight.bold),
                      SizedBox(height: 10),
                      CustomAds(size: AdmobBannerSize.LARGE_BANNER)
                    ],
                  ),
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
