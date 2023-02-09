import 'package:data_lesson/src/model/data_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseEx {
  static final DatabaseEx _databaseEx = DatabaseEx.internal();

  factory DatabaseEx() => _databaseEx;
  static Database? _dx;

  DatabaseEx.internal();

  Future<Database> get dx async {
    if (_dx != null) {
      return _dx!;
    }
    _dx = await initDx();

    return _dx!;
  }

  initDx() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreateEx);
    return db;
  }

  void _onCreateEx(Database database, int newVersion) async {
    await database.execute(
      'CREATE TABLE users('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'name TEXT, '
      'parentId INTEGER)',
    );
  }

  Future<int> insertUser(DataTest dataTest) async {
    final db = await dx;
    var res = db.insert("users",dataTest.toJson());
    return res;
  }

  Future<List<DataTest>> getUser()async {
    var dbClient = await dx;
    List<Map> list = await dbClient.rawQuery(
      'SELECT * FROM users');
    List<DataTest> data = [];
    for (int i = 0; i < list.length; i++) {
      DataTest dataTest = DataTest(
        id: list[i]["id"],
        name: list[i]["name"],
        parentId: list[i]["parentId"],
      );
      data.add(dataTest);
    }
    return data;

  }
}
