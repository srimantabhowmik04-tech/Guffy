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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GuffyFeedScreen(),
    );
  }
}

class GuffyFeedScreen extends StatelessWidget {
  const GuffyFeedScreen({super.key});

  final List<String> stories = const [
    'My Story', 'Rahul', 'Ananya', 'Srijan', 'Sneha', 'Arijit'
  ];

  final List<Map<String, dynamic>> posts = const [
    {
      'author': 'Rahul Sharma',
      'time': '2h ago',
      'content': 'Welcome to Guffy! Excited to connect with everyone here. 🎉✨',
      'likes': 35,
      'comments': 8,
    },
    {
      'author': 'Ananya Roy',
      'time': '4h ago',
      'content': 'Loving the vibe of Guffy. What is everyone working on today?',
      'likes': 52,
      'comments': 14,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          // 1. Create Post Header
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

          // 2. Stories Bar
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

          // 3. News Feed Posts
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
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
                              post['author'][0],
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['author'],
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                post['time'],
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(post['content'], style: const TextStyle(fontSize: 15)),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.thumb_up_outlined, size: 20, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text('${post['likes']} Likes'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.mode_comment_outlined, size: 20, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text('${post['comments']} Comments'),
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

// Sub-step 2.3: Create Post Screen
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
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
              onPressed: () {
                if (_postController.text.trim().isNotEmpty) {
                  Navigator.pop(context);
                }
              },
              child: const Text('Post', style: TextStyle(fontWeight: FontWeight.bold)),
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
