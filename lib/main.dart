// import 'package:Ayurveda_Patients/home.dart';

import 'package:AyurCar/model/pateint.dart';
import 'package:AyurCar/routes/app_pages.dart';
import 'package:AyurCar/services/bindings/homebindings.dart';
import 'package:AyurCar/splashScreen/splash1.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HomeBinding().dependencies();
  // DocRec usersetting = DocRec();
  // usersetting.setdoc=DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());
  runApp((MyApp()));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayurcare',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // theme: ThemeData(
      //   appBarTheme: AppBarTheme(color: Colors.blue[800]),

      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
    );
  }
}
