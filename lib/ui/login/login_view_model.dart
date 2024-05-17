import 'package:firebase_auth/firebase_auth.dart';
import 'package:yz_app_jam/app/app.router.dart';
import 'package:yz_app_jam/app/app_base_view_model.dart';

class LoginViewModel extends AppBaseViewModel {
  init() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (FirebaseAuth.instance.currentUser != null) {
        navigationService.navigateTo(Routes.mainView);
      }
    });
  }
}
