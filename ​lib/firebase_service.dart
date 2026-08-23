// lib/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Stream<QuerySnapshot> getPostsStream() {
    return _postsCollection.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addNewPost({required String author, required String content}) async {
    await _postsCollection.add({
      'author': author,
      'content': content,
      'likes': 0,
      'comments': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> likePost(String docId, int currentLikes) async {
    await _postsCollection.doc(docId).update({
      'likes': currentLikes + 1,
    });
  }
}
