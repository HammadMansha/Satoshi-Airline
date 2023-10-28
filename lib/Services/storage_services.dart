import 'package:get_storage/get_storage.dart';

class PasswordStorage {
  final _box = GetStorage();
  final _passwordKey = 'password';

  Future<void> savePassword(String password) async {
    await _box.write(_passwordKey, password);
  }

  Future<String?> getPassword() async {
    return _box.read<String?>(_passwordKey);
  }
  Future<void> setPassword(String password) {
    return _box.write(_passwordKey, password);
  }

  Future<void> clearPassword() async {
    await _box.remove(_passwordKey);
  }


}
