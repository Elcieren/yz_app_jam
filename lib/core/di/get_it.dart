import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yz_app_jam/app/app_base_view_model.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerLazySingleton(() => AppBaseViewModel());
  getIt.registerLazySingleton(() => NavigationService());
}
