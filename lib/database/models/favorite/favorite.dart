import 'package:hive/hive.dart';
import 'package:recipes/database/models/recipe/recipe.dart';

part 'favorite.g.dart';

@HiveType(typeId: 2)
class Favorite extends HiveObject {
  @HiveField(0)
  late List<Recipe> recipeList;

  Favorite({required this.recipeList});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'recipeList': recipeList,
    };

    return map;
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    recipeList = map['recipeList'];
  }

}