class DataTest {
  int id;
  String name;
  String parentId;
  static const String TABLE_NAME = 'users';

  DataTest({
    this.id = 0,
    required this.name,
    required this.parentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }
}
