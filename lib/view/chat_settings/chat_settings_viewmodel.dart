import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whoaskedmobile/core/services/api_service.dart';
import 'package:whoaskedmobile/product/model/chat_box_model.dart';

import '../../product/model/user_model.dart';

class ChatSettingsViewModel extends ChangeNotifier {
  ChatBoxModel chatBoxModel;
  ChatSettingsViewModel(this.chatBoxModel);
  Future<void> addUser(String userName) async {
    ApiService.instance.post("/api/Users/AddToQueue", {
      "userName": userName,
      "queueId": chatBoxModel.queueId,
    }).then((value) {
      if (value.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "User added to queue",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        ApiService.instance
            .get("/api/Users/ByUsername",
                queryParameters: {"username": userName})
            .then((response) => {
                  if (response.statusCode == 200)
                    {
                      chatBoxModel.users.add(UserModel.fromJson(
                          response.data as Map<String, dynamic>)),
                    }
                  else
                    {
                      Fluttertoast.showToast(
                          msg: "User data could not be fetched",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0)
                    }
                })
            .whenComplete(() => notifyListeners());
      } else {
        Fluttertoast.showToast(
            msg: "User could not be added to queue",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> deleteUser(UserModel userModel) async {
    ApiService.instance.post("/api/Users/RemoveFromQueue", {
      "userId": userModel.userId,
      "queueId": chatBoxModel.queueId,
    }).then((value) {
      if (value.statusCode == 200) {
        chatBoxModel.users.remove(userModel);
        Fluttertoast.showToast(
            msg: "User removed from queue",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "User could not be removed from queue",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg: "User could not be removed from queue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }).whenComplete(() {
      notifyListeners();
    });
  }
}
