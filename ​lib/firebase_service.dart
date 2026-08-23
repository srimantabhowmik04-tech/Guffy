// lib/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  // নতুন পোস্ট ডেটাবেসে পাঠানো (Create Post)
  Future<void> addNewPost({
    required String author,
    required String content,
  }) async {
    await _postsCollection.add({
      'author': author,
      'content': content,
      'likes': 0,
      'comments': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // ফায়ারস্টোর থেকে রিয়েল-টাইম পোস্টের স্ট্রিম পাওয়া (Fetch Posts)
  Stream<QuerySnapshot> getPostsStream() {
    return _postsCollection
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // পোস্টে লাইক আপডেট করা (Like Logic)
  Future<void> likePost(String postId, int currentLikes) async {
    await _postsCollection.doc(postId).update({
      'likes': currentLikes + 1,
    });
  }
}
