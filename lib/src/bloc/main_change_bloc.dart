import 'package:rxdart/rxdart.dart';

class MainChangeBloc{
  final _fetchIndex = PublishSubject<int>();
  Stream<int> get getIndexMain => _fetchIndex.stream;

  mainChangeIndex(int index){
    print(index);
    _fetchIndex.sink.add(index);
   }
}
final mainChangeBloc = MainChangeBloc();