class PostModel {
  final String postId;
  final String authorUid;
  final String authorName;
  final String authorUsername;
  final String? authorProfilePic;
  final String content;
  final String? postImageUrl;
  final List<String> likes;
  final int commentsCount;
  final DateTime createdAt;

  PostModel({
    required this.postId,
    required this.authorUid,
    required this.authorName,
    required this.authorUsername,
    this.authorProfilePic,
    required this.content,
    this.postImageUrl,
    this.likes = const [],
    this.commentsCount = 0,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'authorUid': authorUid,
      'authorName': authorName,
      'authorUsername': authorUsername,
      'authorProfilePic': authorProfilePic,
      'content': content,
      'postImageUrl': postImageUrl,
      'likes': likes,
      'commentsCount': commentsCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PostModel.fromMap(String id, Map<String, dynamic> map) {
    return PostModel(
      postId: id,
      authorUid: map['authorUid'] ?? '',
      authorName: map['authorName'] ?? 'Anonymous',
      authorUsername: map['authorUsername'] ?? '@user',
      authorProfilePic: map['authorProfilePic'],
      content: map['content'] ?? '',
      postImageUrl: map['postImageUrl'],
      likes: List<String>.from(map['likes'] ?? []),
      commentsCount: map['commentsCount'] ?? 0,
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
