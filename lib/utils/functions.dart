import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recipes/database/models/category/category.dart';
import 'package:recipes/database/queries/category/queries.dart';
import 'package:recipes/utils/colors.dart';
import 'package:recipes/widgets/customText.dart';

Future<List<Widget>> categoryCardList() async {
  List<Category> categoryList = await getCategoryList();
  List<Widget> categoryWidgetList = [];

  categoryList.forEach((categoryTemp) {
    categoryWidgetList.add(
      GestureDetector(
        onTap: (){},
        child: Container(
            width: Get.mediaQuery.size.width/2.2,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              color: Color(0xffB2E1EE),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                )
              ],
            ),
            constraints: BoxConstraints(
              minHeight: 240,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomText(text: categoryTemp.title, size: 18, color: textColor, align: TextAlign.center),
                    CustomText(text: '${categoryTemp.recipeCount} ${categoryTemp.recipeCount == 1 ? 'receita': 'receitas'}', size: 16, color: textColor),
                  ],
                ),
                SvgPicture.network(categoryTemp.iconSrc, height: 100),
              ],
            )
        ),
      )
    );
  });

  return categoryWidgetList;
}