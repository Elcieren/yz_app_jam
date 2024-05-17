import 'package:yz_app_jam/app/app.router.dart';
import 'package:yz_app_jam/app/app_base_view_model.dart';

class SplashViewModel extends AppBaseViewModel {
  init() {
    Future.delayed(const Duration(milliseconds: 4000), () {
      navigationService.navigateTo(Routes.loginView);
    });
  }
}
