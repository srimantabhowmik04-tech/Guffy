import 'package:flutter/material.dart';

void main() {
  runApp(const GuffyApp());
}

class GuffyApp extends StatelessWidget {
  const GuffyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guffy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1976D2),
          background: const Color(0xFFE3F2FD),
        ),
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool isPhoneMode = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool otpSent = false;

  // হোম পেজে নিয়ে যাওয়ার ফাংশন
  void goToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: Text(
          isPhoneMode ? 'Phone Login' : (isLogin ? 'Sign In to Guffy' : 'Create Guffy Account'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0D47A1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.people_alt_rounded,
                size: 60,
                color: Color(0xFF1976D2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isPhoneMode
                  ? 'Verify your mobile number'
                  : (isLogin ? 'Welcome back to Guffy' : 'Join the Guffy Community'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!isPhoneMode) ...[
                      if (!isLogin) ...[
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: const Icon(Icons.person, color: Color(0xFF1976D2)),
                            filled: true,
                            fillColor: const Color(0xFFE3F2FD).withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: const Icon(Icons.email, color: Color(0xFF1976D2)),
                          filled: true,
                          fillColor: const Color(0xFFE3F2FD).withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock, color: Color(0xFF1976D2)),
                          filled: true,
                          fillColor: const Color(0xFFE3F2FD).withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      if (isLogin)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Password reset link sent to your email')),
                              );
                            },
                            child: const Text('Forgot Password?'),
                          ),
                        ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1976D2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // সাইন-ইন বাটনে ক্লিক করলে সরাসরি হোমপেজে যাবে
                          goToHomePage();
                        },
                        child: Text(
                          isLogin ? 'Sign In' : 'Sign Up',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                        child: Text(
                          isLogin
                              ? "Don't have an account? Sign Up"
                              : "Already have an account? Sign In",
                          style: const TextStyle(color: Color(0xFF0D47A1)),
                        ),
                      ),
                      const Divider(height: 28),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.g_mobiledata, size: 28, color: Colors.red),
                        label: const Text(
                          'Continue with Google',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Colors.black12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // গুগল সাইন-ইনে ক্লিক করলেও হোমপেজে যাবে
                          goToHomePage();
                        },
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        icon: const Icon(Icons.phone_android, color: Color(0xFF1976D2)),
                        label: const Text(
                          'Use Phone Number & OTP',
                          style: TextStyle(color: Color(0xFF1976D2)),
                        ),
                        onPressed: () {
                          setState(() {
                            isPhoneMode = true;
                          });
                        },
                      ),
                    ] else ...[
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number (e.g. +91...)',
                          prefixIcon: const Icon(Icons.phone, color: Color(0xFF1976D2)),
                          filled: true,
                          fillColor: const Color(0xFFE3F2FD).withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      if (otpSent) ...[
                        TextField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter 6-digit OTP',
                            prefixIcon: const Icon(Icons.sms, color: Color(0xFF1976D2)),
                            filled: true,
                            fillColor: const Color(0xFFE3F2FD).withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1976D2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (!otpSent) {
                            setState(() {
                              otpSent = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('OTP sent to your phone!')),
                            );
                          } else {
                            // ওটিপি ভেরিফাই হয়ে হোমপেজে যাবে
                            goToHomePage();
                          }
                        },
                        child: Text(
                          otpSent ? 'Verify OTP & Login' : 'Send OTP',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isPhoneMode = false;
                            otpSent = false;
                          });
                        },
                        child: const Text('Back to Email & Password'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// মূল অ্যাপ স্ক্রিন (ফিড, পোস্ট ও প্রোফাইল)
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    FeedPage(),
    CreatePostPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add_box_rounded), label: 'Post'),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'guffy.',
          style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0D47A1), fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.grey),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 100,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildStoryItem('My Story', Icons.add),
                _buildStoryItem('Rahul', Icons.person),
                _buildStoryItem('Ananya', Icons.person),
                _buildStoryItem('Srijan', Icons.person),
                _buildStoryItem('Sneha', Icons.person),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _buildPostCard('Srimanta Bhowmik', 'S', 'Welcome to Guffy! The next-gen social media app is live 🚀', '12 Likes', '3 Comments'),
          _buildPostCard('Rahul Sharma', 'R', 'Loving the clean UI of Guffy! Great work team.', '8 Likes', '1 Comments'),
        ],
      ),
    );
  }

  Widget _buildStoryItem(String name, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF1976D2),
            child: CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              child: Icon(icon, color: const Color(0xFF1976D2)),
            ),
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildPostCard(String author, String initial, String content, String likes, String comments) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE3F2FD),
                  child: Text(initial, style: const TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Text(author, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            Text(content, style: const TextStyle(fontSize: 14)),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [const Icon(Icons.thumb_up_alt_outlined, size: 18, color: Color(0xFF1976D2)), const SizedBox(width: 4), Text(likes)]),
                Row(children: [const Icon(Icons.mode_comment_outlined, size: 18, color: Colors.grey), const SizedBox(width: 4), Text(comments)]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post'), backgroundColor: Colors.white, foregroundColor: const Color(0xFF0D47A1)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1976D2), foregroundColor: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post Published!')));
              },
              child: const Text('Share Post'),
            )
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile'), backgroundColor: Colors.white, foregroundColor: const Color(0xFF0D47A1)),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFF1976D2),
              child: Text('S', style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            Text('Srimanta Bhowmik', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Building Guffy Social Network 🚀', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
