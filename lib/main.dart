import 'package:advance_cyber_security/view/auth/authuntication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GRecaptchaV3.ready('6LeiibMgAAAAAMfUwJLHpzaQ6EPAghJ6HhMi3-tZ');
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAOdXU9T1nLBu4-s3V1wonIiFjhOCjK7Xk",
      appId: "1:585443078251:web:a30ee1cd4e6ca77fd9012e",
      messagingSenderId: "585443078251",
      projectId: "system-b0adb",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secure App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      builder: EasyLoading.init(),
      home: Authunticate(),
    );
  }
}
