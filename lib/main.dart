// lib/main.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // ১. Firebase ও Google Mobile Ads চালু করা
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
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      // ২. অথেন্টিকেশন স্টেট যাচাই
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // ডাটা লোড হওয়ার সময় লোডার দেখাবে
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Colors.deepPurple),
              ),
            );
          }

          // ইউজার লগইন করা থাকলে সরাসরি মূল অ্যাপে নিয়ে যাবে
          if (snapshot.hasData) {
            return const MainScreen();
          }

          // লগইন না করা থাকলে লগইন স্ক্রিনে নিয়ে যাবে
          return const LoginScreen();
        },
      ),
    );
  }
}
