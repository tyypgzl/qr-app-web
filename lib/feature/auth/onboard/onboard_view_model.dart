import 'package:web_app/core/base/base_view_model.dart';
import 'package:web_app/core/navigation/navigation_service.dart';

class OnboardViewModel extends BaseViewModel {
  @override
  Future<bool> customBack() {
    navigationService.pop();
    return Future.value(true);
  }

  @override
  Future<void> init() async {
    await Future.delayed(const Duration(milliseconds: 1));
  }

  @override
  NavigationService get navigationService => NavigationService.instance;
}
