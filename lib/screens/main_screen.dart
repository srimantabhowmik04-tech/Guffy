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
