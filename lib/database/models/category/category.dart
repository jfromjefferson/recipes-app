import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String iconSrc;

  @HiveField(2)
  late String uuid;

  @HiveField(3)
  late int recipeCount;

  Category({required this.iconSrc, required this.recipeCount, required this.title, required this.uuid});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'title': title,
      'iconSrc': iconSrc,
      'uuid': uuid,
      'recipeCount': recipeCount,
    };

    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    iconSrc = map['iconSrc'];
    uuid = map['uuid'];
    recipeCount = map['recipeCount'];
  }

}