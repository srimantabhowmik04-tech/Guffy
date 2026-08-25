// lib/services/auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // Sign Up
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
  }) async {
    String res = "কিছু একটা ভুল হয়েছে";
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );

        UserModel user = UserModel(
          uid: cred.user!.uid,
          email: email.trim(),
          username: username.trim(),
          profilePic: '',
          bio: '',
          followers: [],
          following: [],
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toMap());

        res = "success";
      } else {
        res = "দয়া করে সব তথ্য পূরণ করুন";
      }
    } on FirebaseAuthException catch (e) {
      res = e.message ?? e.toString();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "কিছু একটা ভুল হয়েছে";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        res = "success";
      } else {
        res = "দয়া করে সব তথ্য পূরণ করুন";
      }
    } on FirebaseAuthException catch (e) {
      res = e.message ?? e.toString();
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
