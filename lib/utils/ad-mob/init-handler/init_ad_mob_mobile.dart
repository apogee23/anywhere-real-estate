// import 'package:realogy/utils/ad-mob/ad_helper.dart';
// import 'package:realogy/utils/ad-mob/init-handler/init_ad_mob.dart';
// // import 'package:google_mobile_ads/google_mobile_ads.dart';

// AdmobWrapper createAdmobWrapper() => AdmobWrapperIO();

// class AdmobWrapperIO implements AdmobWrapper {
//   factory AdmobWrapperIO() => _instance;
//   AdmobWrapperIO._internal();
//   static final AdmobWrapperIO _instance = AdmobWrapperIO._internal();

//   @override
//   Future<void> init() async {
//     // MobileAds.instance.initialize();
//   }

//   @override
//   void createBannerAd({
//     void Function(Ad)? onAdLoaded,
//   }) {
//     BannerAd(
//       adUnitId: AdHelper.bannerAdUnitId,
//       request: const AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         onAdLoaded: (ad) {
//           // setState(() {
//           //   _bannerAd = ad as BannerAd;
//           // });
//           onAdLoaded?.call(ad);
//         },
//         onAdFailedToLoad: (ad, err) {
//           print('Failed to load a banner ad: ${err.message}');
//           ad.dispose();
//         },
//       ),
//     ).load();
//   }
// }
