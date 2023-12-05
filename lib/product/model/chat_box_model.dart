import 'package:flutter/material.dart';
import 'package:whoaskedmobile/product/model/user_model.dart';

@immutable
class ChatBoxModel {
  final int queueId;
  final String queueName;
  final String latestMessage;
  final String ownerUsername;
  final bool seen;
  final List<UserModel> users;

  const ChatBoxModel({
    required this.queueId,
    required this.queueName,
    required this.latestMessage,
    required this.ownerUsername,
    required this.seen,
    required this.users,
  });

  ChatBoxModel.test()
      : queueId = 1,
        queueName = "Group 1",
        latestMessage = "Test",
        ownerUsername = "Test",
        seen = false,
        users = List.generate(10, (index) => UserModel.test());

  factory ChatBoxModel.fromJson(Map<String, dynamic> json) {
    return ChatBoxModel(
      queueId: json['queueId'] as int,
      queueName: json['queueName'] as String,
      latestMessage: json['latestMessage'] as String,
      ownerUsername: json['ownerUsername'] as String,
      seen: json['seen'] as bool,
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  UserModel get owner =>
      users.firstWhere((element) => element.userName == ownerUsername);
  UserModel user(int userId) =>
      users.firstWhere((element) => element.userId == userId);
}
