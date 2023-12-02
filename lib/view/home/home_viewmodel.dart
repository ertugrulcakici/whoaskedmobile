import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:whoaskedmobile/core/services/api_service.dart';
import 'package:whoaskedmobile/core/services/auth_service.dart';
import 'package:whoaskedmobile/product/model/chat_box_model.dart';
import 'package:whoaskedmobile/product/model/user_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<ChatBoxModel> chatBoxes = [];
  HomeViewModel();

  Future<void> fetchChatBoxes() async {
    Response<Map<String, dynamic>> response = await ApiService.instance
        .get<Map<String, dynamic>>("/api/Users/ByUsername",
            queryParameters: {"username": AuthService.instance.username});
    if (response.statusCode == 200) {
      UserModel user = UserModel(
        avatar: response.data!["avatar"],
        userId: response.data!["userId"],
        userName: response.data!["userName"],
      );
      List<Map<String, dynamic>> queues = response.data!["queues"];
      // final List<dynamic> chatBoxesJson = response.data!["chatBoxes"];
      // chatBoxes = chatBoxesJson.map((e) => ChatBoxModel.fromJson(e)).toList();
      // notifyListeners();
    } else {
      throw Exception("Failed to fetch chat boxes");
    }
  }
}
