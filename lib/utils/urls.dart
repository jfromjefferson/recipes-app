
import 'package:recipes/utils/keys.dart';

class RecipeApiUrl {
  static String recipeUrl = 'https://backend-base-app.herokuapp.com/recipes/api/recipe/list/?sys_user_uuid=${BackendKeys.sysUserUuid}';
  static String categoryUrl = 'https://backend-base-app.herokuapp.com/recipes/api/category/list/?sys_user_uuid=${BackendKeys.sysUserUuid}';
}