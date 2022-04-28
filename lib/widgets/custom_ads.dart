import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:recipes/database/models/settings/settings.dart';
import 'package:recipes/utils/ads_keys.dart';

import '../database/queries/settings/queries.dart';

class CustomAds extends StatefulWidget {
  final AdmobBannerSize size;

  CustomAds({required this.size});

  @override
  State<CustomAds> createState() => _CustomAdsState();
}

class _CustomAdsState extends State<CustomAds> {
  Settings? settings;
  bool showAds = true;

  Future<bool> loading() async {
    await Future.delayed(Duration(seconds: 1));

    return true;
  }

  @override
  void initState() {
    getSettingsObject().then((settings) {
      if(settings != null){
        if(!settings.showAds){
          showAds = false;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loading(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData && showAds){
          return AdmobBanner(
            adSize: widget.size,
            adUnitId: AdsKeys().getBannerId(),
          );
        }else{
          return SizedBox();
        }
      },
    );
  }
}
