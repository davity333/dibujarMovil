import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserLocalDataSource {
  final FlutterSecureStorage storage;

  UserLocalDataSource(this.storage);

  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }
}
