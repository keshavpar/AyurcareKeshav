// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// enum AuthStatus { authenticating, authenticated, unauthenticated, unknown }
// // final databaseprovider =
// //     Provider<AuthenticationService>((ref) => AuthenticationService());
// final google_Sign = GoogleSignIn();

// class AuthenticationService extends ChangeNotifier {
//   AuthStatus authStatus = AuthStatus.unknown;
//   User? authUser;

//   AuthenticationService.instance() {
//     authStatus = AuthStatus.unknown;

//     _firebaseAuth.authStateChanges().listen((User? user) async {
//       if (user == null) {
//         authStatus = AuthStatus.unauthenticated;
//       } else {
//         authUser = user;
//         authStatus = AuthStatus.authenticated;
//       }
//       notifyListeners();
//     });
//   }

//   // final FirebaseAuth _firebaseAuth;

//   // AuthenticationService(this._firebaseAuth);

//   Stream<User?> get authstatechanges => _firebaseAuth.authStateChanges();

//   Future<String> signin(
//       {required String email, required String password}) async {
//     try {
//       authStatus = AuthStatus.authenticating;
//       notifyListeners();

//       await _firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       return 'Signed in';
//     } on FirebaseAuthException catch (e) {
//       authStatus = AuthStatus.unauthenticated;
//       if (e.code == 'FIRAuthErrorCodeInvalidEmail') {
//         print('No user found for that email');
//         return ('No user found for that email');
//       } else if (e.code == 'FIRAuthErrorCodeWrongPassword') {
//         print('Wrong password provided for that user');
//         return ('wrong password');
//       } else if (e.code == 'wrong-password') {
//         print('Invalid Credential');
//         return ('Invalid Credential');
//       } else {
//         print('Error');
//         return 'Not Signed  in ';
//       }
//     }
//   }

//   Future<String?> signup(
//       {required String email, required String password}) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       authStatus = AuthStatus.authenticated;
//       notifyListeners();
//       return 'signed up';
//     } on FirebaseAuthException catch (e) {
//       authStatus = AuthStatus.unauthenticated;
//       notifyListeners();
//       return e.message;
//     }
//   }

//   Future<String?> Google_SignIN() async {
//     try {
//       authStatus = AuthStatus.authenticating;
//       notifyListeners();
//       final GoogleSignInAccount googleuser =
//           await (GoogleSignIn().signIn() as Future<GoogleSignInAccount>);
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleuser.authentication;

//       final GoogleAuthCredential googleAuthCredential =
//           GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       ) as GoogleAuthCredential;
//       final UserCredential googleUsercred = await FirebaseAuth.instance
//           .signInWithCredential(googleAuthCredential);
//       authStatus = AuthStatus.authenticated;
//       notifyListeners();

//       return 'signed in through google';
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

//   // ignore: non_constant_identifier_names


//   Future<String> authUID() async {
//     return _firebaseAuth.currentUser!.uid;
//   }
// }

// import 'package:AyurCar/routes/app_pages.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// // import 'package:get/state_manager.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

//  class AuthenticationController extends GetxController{
//   late GoogleSignIn googleSignIn;
//   var isSignin = false.obs;
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// void onReady() async{
//   googleSignIn =GoogleSignIn();
//   ever(isSignin,handleAuthStateChanged);
//   isSignin.value= firebaseAuth.currentUser!=null;
//   firebaseAuth.authStateChanges().listen((event) { isSignin.value=event!=null;});

// }
// void handleAuthStateChanged(isLoggedin){
// if(isLoggedin){
//  Get.offAllNamed(Routes.WELCOME,arguments:firebaseAuth.currentUser);
// }
// else{
//   Get.offAllNamed(Routes.LOGIN);
// }
// }

// }
import 'package:AyurCar/model/pateint.dart';
import 'package:AyurCar/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../const.dart';

class AuthenticationController extends GetxController {
  late GoogleSignIn googleSignIn;
  DocRec userdatetime = new DocRec();
  var isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    googleSignIn = GoogleSignIn();
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = await firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });

    super.onReady();
  }
   

  @override
  void onClose() {}

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      // DocRec(timeoflogin:DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now()));
      updateUser();

      Get.offAllNamed(Routes.WELCOME, arguments: firebaseAuth.currentUser);

      var p_data = PatientData;
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  void updateUser() async {
    collectionpersonal.add({"Date and time": userdatetime.docRecc});
  }

  Stream<List<PatientData>?> get userData {
    return patientlistv.snapshots().map(patientlist);
  }

  List<PatientData>? patientlist(QuerySnapshot snapshot) {
    snapshot.docs.map((e) {
      return PatientData(
        age: e['Age'] ?? 0,
        price: e['Price'] ?? 0,
        name: e['Name'] ?? ' ',
        fathername: e["Father's_Name"] ?? ' ',
        phno: e['Phone_number'] ?? ' ',
        prak: e['Prakruti'] ?? ' ',
        hetu: e['Hetu'] ?? ' ',
        bala: e['Bala'] ?? ' ',
        vega: e['Vega'] ?? ' ',
        jivhaa: e['Jiwha'] ?? ' ',
        sweda: e['Sweda'] ?? ' ',
        nadi: e['Nadi'] ?? ' ',
        aahar: e['aahar'] ?? ' ',
        vihaar: e['vihaar'] ?? ' ',
        address: e['address'] ?? ' ',
        bp: e['bp'] ?? ' ',
        cheif: e['cheif'] ?? ' ',
        pulse: e['pulse'] ?? ' ',
        dushya: e['dushya'] ?? ' ',
        dosh: e['dosh'] ?? ' ',
        fam: e['family'] ?? ' ',
        kal: e['kal'] ?? ' ',
        mal: e['mal'] ?? ' ',
        pre: e['previous'] ?? ' ',
        upshy: e['upshya'] ?? ' ',
        anupshy: e['anupshy'] ?? ' ',
        ritu: e['ritu'] ?? ' ',
        medicine: e['medicine'] ?? ' ',
      );
    }).toList();
  }
}
