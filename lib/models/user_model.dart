class UserModel {
  final String uid;
  final String fullName;
  final String username;
  final String email;
  final String? profilePicUrl;
  final String? bio;
  final List<String> followers;
  final List<String> following;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.username,
    required this.email,
    this.profilePicUrl,
    this.bio,
    this.followers = const [],
    this.following = const [],
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'username': username,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'bio': bio,
      'followers': followers,
      'following': following,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      profilePicUrl: map['profilePicUrl'],
      bio: map['bio'],
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
