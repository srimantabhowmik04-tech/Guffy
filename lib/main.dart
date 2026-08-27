// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase এবং AdMob ইনিশিয়ালাইজ করা
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  
  runApp(const GuffyApp());
}

class GuffyApp extends StatelessWidget {
  const GuffyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guffy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(), // আপাতত সরাসরি লগইন স্ক্রিন দেখাবে
    );
  }
}
