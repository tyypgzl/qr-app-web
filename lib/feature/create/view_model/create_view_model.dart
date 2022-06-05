import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web_app/core/base/base_view_model.dart';
import 'package:web_app/core/constants/route_constants.dart';
import 'package:web_app/core/enum/page_state_enum.dart';
import 'package:web_app/core/navigation/navigation_service.dart';
import 'package:web_app/core/utils/show_snack_bar.dart';
import 'package:web_app/feature/create/model/created_lesson.dart';
import 'package:web_app/feature/create/model/one_signal_notification.dart';
import 'package:web_app/feature/create/service/create_service.dart';
import 'package:web_app/feature/shared/utils/api_const.dart';
import 'package:web_app/feature/shared/utils/app_colors.dart';

class CreateViewModel extends BaseViewModel {
  final Lesson lesson;

  CreateViewModel({required this.lesson});

  CreateService service = CreateService();

  String? lessonName;

  final client = GetIt.instance<SupabaseClient>();

  @override
  Future<bool> customBack() {
    navigationService.pop();
    return Future.value(true);
  }

  String? onChangeLesson(String? value) {
    lessonName = value;
    notifyListeners();
    return value;
  }

  OneSignalNotification get requestNotification => OneSignalNotification(
      appId: ApiConstants.instance.oneSignalAppId,
      contents: Headings(
          en: "$lessonName class attendance has started.",
          tr: "$lessonName dersi yoklaması başlamıştır."),
      headings: Headings(tr: "Yoklama Duyurusu", en: "Attendance Notice"),
      includedSegments: ["Subscribed Users"]);

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 1));
  }

  @override
  NavigationService get navigationService => NavigationService.instance;

  Future<void> startButtonOnTap(BuildContext context) async {
    if (lessonName != null) {
      state = PageState.LOADING;
      lesson.name = lessonName!;
      var response =
          await client.from('createdLesson').insert(lesson.toJson()).execute();

      if (response.status != null) {
        if (response.status! >= 200 && response.status! <= 209) {
          showSnackBar(
              context: context,
              content: Text(
                '$lessonName dersi yoklaması Başlamıştır.',
                style: TextStyle(color: AppColors.instance.black),
              ),
              isError: false);
          await service.createNotification(requestNotification.toJson());
        } else {
          log('Message: ' +
              response.error!.message +
              ' ' +
              'Code: ' +
              (response.error?.code ?? 'Not') +
              ' ' +
              'Hint: ' +
              (response.error?.hint ?? ''));
        }
      }
      state = PageState.LOADED;
      await Future.delayed(const Duration(milliseconds: 250));
      await navigationService.pushNamedAndRemoveUntil(
          routePath: RouteConstants.home, args: lesson);
    } else {
      showSnackBar(
          context: context,
          content: const Text('Lütfen ders adı giriniz.'),
          isError: true);
    }
  }
}
