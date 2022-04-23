import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:recipes/utils/ads_keys.dart';

class BannerAds extends StatefulWidget {
  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  BannerAd bannerAd = BannerAd(
    adUnitId: AdsKeys().getBannerId(),
    request: AdRequest(),
    size: AdSize.fullBanner,
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) {},
      onAdFailedToLoad: (Ad ad, LoadAdError error) {},
      onAdOpened: (Ad ad) => {},
      onAdClosed: (Ad ad) => {},
    ),
  );

  @override
  void initState() {

    bannerAd.load();

    super.initState();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AdWidget(ad: bannerAd),
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
    );
  }
}


class LargerBanner extends StatefulWidget {
  const LargerBanner({Key? key}) : super(key: key);

  @override
  State<LargerBanner> createState() => _LargerBannerState();
}

class _LargerBannerState extends State<LargerBanner> {
  BannerAd bannerAd = BannerAd(
    adUnitId: AdsKeys().getBannerId(),
    request: AdRequest(),
    size: AdSize.largeBanner,
    listener: BannerAdListener(
      onAdLoaded: (Ad ad) {},
      onAdFailedToLoad: (Ad ad, LoadAdError error) {},
      onAdOpened: (Ad ad) => {},
      onAdClosed: (Ad ad) => {},
    ),
  );

  @override
  void initState() {

    bannerAd.load();

    super.initState();
  }

  @override
  void dispose() {
    bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AdWidget(ad: bannerAd),
      width: bannerAd.size.width.toDouble(),
      height: bannerAd.size.height.toDouble(),
    );
  }
}

