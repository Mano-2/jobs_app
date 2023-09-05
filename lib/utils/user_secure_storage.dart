import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  final String _keyEmail = 'email';
  final String _keyUsername = 'username';

  final String _keyToken = 'Token';

  Future setEmail(String email) async {
    await storage.write(key: _keyEmail, value: email);
  }

  Future<String?> getEmail() async {
    return await storage.read(key: _keyEmail);
  }

  Future setUsername(String username) async {
    await storage.write(key: _keyUsername, value: username);
  }

  Future<String?> getUserName() async {
    return await storage.read(key: _keyUsername);
  }

  Future setToken(String token) async {
    await storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _keyToken);
  }

  Future deleteAll() async {
    await storage.deleteAll();
  }
}
