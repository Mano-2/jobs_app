// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:login_rest_api/models/user.dart';
import 'package:login_rest_api/services/http_service.dart';
import 'package:login_rest_api/utils/user_secure_storage.dart';

class AuthService {
  final getIt = GetIt.instance;

  final SecureStorage _secureStorage = SecureStorage();

  HTTPService? _http;

  AuthService() {
    _http = getIt.get<HTTPService>();
  }

  Future<UserModel?> signUp(
      String email, String username, String password) async {
    Response response = await _http!.post('/register',
        data: {'name': username, 'email': email, 'password': password});
    //
    print(response);
    print('Response Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');
    //
    if (response.statusCode == 201) {
      final body = response.data;

      await _secureStorage.setToken(body['token']);
      await _secureStorage.setEmail(email);
      await _secureStorage.setUsername(username);

      return UserModel(email: email, token: body['token'], username: username);
    } else {
      return null;
    }
  }

  Future<UserModel?> getUser() async {
    final email = await _secureStorage.getEmail();
    final username = await _secureStorage.getUserName();
    final token = await _secureStorage.getToken();

    if (token != null && email != null && username != null) {
      final user = UserModel(email: email, token: token, username: username);
      return user;
    } else {
      return null;
    }
  }

  Future<UserModel?> login(
      String email, String username, String password) async {
    Response response = await _http!.post('/login',
        data: {'name': username, 'email': email, 'password': password});
    //
    print(response);
    print('Response Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');
    //

    if (response.statusCode == 201) {
      final body = response.data;
      await _secureStorage.setToken(body['token']);
      await _secureStorage.setEmail(email);
      await _secureStorage.setUsername(username);

      return UserModel(email: email, token: body['token'], username: username);
    } else {
      return null;
    }
  }

  Future<bool> logout() async {
    final email = await _secureStorage.getEmail();
    final username = await _secureStorage.getUserName();
    final token = await _secureStorage.getToken();

    if (email != null && username != null && token != null) {
      await _secureStorage.deleteAll();
      return true;
    } else {
      return false;
    }
  }
}
