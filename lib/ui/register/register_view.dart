import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yz_app_jam/core/services/auth_service.dart';
import 'package:yz_app_jam/ui/login/login_view.dart';
import 'package:yz_app_jam/ui/register/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late String email;
  late String sifre;
  final formKey = GlobalKey<FormState>();
  final authService = AuthService();
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => RegisterViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) => Scaffold(
              backgroundColor: const Color(0xfff5f5f5),
              body: SingleChildScrollView(
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * .25,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/background1.png"))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hemen Sende \nAramıza\nKatıl",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                  width: 400,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.withOpacity(0.2)),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: emailTextField()),
                              const SizedBox(
                                height: 20,
                              ),
                              //AdSoyadTextField(),

                              // userNameTextField(),

                              Container(
                                  width: 400,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.withOpacity(0.2)),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: sifreTextField()),
                              const SizedBox(
                                height: 20,
                              ),
                              HesapOlusturButton(),
                              const SizedBox(
                                height: 5,
                              ),
                              GirisSayfasinaGeriDonButton()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Center HesapOlusturButton() {
    return Center(
      child: TextButton(
        onPressed: sign_up,
        child: const Text(
          "Hesap Oluştur",
          style: TextStyle(color: Color(0xff20AE67)),
        ),
      ),
    );
  }

  void sign_up() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        final result = await authService.Register(email, sifre);
        if (result == "basarili") {
          formKey.currentState!.reset();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("Hesap Oluşturuldu Giriş Sayafaya yönlendiriliyorsunuz"),
            ),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        }
      } catch (e) {
        print(e.toString());
      }
    } else {}
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri eksik girdiniz";
        } else {}
        return null;
      },
      onSaved: (value) {
        email = value!;
      },
      decoration: customInputDecaration("e-mail"),
    );
  }

  TextFormField sifreTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri eksik girdiniz";
        } else {}
        return null;
      },
      onSaved: (value) {
        sifre = value!;
      },
      obscureText: true,
      decoration: customInputDecaration("Sifre"),
    );
  }

  InputDecoration customInputDecaration(String hinText) {
    return InputDecoration(
      hintText: hinText,
      hintStyle: const TextStyle(color: Colors.grey),
      border: InputBorder.none,
    );
  }

  Center GirisSayfasinaGeriDonButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        },
        child: const Text(
          "Giriş Sayfasına Geri Dön",
          style: TextStyle(color: Color(0xff20AE67)),
        ),
      ),
    );
  }
}
