import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:recipes/utils/ads_keys.dart';

class CustomAds extends StatelessWidget {
  final AdmobBannerSize size;

  CustomAds({required this.size});

  Future<bool> loading() async {
    await Future.delayed(Duration(seconds: 1));

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loading(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          //return Text('AAAAAAAAAAAAAAAAAAAAAAAAA');
          return AdmobBanner(
            adSize: size,
            adUnitId: AdsKeys().getBannerId(),
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}
