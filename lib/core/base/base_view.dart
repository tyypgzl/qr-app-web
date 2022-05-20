import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/core/enum/page_state_enum.dart';
import 'package:web_app/core/navigation/navigation_service.dart';
import 'package:web_app/core/widgets/loading_overlay.dart';

import 'base_view_model.dart';

// ignore: must_be_immutable
abstract class BaseView<T extends BaseViewModel> extends StatelessWidget {
  BaseView({Key? key}) : super(key: key);

  T get viewModel;

  ThemeData theme =
      Theme.of(NavigationService.instance.navigatorKey.currentContext!);
  TextTheme textTheme =
      Theme.of(NavigationService.instance.navigatorKey.currentContext!)
          .textTheme;
  Size screenSize =
      MediaQuery.of(NavigationService.instance.navigatorKey.currentContext!)
          .size;

  PreferredSizeWidget? appBar(T viewModel) => null;

  Widget? bodyWithoutScaffold(BuildContext context, T viewModel) => null;
  Widget? body(BuildContext context, T viewModel) => null;
  Widget? bottomNavigationBar(T viewModel) => null;

  Color? get backgroundColor => null;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.value(
        value: viewModel,
        child: Consumer<T>(
          builder: (context, viewModel, child) => SafeArea(
            child: WillPopScope(
              onWillPop: viewModel.customBack,
              child: bodyWithoutScaffold(context, viewModel) ??
                  Scaffold(
                    backgroundColor: backgroundColor,
                    appBar: appBar(viewModel),
                    body: viewModel.initialStateCompleted
                        ? Stack(
                            children: [
                              if (body(context, viewModel) != null)
                                body(context, viewModel)!,
                              if (viewModel.state == PageState.LOADING)
                                const LoadingOverlay()
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                    bottomNavigationBar: bottomNavigationBar(viewModel),
                  ),
            ),
          ),
        ),
      );
}
