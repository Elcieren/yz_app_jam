import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yz_app_jam/app/yapay_zeka_akademi.dart';
import 'package:yz_app_jam/core/di/get_it.dart';
import 'package:yz_app_jam/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDI();
  runApp(YapayZekaApp());
}
