import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // ডেমো পোস্ট লিস্ট (পরে এটি Supabase থেকে ফেচ হবে)
  final List<Map<String, dynamic>> _posts = [
    {
      'username': 'rahul_dev',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'caption': 'Building Guffy Social App with Flutter & Supabase! 🚀',
      'imageUrl': 'https://picsum.photos/600/400',
      'likes': 24,
      'isLiked': false,
      'timeAgo': '2h ago',
    },
    {
      'username': 'ananya_art',
      'avatar': 'https://i.pravatar.cc/150?img=5',
      'caption': 'Late night coding vibes ✨ #developer #flutter',
      'imageUrl': 'https://picsum.photos/600/401',
      'likes': 58,
      'isLiked': true,
      'timeAgo': '4h ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guffy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, size: 28),
            onPressed: () {
              // Post creation screen-এ যাওয়ার অপশন
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AuthScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info Header
                ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(post['avatar'])),
                  title: Text(post['username'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(post['timeAgo'], style: const TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.more_vert),
                ),
                // Post Image
                ClipRRect(
                  child: Image.network(
                    post['imageUrl'],
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Action Buttons (Like, Comment, Share)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          post['isLiked'] ? Icons.favorite : Icons.favorite_border,
                          color: post['isLiked'] ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            post['isLiked'] = !post['isLiked'];
                            post['likes'] += post['isLiked'] ? 1 : -1;
                          });
                        },
                      ),
                      Text('${post['likes']}'),
                      const SizedBox(width: 16),
                      const Icon(Icons.chat_bubble_outline),
                      const SizedBox(width: 6),
                      const Text('12'),
                      const Spacer(),
                      const Icon(Icons.bookmark_border),
                    ],
                  ),
                ),
                // Caption
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: '${post['username']} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: post['caption']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
