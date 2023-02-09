
class UserModel {
  UserModel({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.number,
  });

  int id;
  String firstName;
  String lastName;
  String  number;

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "number": number ,
      };
}
