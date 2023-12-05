import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whoaskedmobile/core/services/auth_service.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String> _formData = {
    'username': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _form(),
    );
  }

  Widget _form() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _usernameField(),
              _passwordField(),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      autofocus: true,
      decoration: const InputDecoration(
        labelText: 'Username',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
      onSaved: (newValue) {
        _formData['username'] = newValue ?? '';
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      onSaved: (newValue) {
        _formData['password'] = newValue ?? '';
      },
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: _login,
      child: const Text('Login'),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Please fill in the form correctly'),
      //   ),
      // );
      return;
    }
    _formKey.currentState!.save();

    final String username = _formData['username']!;
    final String password = _formData['password']!;

    AuthService.instance.login(username, password).then((value) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceAll("Exception: ", "")),
        ),
      );
    });

    _formKey.currentState!.save();
  }
}
