import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yz_app_jam/common/widgets/creat_bottom_nav_item.dart';
import 'package:yz_app_jam/core/services/auth_service.dart';
import 'package:yz_app_jam/ui/main/main_view_model.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () => MainViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) => Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: Color(0xff20AE67),
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: [
                createNavItem(TabItem.Plant),
                createNavItem(TabItem.Help),
                createNavItem(TabItem.Post),
                createNavItem(TabItem.YapayZeka),
                createNavItem(TabItem.EarthquakeCall),
                createNavItem(TabItem.Profil),
              ],
              onTap: (value) {
                viewModel.setTabIndex(value);
              },
              currentIndex: viewModel.currentTabIndex,
            ),
            body: getViewForIndex(viewModel.currentTabIndex)));
  }
}
