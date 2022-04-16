import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipes/screens/main_screen.dart';
import 'package:recipes/utils/colors.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/utils/register_adapter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  registerAdapter();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Cache
  await createCategoryCache();
  await createRecipeCache();
  // Cache

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Receitas',
      theme: ThemeData.light().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor
      ),
      home: MainScreen(),
    );
  }
}
