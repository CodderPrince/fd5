// lib/app/features/profile/data/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? 'Unnamed User',  // Provide a default value
      email: json['email'],
      avatarUrl: json['avatar_url'] ?? 'URL to a default avatar image', //Provide a default avatar URL
    );
  }
}