import 'package:shared_preferences/shared_preferences.dart';
import 'package:whoaskedmobile/core/services/api_service.dart';
import 'package:whoaskedmobile/product/errors/auth_errors.dart';
import 'package:whoaskedmobile/product/model/user_model.dart';

// abstract class IAuthService {
//   late SharedPreferences _preferences;

//   String? _currentToken;
//   String? get currentToken => _currentToken;

//   String? get tokenFromLocaleStorage;
//   Future<void> _saveTokenToLocaleStorage(String token);

//   Future<void> login(String email, String password);
//   Future<void> logout();

//   Future<String> _fetchToken();
// }

final class AuthService {
  String? _currentToken;
  String? get currentToken => _currentToken ?? tokenFromLocaleStorage;
  String? get tokenFromLocaleStorage => _preferences.getString("token");

  String? _username;
  String? get username => _username ?? _preferences.getString("username");
  String? _password;

  late SharedPreferences _preferences;

  AuthService._();
  static late final AuthService _instance;
  static AuthService get instance => _instance;
  // factory AuthService() => _instance;

  static Future<void> init() async {
    _instance = AuthService._();
    _instance._preferences = await SharedPreferences.getInstance();
    if (_instance.currentToken != null) {
      ApiService.instance.setBearerToken(_instance.currentToken ?? "");
    }
  }

  Future<void> _saveUserToLocalStorage(
      {required String token, required String username}) async {
    await _preferences.setString("token", token);
    await _preferences.setString("username", username);
  }

  UserModel? user;

  Future<void> fetchUserData() async {
    if (username == null || currentToken == null) {
      throw NotLoggedInError();
    }
    final response = await ApiService.instance.get<Map<String, dynamic>>(
        "/api/Users/ByUsername",
        queryParameters: {"username": username});

    if (response.statusCode == 200) {
      user = UserModel(
        avatar: response.data!["avatar"],
        userName: response.data!["userName"],
        userId: response.data!["userId"],
      );
    } else if (response.statusCode == 401) {
      throw NotLoggedInError();
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<void> login(String username, String password) async {
    _username = username;
    _password = password;
    final response =
        await ApiService.instance.post<String>("/api/Users/Login", {
      "username": username,
      "password": password,
    });
    if (response.statusCode == 200) {
      await _saveUserToLocalStorage(token: response.data!, username: username);
      _currentToken = response.data;
      ApiService.instance.setBearerToken(response.data!);
    } else if (response.statusCode == 400) {
      throw Exception(response.data);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<void> logout() async {
    await _preferences.remove("token");
    _currentToken = null;
  }
}
