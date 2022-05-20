import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:web_app/core/base/base_view_model.dart';
import 'package:web_app/core/constants/route_constants.dart';
import 'package:web_app/core/enum/page_state_enum.dart';
import 'package:web_app/core/navigation/navigation_service.dart';
import 'package:web_app/feature/home/model/student.dart';

import '../../create/model/created_lesson.dart';

class HomeViewModel extends BaseViewModel {
  final Lesson lesson;
  HomeViewModel({required this.lesson});
  final client = GetIt.instance<SupabaseClient>();

  String? qrData;

  List<Student> studentList = [];

  @override
  Future<bool> customBack() {
    navigationService.pop();
    return Future.value(true);
  }

  Future<void> getStudents() async {
    state = PageState.LOADING;
    var response = await client
        .from('student')
        .select()
        .eq('lesson', lesson.name)
        .eq('uuid', qrData)
        .execute();
    var list = response.data;
    var resposneStudenList =
        (list as List).map((e) => Student.fromJson(e)).toList();
    studentList = resposneStudenList;
    notifyListeners();
    state = PageState.LOADED;
  }

  Future<void> stopLesson() async {
    await navigationService.pushNamedAndRemoveUntil(
        routePath: RouteConstants.create, args: lesson);
  }

  @override
  Future<void> init() async {
    qrData = const Uuid().v1();
    log(qrData!);
  }

  @override
  NavigationService get navigationService => NavigationService.instance;
}
