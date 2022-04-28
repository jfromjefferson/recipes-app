import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes/controllers/app_controller.dart';
import 'package:recipes/database/models/recipe/recipe.dart';
import 'package:recipes/database/queries/favorite/queries.dart';
import 'package:recipes/utils/ads_keys.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';
import 'package:recipes/widgets/custom_ads.dart';

import '../database/models/settings/settings.dart';
import '../database/queries/settings/queries.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;
  final Color color;

  RecipeScreen({Key? key, required this.recipe, required this.color}) : super(key: key);

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final AppController appController = Get.put(AppController());

  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsKeys().getInterstitial(),
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) {
          interstitialAd.load();
        }
      },
    );

    interstitialAd.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: appController.setRecipeFavorite(recipe: widget.recipe),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          return Scaffold(
            appBar: AppBar(
              title: CustomText(text: widget.recipe.title.capitalizeFirst!),
              actions: [
                IconButton(
                  onPressed: () async {
                    await recipeToFavorite(recipe: widget.recipe);
                    await appController.setRecipeFavorite(recipe: widget.recipe);

                    Settings? settings = await getSettingsObject();

                    bool? isLoaded = await interstitialAd.isLoaded;

                    if(isLoaded ?? false){
                      if(appController.isRecipeFavorite.value){
                        if(settings!.showAds){
                          interstitialAd.show();
                        }
                      }
                    }

                  },
                  icon: Obx(() => Icon(appController.isRecipeFavorite.value ? Icons.favorite : Icons.favorite_border)),
                )
              ],
              backgroundColor: widget.color,
            ),
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListView(
                children: [
                  CustomText(text: widget.recipe.title, size: 28, align: TextAlign.center),
                  CustomText(text: 'Serve ${widget.recipe.serve}', size: 20, align: TextAlign.center),
                  Divider(
                    height: 15,
                    color: widget.color,
                  ),
                  SizedBox(height: 10),
                  CustomAds(size: AdmobBannerSize.FULL_BANNER),
                  SizedBox(height: 10),
                  CustomText(text: 'Ingredientes', size: 18, align: TextAlign.center),
                  SizedBox(height: 15),
                  formatItems(itemList: widget.recipe.ingredientList, appController: appController, color: widget.color),
                  SizedBox(height: 15),
                  CustomText(text: 'Modo de preparo', size: 18, align: TextAlign.center),
                  SizedBox(height: 10),
                  CustomAds(size: AdmobBannerSize.FULL_BANNER),
                  SizedBox(height: 15),
                  formatItems(itemList: widget.recipe.instructions, appController: appController, color: widget.color),
                  SizedBox(height: 10),
                  CustomAds(size: AdmobBannerSize.LARGE_BANNER)
                ],
              ),
            ),
          );
        }else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
