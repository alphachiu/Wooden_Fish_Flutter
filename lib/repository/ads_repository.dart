import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:woodenfish_bloc/repository/ad_client/ad_client.dart';

class AdsRepository {
  const AdsRepository({required AdsClient adsClient}) : _adsClient = adsClient;

  final AdsClient _adsClient;

  Future<NativeAd?> getNativeAd() async {
    try {
      return await _adsClient.getNativeAd();
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  }

  Future<BannerAd?> getBannerAd() async {
    try {
      return await _adsClient.getBannerAd();
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  }

  Future<void> getRewardedInterstitialAd(
      {required Function() getReward, required Function() closeAd}) async {
    try {
      return await _adsClient.getRewardedInterstitialAd(
          getReward: getReward, closeAd: closeAd);
    } catch (e, st) {
      Error.throwWithStackTrace(e, st);
    }
  }
}
