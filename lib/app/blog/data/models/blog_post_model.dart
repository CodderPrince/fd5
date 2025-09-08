// lib/app/blog/data/models/blog_post_model.dart
class BlogPost {
  final int id;
  final String title;
  final String shortDescription;
  final String content;
  final String imageUrl;
  final int categoryId;
  final String authorName;
  final String authorAvatarUrl;
  final DateTime createdAt;
  final String articleUrl; // --- NEW FIELD: Actual article URL ---

  BlogPost({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.content,
    required this.imageUrl,
    required this.categoryId,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.createdAt,
    required this.articleUrl, // Required for constructor
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] as int,
      title: json['title'] as String,
      shortDescription: json['short_description'] as String,
      content: json['content'] as String,
      imageUrl: json['image_url'] as String,
      categoryId: json['category_id'] as int,
      authorName: json['author_name'] as String,
      authorAvatarUrl: json['author_avatar_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      articleUrl: json['article_url'] as String, // Parse new field
    );
  }

  // Add a toMap method for consistency, useful for sending to API
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'short_description': shortDescription,
      'content': content,
      'image_url': imageUrl,
      'category_id': categoryId,
      'author_name': authorName,
      'author_avatar_url': authorAvatarUrl,
      'created_at': createdAt.toIso8601String(),
      'article_url': articleUrl, // Include new field
    };
  }
}