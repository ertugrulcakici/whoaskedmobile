import 'package:flutter/material.dart';
import 'package:whoaskedmobile/product/model/user_model.dart';

@immutable
class ChatBoxModel {
  final String queueId;
  final String queueName;
  final String latestMessage;
  final String ownerUsername;
  final String seen;
  final List<UserModel> users;

  const ChatBoxModel({
    required this.queueId,
    required this.queueName,
    required this.latestMessage,
    required this.ownerUsername,
    required this.seen,
    required this.users,
  });

  factory ChatBoxModel.fromJson(Map<String, dynamic> json) {
    return ChatBoxModel(
      queueId: json['queueId'] as String,
      queueName: json['queueName'] as String,
      latestMessage: json['latestMessage'] as String,
      ownerUsername: json['ownerUsername'] as String,
      seen: json['seen'] as String,
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
