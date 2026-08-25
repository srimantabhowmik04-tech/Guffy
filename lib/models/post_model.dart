class PostModel {
  final String postId;
  final String uid;
  final String username;
  final String userProfilePic;
  final String description;
  final String postUrl;
  final DateTime datePublished;
  final List<String> likes;

  PostModel({
    required this.postId,
    required this.uid,
    required this.username,
    required this.userProfilePic,
    required this.description,
    required this.postUrl,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'uid': uid,
      'username': username,
      'userProfilePic': userProfilePic,
      'description': description,
      'postUrl': postUrl,
      'datePublished': datePublished.toIso8601String(),
      'likes': likes,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId'] ?? '',
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      userProfilePic: map['userProfilePic'] ?? '',
      description: map['description'] ?? '',
      postUrl: map['postUrl'] ?? '',
      datePublished: DateTime.parse(map['datePublished']),
      likes: List<String>.from(map['likes'] ?? []),
    );
  }
}
