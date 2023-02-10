import 'package:data_lesson/src/database/database_helper.dart';
import 'package:data_lesson/src/model/database/add_person_model.dart';
import 'package:data_lesson/src/model/database/add_tasks_model.dart';
import 'package:rxdart/subjects.dart';

class TasksBloc {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final _fetchTasksPerson = PublishSubject<AddPersonMadel>();
  final _fetchGetTask = PublishSubject<List<AddTasksModel>>();

  Stream<AddPersonMadel> get getPersonOne => _fetchTasksPerson.stream;

  Stream<List<AddTasksModel>> get getTask => _fetchGetTask.stream;

  Future<AddPersonMadel?> getPersonTask(int id) async {
    return await databaseHelper.getPersonTask(id);
  }

  getPerson(int userId, DateTime dateTime) async {
    List<AddTasksModel> data = await databaseHelper.getSort(userId, dateTime);
    _fetchGetTask.sink.add(data);
    print(data);
  }


}

final tasksBloc = TasksBloc();
