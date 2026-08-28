import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../services/firestore_service.dart';
import '../../widgets/banner_ad_widget.dart';
import '../../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'guffy.',
          style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0D47A1), fontSize: 26),
        ),
      ),
      body: Column(
        children: [
          const BannerAdWidget(),
          Expanded(
            child: StreamBuilder<List<PostModel>>(
              stream: firestoreService.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final posts = snapshot.data ?? [];

                if (posts.isEmpty) {
                  return const Center(
                    child: Text('No posts yet! Be the first to share.', style: TextStyle(color: Colors.grey, fontSize: 15)),
                  );
                }

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) => PostCard(post: posts[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
