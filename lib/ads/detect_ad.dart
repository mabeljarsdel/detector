// import 'dart:developer';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'ad_helper.dart';

// class DetectAd {
//   static InterstitialAd? _ad;
//   static bool isAddReady = false;

//   static void loadSaveAd() {
//     InterstitialAd.load(
//         adUnitId: AdHelper.detectAd,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             isAddReady = true;
//             _ad = ad;
//           },
//           onAdFailedToLoad: (error) {
//             log(error.toString());
//           },
//         ));
//   }

//   static void showSaveAd() {
//     if (isAddReady) {
//       _ad!.show();
//     }
//   }
// }
