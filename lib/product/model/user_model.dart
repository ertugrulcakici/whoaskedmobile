final class UserModel {
  final int userId;
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

  UserModel.test()
      : userId = 1,
        userName = "Test",
        avatar = "Test";

  @override
  String toString() =>
      "UserModel(userId: $userId, userName: $userName, avatar: $avatar)";
}
