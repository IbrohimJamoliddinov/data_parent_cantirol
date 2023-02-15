import 'dart:async';
import 'package:data_lesson/src/model/database/add_person_model.dart';
import 'package:data_lesson/src/model/database/add_tasks_model.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();

    return _db!;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'tuit.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE addPerson('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'image TEXT, '
      'gender TEXT, '
      'name TEXT)',
    );
    await db.execute(
      'CREATE TABLE tasks('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'titleName TEXT, '
      'createYear INTEGER, '
      'createMonth INTEGER, '
      'createDay INTEGER, '
      'startTime INTEGER, '
      'finishTime INTEGER, '
      'bgColor INTEGER, '
      'userId INTEGER)',
    );
  }

  // parent control___________________________________________________________________

  Future<int> saveAddPerson(AddPersonMadel item) async {
    var dbClient = await db;
    var result = await dbClient.insert(
      "addPerson",
      item.toJson(),
    );
    return result;
  }

  Future<int> addTasks(AddTasksModel item) async {
    var dbClient = await db;
    print(item.toJson());
    var result = await dbClient.insert(
      "tasks",
      item.toJson(),
    );
    return result;
  }

  Future<List<AddPersonMadel>> getPersons() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM addPerson');
    List<AddPersonMadel> data = [];
    for (int i = 0; i < list.length; i++) {
      AddPersonMadel personMadel = AddPersonMadel(
        id: list[i]["id"],
        name: list[i]["name"],
        gender: list[i]["gender"],
        image: list[i]["image"],
      );
      data.add(personMadel);
    }
    return data;
  }

  Future<List<AddTasksModel>> getTasks() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM tasks');
    List<AddTasksModel> data = [];
    for (int i = 0; i < list.length; i++) {
      AddTasksModel tasksModel = AddTasksModel(
        id: list[i]["id"],
        titleName: list[i]['titleName'],
        createYear: list[i]['createYear'],
        createMonth: list[i]['createMonth'],
        createDay: list[i]['createDay'],
        bgColor: list[i]['bgColor'],
        startTime: list[i]['startTime'],
        finishTime: list[i]['finishTime'],
        userId: list[i]['userId'],
      );
      data.add(tasksModel);
    }
    return data;
  }

  Future<List<AddTasksModel>> getSort(
    int userId,
    DateTime dateTime,
  ) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM tasks WHERE userId=$userId and createDay=${dateTime.day} and createYear = ${dateTime.year} and createMonth = ${dateTime.month}');
    List<AddTasksModel> data = [];
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        AddTasksModel tasksModel = AddTasksModel(
          id: list[i]["id"],
          titleName: list[i]['titleName'],
          createYear: list[i]['createYear'],
          createMonth: list[i]['createMonth'],
          createDay: list[i]['createDay'],
          bgColor: list[i]['bgColor'],
          startTime: list[i]['startTime'],
          finishTime: list[i]['finishTime'],
          userId: list[i]['userId'],
        );
        data.add(tasksModel);
      }
    }
    return data;
  }

  Future<AddPersonMadel?> getPersonTask(int userId) async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery("SELECT * FROM addPerson WHERE id=$userId");
    if (list.isNotEmpty) {
      var user = list.first;
      return AddPersonMadel(
        id: user["id"],
        name: user["name"],
        gender: user["gender"],
        image: user["image"],
      );
    }
    return null;
  }
}
