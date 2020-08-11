import 'package:sembast/sembast.dart';

import 'key_value_store.dart';


class SembastKvStore implements DatabaseKvStore {
  final Database _db;
  final StoreRef<String, Object> _store;

  SembastKvStore(Database database, {String storeName = 'default_kv_store'})
      : _db = database,
        _store = StoreRef<String, Object>(storeName);

  @override
  Future<bool> getBool(String key, {bool def}) async {
    return (await _store.record(key).get(_db)) ?? def;
  }

  @override
  Future<int> getInt(String key, {int def}) async {
    return (await _store.record(key).get(_db)) ?? def;
  }

  @override
  Future<String> getString(String key, {String def}) async {
    return (await _store.record(key).get(_db)) ?? def;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    return await _store.record(key).put(_db, value) != null;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    return await _store.record(key).put(_db, value) != null;
  }

  @override
  Future<bool> setString(String key, String value) async {
    return await _store.record(key).put(_db, value) != null;
  }
}
