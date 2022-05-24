import 'package:AyurCar/screens/homeview.dart';
import 'package:AyurCar/screens/login_page.dart';
import 'package:AyurCar/services/home.dart';
import 'package:get/get.dart';
import  'package:AyurCar/services/bindings/homebindings.dart';
import 'package:AyurCar/services/bindings/inventorybinding.dart';
import 'package:AyurCar/services/bindings/inventorybinding.dart';
import 'package:AyurCar/services/bindings/loginbindings.dart';

part 'app_routes.dart';

class AppPages{
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name:_Paths.LOGIN,
      page: ()=> LoginPage(), 
      binding: LoginBinding(),

    ),
    GetPage(
      name:_Paths.HOME,
      page: ()=>HomeView(),
      binding: HomeBinding(),    
      
    ),
    GetPage(
      name: _Paths.WELCOME,page: () => Home(),
    )
    
  ];
}
