import 'dart:html';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:web_app/core/base/base_view_model.dart';
import 'package:web_app/core/constants/route_constants.dart';
import 'package:web_app/core/enum/page_state_enum.dart';
import 'package:web_app/core/navigation/navigation_service.dart';
import 'package:web_app/feature/home/model/student.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import '../../create/model/created_lesson.dart';
import 'dart:convert';

class HomeViewModel extends BaseViewModel {
  final Lesson lesson;
  HomeViewModel({required this.lesson});
  final client = GetIt.instance<SupabaseClient>();

  String? qrData;

  List<Student> studentList = [];

  late RealtimeSubscription subscription;

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
    subscription.unsubscribe();
  }

  void createExcelFile() {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('Ad');
    sheet.getRangeByName('B1').setText('Soyad');
    sheet.getRangeByName('C1').setText('E-Posta');
    for (var i = 0; i < studentList.length; i++) {
      sheet.getRangeByName('A${i + 2}').setText(studentList[i].name);
      sheet.getRangeByName('A${i + 2}').autoFit();
      sheet.getRangeByName('B${i + 2}').setText(studentList[i].surname);
      sheet.getRangeByName('B${i + 2}').autoFit();
      sheet.getRangeByName('C${i + 2}').setText(studentList[i].email);
      sheet.getRangeByName('C${i + 2}').autoFit();
    }
    final List<int> bytes = workbook.saveAsStream();
    final date = DateTime.now();

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download",
          "${date.year}_${date.month}_${date.day}_${lesson.name}.xlsx")
      ..click();

    workbook.dispose();
  }

  @override
  Future<void> init() async {
    qrData = const Uuid().v1();
    subscription =
        client.from('student').on(SupabaseEventTypes.insert, (payload) {
      var student = Student.fromJson(payload.newRecord ?? {});
      if (student.email != null &&
          student.lesson != null &&
          student.uuid == qrData) {
        studentList.insert(0, student);
        notifyListeners();
      }
    }).subscribe();
  }

  @override
  NavigationService get navigationService => NavigationService.instance;
}
