import 'package:flutter/material.dart';
import 'package:web_app/core/enum/page_state_enum.dart';
import 'package:web_app/core/navigation/navigation_service.dart';

abstract class BaseViewModel extends ChangeNotifier {
  NavigationService get navigationService;
  BaseViewModel() {
    _init();
  }

  PageState _state = PageState.IDLE;

  PageState get state => _state;

  set state(PageState value) {
    _state = value;
    notifyListeners();
  }

  var _initialStateCompleted = false;

  bool get initialStateCompleted => _initialStateCompleted;

  set initialStateCompleted(value) {
    _initialStateCompleted = value;
    notifyListeners();
  }

  Future<void> _init() async {
    state = PageState.LOADING;
    await init();
    state = PageState.LOADED;
    initialStateCompleted = true;
  }

  Future<void> init();
  Future<bool> customBack();
}
