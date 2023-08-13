import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveUserData(String username, String local, String token) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'local', value: local);
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
}
