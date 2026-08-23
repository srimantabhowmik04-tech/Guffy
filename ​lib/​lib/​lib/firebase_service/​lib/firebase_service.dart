// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase Initialize
  await Firebase.initializeApp();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GuffyFeedScreen(),
    );
  }
}

// --- News Feed Screen with Firebase Realtime Data ---
class GuffyFeedScreen extends StatelessWidget {
  const GuffyFeedScreen({super.key});

  final List<String> stories = const [
    'My Story', 'Rahul', 'Ananya', 'Srijan', 'Sneha', 'Arijit'
  ];

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text(
          'Guffy',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, letterSpacing: 1.2),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Create Post Box
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePostScreen()),
              );
            },
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text('What\'s on your mind?'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Stories Bar
          Container(
            color: Colors.white,
            height: 105,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.deepPurple,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Icon(
                            index == 0 ? Icons.add : Icons.person,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(stories[index], style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Realtime Posts from Firestore
          StreamBuilder<QuerySnapshot>(
            stream: firebaseService.getPostsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Text('No posts yet. Write the first post!'),
                  ),
                );
              }

              final docs = snapshot.data!.docs;

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final post = docs[index].data() as Map<String, dynamic>;
                  final String docId = docs[index].id;
                  final String author = post['author'] ?? 'User';
                  final String content = post['content'] ?? '';
                  final int likes = post['likes'] ?? 0;
                  final int comments = post['comments'] ?? 0;

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.deepPurple.shade100,
                                child: Text(
                                  author[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    author,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Text(
                                    'Recent',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(content, style: const TextStyle(fontSize: 15)),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () => firebaseService.likePost(docId, likes),
                                child: Row(
                                  children: [
                                    const Icon(Icons.thumb_up_outlined, size: 20, color: Colors.deepPurple),
                                    const SizedBox(width: 6),
                                    Text('$likes Likes'),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.mode_comment_outlined, size: 20, color: Colors.grey),
                                  const SizedBox(width: 6),
                                  Text('$comments Comments'),
                                ],
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.share_outlined, size: 20, color: Colors.grey),
                                  SizedBox(width: 6),
                                  Text('Share'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
      ),
    );
  }
}

// --- Create Post Screen with Firestore Insertion ---
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _submitPost() async {
    final text = _postController.text.trim();
    if (text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await _firebaseService.addNewPost(
        author: 'Srimanta Bhowmik',
        content: text,
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Post', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
                elevation: 0,
              ),
              onPressed: _isLoading ? null : _submitPost,
              child: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Post', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Srimanta Bhowmik', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.public, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Text('Public', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _postController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  hintText: 'What\'s on your mind on Guffy?',
                  border: InputBorder.none,
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.photo_library, color: Colors.green),
                  label: const Text('Photo/Video', style: TextStyle(color: Colors.black87)),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: const Icon(Icons.tag_faces, color: Colors.amber),
                  label: const Text('Feeling', style: TextStyle(color: Colors.black87)),
                  onPressed: () {},
                ),
                TextButton.icon(
                  icon: const Icon(Icons.location_on, color: Colors.redAccent),
                  label: const Text('Location', style: TextStyle(color: Colors.black87)),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Profile Screen ---
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                color: Colors.deepPurple.shade200,
                child: const Center(
                  child: Icon(Icons.panorama, size: 48, color: Colors.white70),
                ),
              ),
              const Positioned(
                bottom: -50,
                child: CircleAvatar(
                  radius: 54,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.person, size: 55, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 55),
          const Center(
            child: Column(
              children: [
                Text(
                  'Srimanta Bhowmik',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  'Building the future with Flutter & Guffy 🚀',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Add to Story'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'My Posts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            elevation: 1,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to my profile on Guffy!', style: TextStyle(fontSize: 15)),
                  SizedBox(height: 8),
                  Text('Just now • Public', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

