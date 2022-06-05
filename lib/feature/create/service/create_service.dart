import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:web_app/feature/shared/utils/api_const.dart';

class CreateService {
  Future<void> createNotification(Object? body) async {
    try {
      await Dio().post(
        ApiConstants.instance.oneSignalUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Basic MmNmNGQ0YmEtZDBlMy00N2I0LWIzOGQtMjdjYWM1ZGRjNmIy",
          },
        ),
        data: body,
      );
    } on DioError catch (e) {
      log(e.message);
      throw Exception();
    }
  }
}

/* headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            "Basic MmNmNGQ0YmEtZDBlMy00N2I0LWIzOGQtMjdjYWM1ZGRjNmIy",
      }, */