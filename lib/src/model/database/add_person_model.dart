class AddPersonMadel {
  AddPersonMadel({
    this.id = 0,
    required this.gender,
    required this.image,
    required this.name,
  });

  int id;
  String gender;
  String image;
  String  name;

  Map<String, dynamic> toJson() => {
    "gender": gender,
    "image": image,
    "name": name ,
  };
}
