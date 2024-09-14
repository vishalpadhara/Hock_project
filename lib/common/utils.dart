import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hocky_game/common/color_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'image_res.dart';

// int isAdsShow;

class Utils {
  static String apiKey = "e7ac4e86fc71bb0edf9c83c3d6b43890";
  static String pollFishAdsKeyAndroid = "2d1bae65-7ef7-43ba-b7cd-7bf5db60c876";



  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static getAssetsImg(String name) {
    return "assets/images/" + name + ".png";
  }

  static getAssetsIcons(String name) {
    return "assets/icons/" + name + ".png";
  }

  static getAssetsStatusImage(String name) {
    return "assets/images/" + name;
  }

  static imageShow(String img, String size) {

    print(img);
    String host = 'https://www.color-hex.com/palettes/7707.png';
    String baseImage = "https://image.tmdb.org/t/p/";
    String finalUrl;
    //w200 w300 , w400, w500
    if(img == null) {
      finalUrl =  host;
    } else {
      finalUrl = baseImage + size + img;
    }

    return finalUrl;
  }

  static boxShadowShow() {
    return Shadow(
      offset: const Offset(1.0, 1.0),
      blurRadius: 20.0,
      color: ColorRes.primaryColor.withOpacity(0.2),
    );
  }

  static dividerView(BuildContext context) {
    return Container(
      height: 1,
      width: Utils.getDeviceWidth(context),
      color: ColorRes.boarderColor,
    );
  }

  // static void openEmail({String toEmail, String subject, String body}) {}

  /* static showToast(String message) {
    Fluttertoast.showToast (
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: ColorRes.primaryColor,
        textColor: Colors.white );
  } */

/*
  //banner
  static bannerAds() {
    return FacebookBannerAd (
      // placementId: "337760660733436_337761264066709", //live
      placementId: "485808162628307_485810442628079", //live
      // placementId: "1208697806196636_1208698539529896", //new troop
      //806906003419323
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        switch (result) {
          case BannerAdResult.ERROR:
            print("Error: $value");
            break;
          case BannerAdResult.LOADED:
            print("Loaded: $value");
            break;
          case BannerAdResult.CLICKED:
            print("Clicked: $value");
            break;
          case BannerAdResult.LOGGING_IMPRESSION:
            print("Logging Impression: $value");
            break;
        }
      },
    );
  }

  static interstitialAds() {
    return FacebookInterstitialAd.loadInterstitialAd( // rto
//       placementId: "337760660733436_337762114066624", //live
//       placementId: "757334581857282_757335791857161", //live
      placementId: "485808162628307_485809525961504", //live
      listener: (result, value) {
        if (result == InterstitialAdResult.LOADED)
          FacebookInterstitialAd.showInterstitialAd(delay: 5000);
      },
    );
  }

  *//*MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    testDevices: StringRes.testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar', 'Game', 'Games', 'pubg', 'mobile', 'car'],
//    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );


  static bannerAds() {
    return BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: BannerAd.testAdUnitId,
      // adUnitId: "ca-app-pub-2155095013191401/3888023984",
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }


  static fullScreenAds() {
    return InterstitialAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: InterstitialAd.testAdUnitId,
      // adUnitId: "ca-app-pub-2155095013191401/9751898218",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }*/


static setIntData(int score)async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('scoreData', score);
}
static Future<int> getIntData()async{
  final prefs = await SharedPreferences.getInstance();
  int score = prefs.getInt('scoreData')??0;
  return score;
}

static musicPlayOnClick(){
  AudioPlayer clickMusic = AudioPlayer();
  clickMusic.play(AssetSource(ImageRes.clickS));
}

}



