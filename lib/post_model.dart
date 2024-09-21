class PostMetaData {
  final String id;
  final String title;
  final String imageUrl;
  final int likeCount;
  final int commentCount;

  PostMetaData({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.likeCount,
    required this.commentCount,
  });

  factory PostMetaData.fromMap(Map<String, dynamic> data, String documentId) {
    return PostMetaData(
      id: documentId,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      likeCount: data['likeCount'] ?? 0,
      commentCount: data['commentCount'] ?? 0,
    );
  }
}
