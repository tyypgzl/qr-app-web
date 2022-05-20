import 'package:flutter/material.dart';
import 'package:web_app/feature/auth/register/model/user.dart';
import 'package:web_app/feature/home/model/student.dart';
import 'package:web_app/feature/shared/utils/app_colors.dart';

class UserListTile extends StatelessWidget {
  final UserModel user;

  const UserListTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const StadiumBorder(),
      shadowColor: AppColors.instance.black,
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.instance.orangeAccent,
          child: Text(
            '${user.name.characters.first}${user.surname.characters.first}',
            style: TextStyle(color: AppColors.instance.black),
          ),
        ),
        title: Text(user.name + ' ' + user.surname),
        subtitle: Text(user.email),
      ),
    );
  }
}

class StudentListTile extends StatelessWidget {
  final Student student;

  const StudentListTile({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const StadiumBorder(),
      shadowColor: AppColors.instance.black,
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.instance.orangeAccent,
          child: Text(
            '${student.name?.characters.first}${student.surname?.characters.first}',
            style: TextStyle(color: AppColors.instance.black),
          ),
        ),
        title: Text((student.name ?? '') + ' ' + (student.surname ?? '')),
        subtitle: Text(student.email ?? ''),
      ),
    );
  }
}
