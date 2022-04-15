import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:recipes/controllers/app_controller.dart';
import 'package:recipes/database/queries/category/queries.dart';
import 'package:recipes/utils/colors.dart';
import 'package:recipes/utils/functions.dart';
import 'package:recipes/widgets/customText.dart';
import 'package:recipes/widgets/customTextField.dart';

class MainScreen extends StatelessWidget {
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            getCategoryList().then((value) {
              print(value);
            });
            Get.focusScope?.unfocus();
          },
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Column(
              children: [
                CustomTextField(
                  onChanged: (String value){},
                  onPressed: (){
                    print('oii');
                  },
                  hintText: 'Procurar receita',
                  fillColor: Colors.white,
                  textColor: Colors.black,
                  icon: Icons.search,
                  borderRadius: 10,
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      CustomText(
                        text: 'Categorias adicionadas recentemente',
                        size: 20,
                        align: TextAlign.center,
                        weight: FontWeight.bold,
                        color: textColor,
                      ),
                      SizedBox(height: 10),
                      FutureBuilder(
                        future: categoryCardList(),
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                          if(snapshot.hasData){
                            return Wrap(
                              runSpacing: 5,
                              alignment: WrapAlignment.spaceEvenly,
                              children: snapshot.data,
                            );
                          }else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      CustomText(
                        text: 'Últimas receitas',
                        size: 20,
                        align: TextAlign.center,
                        weight: FontWeight.bold,
                        color: textColor,
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        runSpacing: 5,
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: Get.mediaQuery.size.width/2.2,
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                              decoration: BoxDecoration(
                                color: Color(0xffb8eeb2),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(text: 'Bolo de cenoura', size: 18, align: TextAlign.center),
                                  SizedBox(height: 10),
                                  CustomText(text: '2300 pessoas gostaram disso', align: TextAlign.center),
                                ],
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
