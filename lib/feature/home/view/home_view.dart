import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web_app/core/base/base_view.dart';
import 'package:web_app/feature/create/model/created_lesson.dart';
import 'package:web_app/feature/home/view_model/home_view_model.dart';
import 'package:web_app/feature/shared/utils/app_colors.dart';
import 'package:web_app/feature/shared/widgets/custom_button.dart';
import 'package:web_app/feature/shared/widgets/custom_list_tile.dart';

class HomeView extends BaseView<HomeViewModel> {
  final Lesson lesson;
  HomeView({required this.lesson, Key? key}) : super(key: key);

  @override
  HomeViewModel get viewModel => HomeViewModel(lesson: lesson);

  @override
  Color? get backgroundColor => AppColors.instance.white;

  @override
  PreferredSizeWidget? appBar(HomeViewModel viewModel) => AppBar(
        iconTheme: IconThemeData(
          color: AppColors.instance.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: viewModel.getStudents,
              icon: const Icon(Icons.refresh),
              iconSize: 32,
            ),
          ),
        ],
        title: Text(
          lesson.name,
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
  Widget? body(BuildContext context, HomeViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          flex: 15,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: QrImage(
                data: viewModel.qrData ?? '',
                size: screenSize.height * .9,
              ),
            ),
          ),
        ),
        const Spacer(),
        VerticalDivider(
          endIndent: 30,
          indent: 30,
          thickness: 5,
          color: AppColors.instance.pink,
        ),
        const Spacer(),
        Expanded(
          flex: 15,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  'Yoklamaya Katılan Öğrenciler',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.instance.pink,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.studentList.length,
                    itemBuilder: (context, index) {
                      return StudentListTile(
                        student: viewModel.studentList[index],
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CustomButton(
                  onTap: viewModel.stopLesson,
                  title: 'Yoklamayı Bitir',
                  backgroundColor: AppColors.instance.orangeAccent,
                  foregroundColor: AppColors.instance.black,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
