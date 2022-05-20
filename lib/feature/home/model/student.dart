class Student {
  String? name;
  String? surname;
  String? email;
  String? uuid;
  String? lesson;

  Student({this.name, this.surname, this.email, this.uuid, this.lesson});

  Student.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    uuid = json['uuid'];
    lesson = json['lesson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['uuid'] = uuid;
    data['lesson'] = lesson;
    return data;
  }
}
