import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/services/auth_service.dart';
import '../../product/errors/auth_errors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    AuthService.init().then((value) {
      AuthService.instance.fetchUserData().then((value) {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      }).onError((error, stackTrace) {
        if (error is! NotLoggedInError) {
          Fluttertoast.showToast(msg: error.toString());
        }
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}
