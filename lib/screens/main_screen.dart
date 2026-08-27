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
