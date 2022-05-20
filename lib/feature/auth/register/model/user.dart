class UserModel {
  String name;
  String surname;
  String email;
  String password;
  bool isStudent;
  String uuid;

  UserModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.uuid,
    this.isStudent = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uuid: json['uuid'] ??= json['uuid'],
        name: json['name'] ??= json['name'],
        surname: json['surname'] ??= json['surname'],
        email: json['email'] ??= json['email'],
        password: json['password'] ??= json['password'],
        isStudent: json['isStudent'] ??= json['isStudent'],
      );

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['password'] = password;
    data['isStudent'] = isStudent;
    data['uuid'] = uuid;
    return data;
  }
}
