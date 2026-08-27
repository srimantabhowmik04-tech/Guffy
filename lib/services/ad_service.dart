// lib/services/ad_service.dart
import 'dart:io';

class AdService {
  // টেস্ট ব্যানার অ্যাড ইউনিট আইডি
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Android Test Banner ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // iOS Test Banner ID
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // টেস্ট ইন্টারস্টিশিয়াল অ্যাড ইউনিট আইডি
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Android Test Interstitial ID
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // iOS Test Interstitial ID
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
