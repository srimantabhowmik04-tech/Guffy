class UserModel {
  final String uid;
  final String email;
  final String username;
  final String profilePic;
  final String bio;
  final List<String> followers;
  final List<String> following;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.profilePic,
    required this.bio,
    required this.followers,
    required this.following,
  });

  // Firestore-এ ডাটা পাঠানোর জন্য Map তৈরি
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'profilePic': profilePic,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  // Firestore থেকে ডাটা অ্যাপে কনভার্ট করার জন্য
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      profilePic: map['profilePic'] ?? '',
      bio: map['bio'] ?? '',
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
    );
  }
}
