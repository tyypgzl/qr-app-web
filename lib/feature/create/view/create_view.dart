import 'package:flutter/material.dart';
import 'package:web_app/core/base/base_view.dart';
import 'package:web_app/feature/create/view_model/create_view_model.dart';
import 'package:web_app/feature/shared/utils/app_colors.dart';
import 'package:web_app/feature/shared/widgets/auth_text_field.dart';
import 'package:web_app/feature/shared/widgets/custom_button.dart';

import '../model/created_lesson.dart';

class CreateView extends BaseView<CreateViewModel> {
  final Lesson lesson;
  CreateView({required this.lesson, Key? key}) : super(key: key);

  @override
  CreateViewModel get viewModel => CreateViewModel(lesson: lesson);

  @override
  Color? get backgroundColor => AppColors.instance.white;

  @override
  PreferredSizeWidget? appBar(CreateViewModel viewModel) => AppBar(
        iconTheme: IconThemeData(
          color: AppColors.instance.black,
        ),
        title: Text(
          'Qr Yoklama Paneli',
          style: TextStyle(
            color: AppColors.instance.black,
          ),
        ),
        backgroundColor: AppColors.instance.orangeAccent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: kToolbarHeight + 10,
      );

  @override
  Widget? body(BuildContext context, CreateViewModel viewModel) {
    return Center(
      child: SizedBox(
        width: screenSize.width * .4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthTextField(
              onChanged: viewModel.onChangeLesson,
              labelText: 'Ders Adı',
              keyboardType: TextInputType.name,
              size: Size(screenSize.width * .97, screenSize.height * .12),
            ),
            CustomButton(
                onTap: () => viewModel.startButtonOnTap(context),
                title: 'Yoklama Başlat',
                backgroundColor: AppColors.instance.pink,
                foregroundColor: AppColors.instance.black),
          ],
        ),
      ),
    );
  }
}
