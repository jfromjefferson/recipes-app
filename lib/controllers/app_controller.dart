import 'package:get/get.dart';

class AppController extends GetxController {
  var itemToCheckMap = {}.obs;

  void checkItem({required String element}) {
    itemToCheckMap[element] = !itemToCheckMap[element];

    return itemToCheckMap[element];
  }

}