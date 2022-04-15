import 'package:get/get.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/database/queries/category/queries.dart';
import 'package:recipes/services/requests.dart';
import 'package:recipes/utils/urls.dart';

class AppController extends GetxController {

  @override
  void onInit() async {
    try {
      final response = await fetchData(path: RecipeApiUrl.categoryUrl);

      if(response.statusCode == 200){
        List<dynamic> categoryInfo = response.data['category_info'];

        categoryInfo.forEach((categoryInfoTemp) {
          Category category = Category(
            iconSrc: categoryInfoTemp['icon_src'],
            recipeCount: categoryInfoTemp['recipe_count'],
            title: categoryInfoTemp['name'],
            uuid: categoryInfoTemp['uuid'],
          );

          saveCategory(category: category);
        });
      }

    } catch(e) {
      // TODO: Show snack bar with error message
      print(e);
    }

    super.onInit();
  }
}