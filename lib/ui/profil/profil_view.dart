import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yz_app_jam/core/services/auth_service.dart';
import 'package:yz_app_jam/ui/login/login_view.dart';
import 'package:yz_app_jam/ui/profil/profil_view_model.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilViewModel>.reactive(
        viewModelBuilder: () => ProfilViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) => Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: TextButton(
                  onPressed: () {
                    signOutAndNavigateToLogin();
                  },
                  child: Text("Çıkış"),
                ),
              ),
            ));
  }

  void signOutAndNavigateToLogin() async {
    await authService.signOutAccount();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }
}
