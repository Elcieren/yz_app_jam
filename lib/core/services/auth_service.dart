import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;

  Future<String?> GirisYap(String email, String sifre) async {
    String? res;
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: sifre);
      res = "basarili";
    } on FirebaseAuthException catch (eror) {}
    return res;
  }

  Future signOutAccount() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> Register(
    String email,
    String password,
  ) async {
    String? res;
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      res = "basarili";
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<String?> forgotPassword(String email) async {
    String? res;
    try {
      final result = await firebaseAuth.sendPasswordResetEmail(email: email);
      res = "success";
      print("Email Kontrol Ediniz");
    } catch (e) {
      print("email unuttum kısmında hata var");
    }
    return res;
  }
}
