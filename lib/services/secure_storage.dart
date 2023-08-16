import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/api_data.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveUserData(LoginData loginData, String token) async {
    await _storage.write(key: 'username', value: loginData.user);
    await _storage.write(key: 'local', value: loginData.local.toString());
    await _storage.write(key: 'token', value: token);
  }

  Future<Map<String, String>> loadUserData() async {
    final username = await _storage.read(key: 'username') ?? '';
    final local = await _storage.read(key: 'local') ?? '';
    final token = await _storage.read(key: 'token') ?? '';

    return {
      'username': username,
      'local': local,
      'token': token,
    };
  }

  Future<void> saveDocumentAccessData(String doc) async {
    await _storage.write(key: 'doc', value: doc);
  }

  Future<Map<String, String>> loadDocumentAccessData() async {
    final doc = await _storage.read(key: 'doc') ?? '';

    return {
      'doc': doc,
    };
  }
}
