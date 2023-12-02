final class UserModel {
  final String userId;
  final String userName;
  final String avatar;

  UserModel({
    required this.userId,
    required this.userName,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      userName: json['userName'],
      avatar: json['avatar'],
    );
  }
}
