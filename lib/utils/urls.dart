
import 'package:recipes/utils/keys.dart';

class RecipeApiUrl {
  static String recipeUrl = 'https://a646-177-143-226-86.ngrok.io/recipes/api/recipe/list/?sys_user_uuid=${BackendKeys.sysUserUuid}';
  static String categoryUrl = 'https://a646-177-143-226-86.ngrok.io/recipes/api/category/list/?sys_user_uuid=${BackendKeys.sysUserUuid}';
}