// lib/screens/main_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(), // সোয়াইপ বন্ধ রাখতে
        children: const [
          Center(child: Text('Home Feed Screen')),
          Center(child: Text('Search Screen')),
          Center(child: Text('Add Post Screen')),
          Center(child: Text('Notifications Screen')),
          Center(child: Text('Profile Screen')),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        currentIndex: _page,
        onTap: _navigationTapped,
        activeColor: Colors.deepPurple,
        inactiveColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
// main_screen.dart এর PageView এর ভেতরের অংশ
children: const [
  FeedScreen(), // ✅ হোম ফিড স্ক্রিন যুক্ত হলো
  Center(child: Text('Search Screen')),
  Center(child: Text('Add Post Screen')),
  Center(child: Text('Notifications Screen')),
  Center(child: Text('Profile Screen')),
],
// lib/screens/main_screen.dart এর PageView এর ভেতরের অংশ
children: const [
  FeedScreen(),
  Center(child: Text('Search Screen')),
  AddPostScreen(), // ✅ ৩. AddPostScreen যুক্ত করা হলো
  Center(child: Text('Notifications Screen')),
  Center(child: Text('Profile Screen')),
],
// lib/screens/main_screen.dart এর PageView অংশ
children: const [
  FeedScreen(),
  Center(child: Text('Search Screen')),
  AddPostScreen(),
  Center(child: Text('Notifications Screen')),
  ProfileScreen(), // ✅ ৪. ProfileScreen যুক্ত হলো
],
// lib/main.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/auth/login_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase ও AdMob ইনিশিয়ালাইজেশন
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
      // ইউজার লগইন করা থাকলে সরাসরি MainScreen, অন্যথায় LoginScreen দেখাবে
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasData) {
            return const MainScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
// lib/screens/main_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'feed/feed_screen.dart';
import 'post/add_post_screen.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(), // স্ক্রিন সোয়াইপ বন্ধ রাখতে
        children: const [
          FeedScreen(),      // ১. Home Feed
          Center(child: Text('Search Screen', style: TextStyle(fontSize: 18))), // ২. Search (ভবিষ্যতের জন্য)
          AddPostScreen(),   // ৩. Create/Upload Post
          Center(child: Text('Activity Screen', style: TextStyle(fontSize: 18))), // ৪. Notifications/Activity
          ProfileScreen(),   // ৫. User Profile
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        currentIndex: _page,
        onTap: _navigationTapped,
        activeColor: Colors.deepPurple,
        inactiveColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
