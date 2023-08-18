import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum Ads {
  /// Native Ad displayed in the Counter Page.
  adNative(
    iOS: 'ca-app-pub-9322409353550885/8814732046',
    android: 'ca-app-pub-9322409353550885/9916894877',
    iOSTest: 'ca-app-pub-3940256099942544/3986624511',
    androidTest: 'ca-app-pub-3940256099942544/2247696110',
  ),
  _adRewardedInterstitial(
    iOS: 'ca-app-pub-9322409353550885/4020009869',
    android: 'ca-app-pub-9322409353550885/4255242764',
    iOSTest: 'ca-app-pub-3940256099942544/6978759866',
    androidTest: 'ca-app-pub-3940256099942544/5354046379',
  ),
  adBanner(
    iOS: 'ca-app-pub-9322409353550885/5375918597',
    android: 'ca-app-pub-9322409353550885/3611981600',
    iOSTest: 'ca-app-pub-3940256099942544/2934735716',
    androidTest: 'ca-app-pub-3940256099942544/6300978111',
  );

  const Ads({
    required this.iOS,
    required this.android,
    required this.iOSTest,
    required this.androidTest,
  });

  /// iOS Ad id.
  final String iOS;

  /// Android Ad id.
  final String android;

  /// iOS Ad id for testing.
  final String iOSTest;

  /// Android Ad id for testing.
  final String androidTest;
}

const int maxFailedLoadAttempts = 3;

class AdsClient {
  AdsClient() {
    _ads = _initializeAds();
  }

  late final Map<Ads, String> _ads;
  int _numRewardedInterstitialLoadAttempts = 0;
  RewardedInterstitialAd? _rewardedInterstitialAd;

  Map<Ads, String> _initializeAds() {
    final ads = <Ads, String>{};
    for (final ad in Ads.values) {
      if (Platform.isIOS) {
        if (kDebugMode) {
          print('ad ios debug');
          ads[ad] = ad.iOSTest;
        } else {
          print('ad ios release');
          ads[ad] = ad.iOS;
        }
      } else {
        if (kDebugMode) {
          print('ad android debug');
          ads[ad] = ad.androidTest;
        } else {
          print('ad android release');
          ads[ad] = ad.android;
        }
      }
    }
    return ads;
  }

  Future<NativeAd> getNativeAd() async {
    try {
      return await _populateNativeAd(
          adUnitId: _ads[Ads.adNative]!, templateType: TemplateType.small);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<BannerAd> getBannerAd() async {
    try {
      return await _populateBannerAd(adUnitId: _ads[Ads.adBanner]!);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> getRewardedInterstitialAd(
      {required Function() getReward, required Function() closeAd}) async {
    try {
      _rewardedInterstitialAd = await _populateRewardedInterstitialAd(
          adUnitId: _ads[Ads._adRewardedInterstitial]!);

      _rewardedInterstitialAd?.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        _rewardedInterstitialAd?.dispose();
        _populateRewardedInterstitialAd(
            adUnitId: _ads[Ads._adRewardedInterstitial]!);
        closeAd();
      }, onAdFailedToShowFullScreenContent:
              (RewardedInterstitialAd ad, AdError error) {
        _rewardedInterstitialAd?.dispose();
        _populateRewardedInterstitialAd(
            adUnitId: _ads[Ads._adRewardedInterstitial]!);
      });
      _rewardedInterstitialAd!.setImmersiveMode(true);
      _rewardedInterstitialAd!.show(
          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
        getReward();
      });
      _rewardedInterstitialAd = null;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<NativeAd> _populateNativeAd({
    required String adUnitId,
    TemplateType? templateType,
  }) async {
    try {
      final adCompleter = Completer<Ad?>();
      await NativeAd(
        adUnitId: adUnitId,
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: adCompleter.complete,
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('$NativeAd failedToLoad: $error');
            ad.dispose();
            adCompleter.completeError(error);
          },
          onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
          onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
        ),
        nativeTemplateStyle: NativeTemplateStyle(
          templateType: templateType ?? TemplateType.medium,
          mainBackgroundColor: Colors.white12,
          callToActionTextStyle: NativeTemplateTextStyle(
            size: 16.0,
          ),
          primaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black38,
            backgroundColor: Colors.white70,
          ),
        ),
      ).load();
      final nativeAd = await adCompleter.future;
      if (nativeAd == null) {
        throw const FormatException('Native Ad was null');
      }
      return nativeAd as NativeAd;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<BannerAd> _populateBannerAd({
    required String adUnitId,
    AdSize? size,
  }) async {
    try {
      final adCompleter = Completer<Ad?>();
      await BannerAd(
        adUnitId: adUnitId,
        size: size ?? AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: adCompleter.complete,
          onAdFailedToLoad: (ad, error) {
            // Releases an ad resource when it fails to load
            ad.dispose();
            adCompleter.completeError(error);
          },
        ),
      ).load();

      final nativeAd = await adCompleter.future;
      if (nativeAd == null) {
        throw const FormatException('Native Ad was null');
      }
      return nativeAd as BannerAd;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<RewardedInterstitialAd> _populateRewardedInterstitialAd(
      {required String adUnitId}) async {
    try {
      final adCompleter = Completer<Ad?>();
      print('_populateRewardedInterstitialAd');
      await RewardedInterstitialAd.load(
          adUnitId: adUnitId,
          request: const AdRequest(),
          rewardedInterstitialAdLoadCallback:
              RewardedInterstitialAdLoadCallback(
            onAdLoaded: (RewardedInterstitialAd ad) {
              adCompleter.complete(ad);
              _numRewardedInterstitialLoadAttempts = 0;
            },
            onAdFailedToLoad: (LoadAdError error) {
              print('RewardedInterstitialAd failed to load: $error');

              _numRewardedInterstitialLoadAttempts += 1;
              if (_numRewardedInterstitialLoadAttempts <
                  maxFailedLoadAttempts) {
                _populateRewardedInterstitialAd(
                    adUnitId: _ads[Ads._adRewardedInterstitial]!);
              }
            },
          ));

      final rewardedInterstitial = await adCompleter.future;
      if (rewardedInterstitial == null) {
        throw const FormatException('Rewarded Ad was null');
      }
      return rewardedInterstitial as RewardedInterstitialAd;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
