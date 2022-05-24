
import 'package:AyurCar/controller/auth.dart';
import 'package:AyurCar/model/pateint.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
  //  getdata();
    Get.put<AuthenticationController>(AuthenticationController());
  }
  
}

