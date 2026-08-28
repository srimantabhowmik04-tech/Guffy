import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<PostModel>> getPostsStream() {
    return _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return PostModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> createPost({
    required String authorUid,
    required String authorName,
    required String authorUsername,
    required String content,
    String? postImageUrl,
  }) async {
    final docRef = _firestore.collection('posts').doc();
    final post = PostModel(
      postId: docRef.id,
      authorUid: authorUid,
      authorName: authorName,
      authorUsername: authorUsername,
      content: content,
      postImageUrl: postImageUrl,
      createdAt: DateTime.now(),
    );
    await docRef.set(post.toMap());
  }

  Future<void> toggleLike(String postId, String uid, List<String> currentLikes) async {
    if (currentLikes.contains(uid)) {
      await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await _firestore.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }
}
