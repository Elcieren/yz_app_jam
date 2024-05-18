import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yz_app_jam/core/services/auth_service.dart';
import 'package:yz_app_jam/ui/post/post_view_model.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late String text;
  final formkeyPost = GlobalKey<FormState>();
  User? _user;
  Map<String, dynamic>? _userData;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
      viewModelBuilder: () => PostViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        body: _userData != null
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.6,
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.6,
                      decoration: const BoxDecoration(
                        color: Color(0xff20AE67),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/naturel.png",
                          scale: 0.8,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.666,
                        decoration: const BoxDecoration(
                          color: Color(0xff20AE67),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.666,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                              key: formkeyPost,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(40),
                                    child: Center(
                                      child: Opacity(
                                        opacity: 0.9,
                                        child: Text(
                                          "Doğanın güzelliklerini diğer doğa tutkunlarıyla paylaşmak için buradasınız! Her anınızı ölümsüzleştirin ve doğanın büyüsünü herkesle paylaşın Bitkiler hakkında öğrendiğiniz ilginç bilgileri ve gözlemlerinizi paylaşarak topluluğa katkıda bulunun.",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade700),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 400,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Colors.grey.withOpacity(0.2)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextTextField()),
                                  ),
                                  PostUpButton(),
                                ],
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  TextFormField TextTextField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return "Mesajını Eksizksiz Doldurunuz";
        }
      },
      onSaved: (value) {
        text = value!;
      },
      style: TextStyle(color: Colors.black),
      decoration:
          customInputDecaration("Yardımcı olabileceğimiz bir şey var mı?"),
    );
  }

  Center PostUpButton() {
    return Center(
      child: TextButton(
        onPressed: Post,
        child: Container(
          height: 50,
          width: 140,
          margin: const EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xff20AE67)),
          child: const Center(
              child: Text(
            "Gönder",
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }

  void Post() async {
    if (formkeyPost.currentState!.validate()) {
      formkeyPost.currentState!.save();
      await authService.createPost(
        text,
        _userData!['fullname'],
        _userData!['Cinsiyet'],
        _userData!['email'],
      );
      formkeyPost.currentState!.reset();
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Bilgilendirme"),
            content: Text("Gönderin başarıyla paylaşıldı"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Tamam"),
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog kutusunu kapatır
                },
              ),
            ],
          );
        },
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Hata"),
            content: Text("Üzgünüz Bir hata ile karşılaştık"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Tamam"),
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog kutusunu kapatır
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('Kullanıcı').doc(_user!.uid).get();
      setState(() {
        _userData = userData.data() as Map<String, dynamic>?; // Dönüşüm işlemi
      });
    }
  }

  InputDecoration customInputDecaration(String hintText) {
    return InputDecoration(hintText: hintText, border: InputBorder.none);
  }
}
