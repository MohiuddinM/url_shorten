import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class Sembast {
  Database _database;

  Database get database {
    assert(_database != null);
    return _database;
  }

  Future<Database> initialize({String name = 'default.db'}) async {
    if (_database == null) {
      final dir = Platform.isWindows ? Directory('./data') : await getApplicationDocumentsDirectory();
      return _database = await databaseFactoryIo.openDatabase(path.join(dir.path, name));
    } else {
      return _database;
    }
  }
}
