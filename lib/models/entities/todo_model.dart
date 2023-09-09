class ToDoModel {
  late String email;
  late bool checkBox;
  late String title;

  String? id;
  ToDoModel(
      {required this.email,
      required this.checkBox,
      required this.title,
      this.id});

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
        email: json["email"],
        checkBox: json["checkBox"],
        title: json["title"],
        id: json["id"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "checkBox": checkBox,
      "title": title,
    };
  }
}