import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/post_model.dart';
import '../services/firestore_service.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final FirestoreService _firestoreService = FirestoreService();

  PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final currentUid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final isLiked = post.likes.contains(currentUid);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      elevation: 0.8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFE3F2FD),
                  child: Text(
                    post.authorName.isNotEmpty ? post.authorName[0].toUpperCase() : 'G',
                    style: const TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(post.authorUsername, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post.content,
              style: const TextStyle(fontSize: 14.5, height: 1.45, color: Colors.black87),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    if (currentUid.isNotEmpty) {
                      _firestoreService.toggleLike(post.postId, currentUid, post.likes);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 20,
                        color: isLiked ? Colors.red : Colors.blueGrey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${post.likes.length}',
                        style: TextStyle(
                          color: isLiked ? Colors.red : Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.chat_bubble_outline, size: 19, color: Colors.blueGrey),
                    const SizedBox(width: 6),
                    Text('${post.commentsCount}', style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w600)),
                  ],
                ),
                const Icon(Icons.share_outlined, size: 20, color: Colors.blueGrey),
              ],
            )
          ],
        ),
      ),
    );
  }
}
