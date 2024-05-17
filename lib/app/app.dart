import 'package:stacked/stacked_annotations.dart';
import 'package:yz_app_jam/ui/login/login_view.dart';
import 'package:yz_app_jam/ui/main/main_view.dart';
import 'package:yz_app_jam/ui/sifre/forgot_password_view.dart';

import 'package:yz_app_jam/ui/splash/splash_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: MainView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: ForgotPasswordView),
  ],
)
class App {}
