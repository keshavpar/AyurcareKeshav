import 'package:AyurCar/controller/auth.dart';
import 'package:AyurCar/model/pateint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController {
  AuthenticationController authcontroller =
      Get.find<AuthenticationController>();
  late User user;
  var googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  var uidd = FirebaseAuth.instance.currentUser?.uid;
  PatientData pat = PatientData();
  
  // Future<PatientData?> getdata() async {
  //   fetch = await inst
  //       .collection('userData')
  //       .doc(uidd)
  //       .collection('Patients')
  //       .snapshots();
  //   return PatientData(
  //     aahar: fetch['aahar'] == null ? "null" : fetch['aahar'],
  //     address: fetch['address'] == null ? "null" : fetch['address'],
  //     age: fetch['age'] == null ? "null" : fetch['age'],
  //     anupshy: fetch['anupshy'] == null ? "null" : fetch['anupshy'],
  //     bala: fetch['Bala'] == null ? "null" : fetch['Bala'],
  //     bp: fetch['bp'] == null ? "null" : fetch['bp'],
  //     cheif: fetch['cheif'] == null ? "null" : fetch['cheif'],
  //     dosh: fetch['dosh'] == null ? "null" : fetch['dosh'],
  //     dushya: fetch['dushya'] == null ? "null" : fetch['dushya'],
  //     fam: fetch['fam'] == null ? "null" : fetch['fam'],
  //     fathername:
  //         fetch["Father's_Name"] == null ? "null" : fetch["Father's_Name"],
  //     hetu: fetch['Hetu'] == null ? "null" : fetch['Hetu'],
  //     jivhaa: fetch['Jiwha'] == null ? "null" : fetch['Jiwha'],
  //     kal: fetch['kal'] == null ? "null" : fetch['kal'],
  //     mal: fetch['mal'] == null ? "null" : fetch['mal'],
  //     medicine: fetch['medicine'] == null ? "null" : fetch['medicine'],
  //     nadi: fetch['Nadi'] == null ? "null" : fetch['Nadi'],
  //     name: fetch['Name'] == null ? "null" : fetch['Name'],
  //     phno: fetch['Phone_number'] == null ? "null" : fetch['Phone_number'],
  //     prak: fetch['Prakruti'] == null ? "null" : fetch['Prakruti'],
  //     pre: fetch['previous'] == null ? "null" : fetch['previous'],
  //     price: fetch['price'] == null ? "null" : fetch['price'],
  //     pulse: fetch['pulse'] == null ? "null" : fetch['pulse'],
  //     ritu: fetch['ritu'] == null ? "null" : fetch['ritu'],
  //     sweda: fetch['Sweda'] == null ? "null" : fetch['Sweda'],
  //     upshy: fetch['upshya'] == null ? "null" : fetch['upshya'],
  //     vega: fetch['Vega'] == null ? "null" : fetch['Vega'],
  //     vihaar: fetch['vihaar'] == null ? "null" : fetch['vihaar'],
  //   );
  // }

// Future<PatientData> getdata() async {

//     DocumentSnapshot documentSnapshot =
//         await _firestore.collection('userData').doc(uidd).collection('Patients').get();

//   //  DocumentSnapshot fetch = await _firestore.collection('userData').doc(uidd).collection('Patients').get();
     
//   return  PatientData.fromSnap(fetch);
// }
// Future<PatientData?> printdata() async {
//   print(PatientData().name);
// }



  void oninit() {
    super.onInit();
    user = Get.arguments;
  }

  void signOut() async {
    googleSignIn != null
        ? await googleSignIn.signOut()
        : await (firebaseAuth.signOut() );
  }
}
