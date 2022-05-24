
import 'package:AyurCar/controller/auth.dart';
import 'package:AyurCar/services/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginController extends GetxController{
  final GlobalKey<FormState>loginformKey= GlobalKey<FormState>();
  var email = '';
  var password = '';
  late TextEditingController emailController,passwordController;

  AuthenticationController authenticationController = Get.find<AuthenticationController>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final google_Sign = GoogleSignIn();
   @override
  void onInit() async {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController(); 
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

  }

  Future <String?> login() async {
    
    GoogleSignInAccount? googleSignInAccount =
        await authenticationController.googleSignIn.signIn();
    if (googleSignInAccount == null) {

    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await authenticationController.firebaseAuth.signInWithCredential(oAuthCredential);
      Get.to(Home());
    }
    return 'Signed in';
 
  }

  String? validateEmail (String value){
    if(!GetUtils.isEmail(value)){
      return "Provide valid Email";
    }
    return null;

  }
   String? validatePass (String value){
    if(value.length <=6){
      return "Password must be of 6 Character";
    }
    return null;

  }
  
  void checklogin(){
     final isValid = loginformKey.currentState!.validate();
     if(!isValid){
       return ;
     }
     loginformKey.currentState!.save();
   

  }

    Future<String?> signup(
      {required String email, required String password}) async {
    try {

      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      
      
      return 'signed up';
    } on FirebaseAuthException catch (e) {
    
      return e.message;
    }
  }
    Future<String?> signin(
      {required String email, required String password}) async {
    try {   
      
      await authenticationController.firebaseAuth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString()).printError.printInfo;
    // getdata();
    // printdata();
      return 'Signed in';
    }
    catch(e){
      
    }
    // } on FirebaseAuthException catch (e) {
     
    //   if (e.code == 'FIRAuthErrorCodeInvalidEmail') {
    //     print('No user found for that email');
    //     return ('No user found for that email');
    //   } else if (e.code == 'FIRAuthErrorCodeWrongPassword') {
    //     print('Wrong password provided for that user');
    //     return ('wrong password');
    //   } else if (e.code == 'wrong-password') {
    //     print('Invalid Credential');
    //     return ('Invalid Credential');
    //   } else {
    //     print('Error');
    //     return 'Not Signed  in ';
    //   }
    // }
  }

  //   Future<String?> googleSignIN() async {
  //   try {
  
  //     final GoogleSignInAccount googleuser =
  //         await (GoogleSignIn().signIn() as Future<GoogleSignInAccount>);
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleuser.authentication;

  //     final GoogleAuthCredential googleAuthCredential =
  //         GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     ) as GoogleAuthCredential;
  //     final UserCredential googleUsercred = await FirebaseAuth.instance
  //         .signInWithCredential(googleAuthCredential);
  //     googleUsercred.printError();
  //     print(googl  eUsercred.additionalUserInfo);

  //     return 'signed in through google';
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }

  
  void signOut() async {

    google_Sign != null  
        ? await google_Sign.signOut()
        : await (firebaseAuth.signOut());
  }


}