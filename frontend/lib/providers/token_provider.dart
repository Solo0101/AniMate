import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageNotifier extends StateNotifier<FlutterSecureStorage> {
  SecureStorageNotifier() : super(const FlutterSecureStorage());

  Future<String> getApplicationToken() async {
    return await state.read(key: 'application_token') as String;
  }

  Future<void> upsertApplicationToken(String appToken) async {
    await state.write(key: 'application_token', value: appToken);
  }

  Future<void> deleteApplicationToken() async {
    await state.delete(key: 'application_token');
  }
}

final StateNotifierProvider<SecureStorageNotifier, FlutterSecureStorage>
secureStorageProvider =
StateNotifierProvider((_) => SecureStorageNotifier());

