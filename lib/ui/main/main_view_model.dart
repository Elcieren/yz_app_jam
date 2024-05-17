import 'package:yz_app_jam/app/app_base_view_model.dart';

class MainViewModel extends AppBaseViewModel {
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  init() {}

  void setTabIndex(int value) {
    _currentTabIndex = value;
    notifyListeners();
  }
}
