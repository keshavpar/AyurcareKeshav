import 'package:AyurCar/controller/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HomeView extends GetView<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.yellowAccent),          
        ),
      ),
    );
  }
}
