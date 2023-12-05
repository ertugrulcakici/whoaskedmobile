import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:whoaskedmobile/core/services/api_service.dart';
import 'package:whoaskedmobile/core/services/auth_service.dart';

import '../../product/constants/app_constants.dart';
import '../../product/model/chat_box_model.dart';
import '../../product/model/message_model.dart';

class ChatViewModel extends ChangeNotifier {
  Stream<dynamic>? _messageNotifier;
  StreamSubscription<dynamic>? messageSubscription;

  List<MessageModel> messages = [];

  ChatBoxModel chatBoxModel;
  ChatViewModel({required this.chatBoxModel}) {
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(
        "${AppConstants.webSocketUrl}QueueWS?queueId=${chatBoxModel.queueId}"));
    _messageNotifier = channel.stream;
    messageSubscription = _messageNotifier!.listen((event) {
      fetchMessages();
    });
    fetchMessages();
  }

  @override
  void dispose() {
    closeListener().then((value) {
      super.dispose();
    });
  }

  Future<void> closeListener() async {
    messageSubscription?.cancel();
  }

  Future<void> fetchMessages() async {
    // Response<
    //     List<Map<String, dynamic>>> response = await ApiService.instance.get<
    //         List<Map<String, dynamic>>>(
    //     "/api/Messages/${chatBoxModel.queueId}/$amount?userId=${AuthService.instance.user!.userId}");
    Response response = await ApiService.instance.get(
        "/api/Messages/${chatBoxModel.queueId}/1?userId=${AuthService.instance.user!.userId}");
    if (response.statusCode != 200) {
      Fluttertoast.showToast(
          msg: "Error fetching messages",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    messages.clear();
    messages.addAll(response.data
        .map((e) => MessageModel.fromJson(Map<String, dynamic>.from(e)))
        .toList()
        .reversed
        .toList()
        .cast<MessageModel>());

    notifyListeners();
  }

  Future<bool> sendMessage(String message) async {
    Response response = await ApiService.instance.post("/api/Messages", {
      "sender": AuthService.instance.user!.userId,
      "queueId": chatBoxModel.queueId,
      "mess": message,
      "sent": DateTime.now().toUtc().toIso8601String()
    });
    if (response.statusCode != 200) {
      Fluttertoast.showToast(
          msg: "Error sending message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
    return true;
  }
}
