import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:whoaskedmobile/core/services/api_service.dart';
import 'package:whoaskedmobile/core/services/auth_service.dart';
import 'package:whoaskedmobile/product/model/chat_box_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<ChatBoxModel> chatBoxes = [];
  HomeViewModel() {
    if (_timer == null) {
      fetchChatBoxes();
    }
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchChatBoxes();
    });
  }

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchChatBoxes() async {
    chatBoxes.clear();
    Response<Map<String, dynamic>> response = await ApiService.instance
        .get<Map<String, dynamic>>("/api/Users/ByUsername",
            queryParameters: {"username": AuthService.instance.username});
    if (response.statusCode == 200) {
      // UserModel user = UserModel(
      //   avatar: response.data!["avatar"],
      //   userId: response.data!["userId"],
      //   userName: response.data!["userName"],
      // );
      List<Map<String, dynamic>> newQueues =
          (response.data!["queues"] as List).cast<Map<String, dynamic>>();
      chatBoxes = newQueues.map((e) => ChatBoxModel.fromJson(e)).toList();
      notifyListeners();
      log("Fetched chat boxes");
    } else {
      throw Exception("Failed to fetch chat boxes");
    }
  }
}
