
import 'package:recipes/utils/keys.dart';

class RecipeApiUrl {
  static String recipeUrl = 'https://1e66-179-216-107-69.ngrok.io/recipes/api/recipe/list/?sys_user_uuid=${BackendKeys.sysUserUuid}';
  static String categoryUrl = 'https://1e66-179-216-107-69.ngrok.io/recipes/api/category/list/?sys_user_uuid=${BackendKeys.sysUserUuid}';
}