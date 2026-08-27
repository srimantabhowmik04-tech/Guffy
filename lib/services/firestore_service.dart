// lib/services/firestore_service.dart
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../models/post_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firebase Storage-এ ইমেজ আপলোড
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    String id = const Uuid().v1();
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid).child(id);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    return await snap.ref.getDownloadURL();
  }

  // নতুন পোস্ট আপলোড
  Future<String> uploadPost(String description, Uint8List file, String username, String profImage) async {
    String res = "কিছু একটা সমস্যা হয়েছে";
    try {
      String photoUrl = await uploadImageToStorage('posts', file);
      String postId = const Uuid().v1();

      PostModel post = PostModel(
        postId: postId,
        uid: _auth.currentUser!.uid,
        username: username,
        userProfilePic: profImage,
        description: description,
        postUrl: photoUrl,
        datePublished: DateTime.now(),
        likes: [],
      );

      await _firestore.collection('posts').doc(postId).set(post.toMap());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // পোস্টে লাইক / আনলাইক দেওয়া
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (err) {
      // ignore
    }
  }
}
