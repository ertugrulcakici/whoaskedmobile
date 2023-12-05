import 'package:flutter/material.dart';

@immutable
final class MessageModel {
  // "sender": 1,
  //       "queueId": 3,
  //       "mess": "f",
  //       "sent": "2023-12-04T21:38:16"

  final int sender;
  final int queueId;
  final String mess;
  final DateTime sent;

  const MessageModel({
    required this.sender,
    required this.queueId,
    required this.mess,
    required this.sent,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      sender: json['sender'] as int,
      queueId: json['queueId'] as int,
      mess: json['mess'] as String,
      sent: DateTime.parse(json['sent'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'queueId': queueId,
      'mess': mess,
      'sent': sent.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'MessageModel(sender: $sender, queueId: $queueId, mess: $mess, sent: $sent)';
  }
}
