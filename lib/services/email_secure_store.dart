import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Used to store and retrieve the user email address
class EmailSecureStore {
  EmailSecureStore({required this.flutterSecureStorage});
  final FlutterSecureStorage flutterSecureStorage;

  static const String storageUserEmailAddressKey = 'userEmailAddress';

  // email
  Future<void> setEmail(String email) async {
    await flutterSecureStorage.write(
        key: storageUserEmailAddressKey, value: email);
  }

  Future<void> clearEmail() async {
    await flutterSecureStorage.delete(key: storageUserEmailAddressKey);
  }

  Future<String?> getEmail() async {
    return await flutterSecureStorage.read(key: storageUserEmailAddressKey);
  }
}
