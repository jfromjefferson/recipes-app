import 'package:hive/hive.dart';
import 'package:recipes/database/models/category/category.dart';
part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String serve;

  @HiveField(2)
  late List<String> ingredientList;

  @HiveField(3)
  late List<String> instructions;

  @HiveField(4)
  late int likes;

  @HiveField(5)
  late String uuid;

  @HiveField(6)
  late Category category;

  Recipe({
    required this.uuid,
    required this.title,
    required this.ingredientList,
    required this.instructions,
    required this.likes,
    required this.serve,
    required this.category
    });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'uuid': uuid,
      'title': title,
      'ingredientList': ingredientList,
      'instructions': instructions,
      'likes': likes,
      'serve': serve,
      'category': category,
    };

    return map;
  }

  Recipe.fromMap(Map<String, dynamic> map) {
    uuid = map['uuid'];
    title = map['title'];
    ingredientList = map['ingredientList'];
    instructions = map['instructions'];
    likes = map['likes'];
    serve = map['serve'];
    category = map['category'];
  }

}
