import 'package:data_lesson/src/database/database_helper.dart';
import 'package:data_lesson/src/model/database/add_person_model.dart';
import 'package:rxdart/subjects.dart';

class AddPersonBloc {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final _fetchAddPerson = PublishSubject<List<AddPersonMadel>>();

  Stream<List<AddPersonMadel>> get getChild => _fetchAddPerson.stream;

  getPerson() async {
    List<AddPersonMadel> data = await databaseHelper.getPersons();
    _fetchAddPerson.sink.add(data);
  }


}

final addPersonBloc = AddPersonBloc();
