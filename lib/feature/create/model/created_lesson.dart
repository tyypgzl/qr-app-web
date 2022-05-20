class Lesson {
  String name;
  String teacherName;
  String teacherSurname;

  Lesson(
      {required this.name,
      required this.teacherName,
      required this.teacherSurname});

  Lesson fromJson(Map<String, dynamic> json) => Lesson(
        name: json['name'] ??= json['name'],
        teacherName: json['teacherName'] ??= json['teacherName'],
        teacherSurname: json['teacherSurname'] ??= json['teacherSurname'],
      );

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['name'] = name;
    data['teacherName'] = teacherName;
    data['teacherSurname'] = teacherSurname;

    return data;
  }
}
