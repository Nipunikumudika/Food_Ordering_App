import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Controllers/shopController.dart';
import 'package:food_ordering_app/Controllers/userController.dart';
import 'package:food_ordering_app/Screens/insertShopDetailScreen.dart';
import 'package:food_ordering_app/Screens/logInScreen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  // );

  await Firebase.initializeApp().whenComplete(() {
    debugPrint("fb connection is completed");
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //initialBinding: AppBinding(),
      home: const LogInSCreen(), //Screen widget
    );
  }
}
