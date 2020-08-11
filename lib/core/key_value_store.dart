abstract class KeyValueStore {
  Future<bool> setString(String key, String value);

  Future<bool> setBool(String key, bool value);

  Future<bool> setInt(String key, int value);

  Future<bool> getBool(String key, {bool def});

  Future<String> getString(String key, {String def});

  Future<int> getInt(String key, {int def});
}

abstract class EncryptedKeyValueStore implements KeyValueStore {}

abstract class DatabaseKvStore implements KeyValueStore {}

abstract class PreferencesKvStore implements KeyValueStore {}
