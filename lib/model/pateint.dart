import 'package:AyurCar/screens/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

var fetch;
FirebaseFirestore inst = FirebaseFirestore.instance;

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
// void printdata(){
//   print(PatientData);
// }

class PatientData {
  final String? name;
  final String? fathername;
  final String? nadi;
  final int? pulse;
  final String? hetu;
  final String? medicine;
  final String? phno;
  final String? age;
  final String? address;
  final String? bp;
  final String? dushya;
  final String? dosh;
  final String? fam;
  final String? pre;
  final String? upshy;
  final String? anupshy;
  final String? kal;
  final String? mal;
  final String? ritu;
  final String? cheif;
  final int? price;
  final String? prak;
  final String? bala;
  final String? vega;
  final String? aahar;
  final String? vihaar;
  final String? jivhaa;
  final String? sweda;

  const PatientData(
      {this.name,
      this.fathername,
      this.nadi,
      this.pulse,
      this.hetu,
      this.medicine,
      this.phno,
      this.age,
      this.address,
      this.bp,
      this.dushya,
      this.dosh,
      this.fam,
      this.pre,
      this.upshy,
      this.anupshy,
      this.kal,
      this.mal,
      this.ritu,
      this.cheif,
      this.price,
      this.prak,
      this.bala,
      this.vega,
      this.aahar,
      this.vihaar,
      this.jivhaa,
      this.sweda});

  Map<String, dynamic> toJson() => {
        "name": name,
        'FatherName': fathername,
        "Age": age,
        'Phone_number': ph,
        'Prakruti': prak,
        'Hetu': hetu,
        'Bala': bala,
        'Vega': vega,
        'Jiwha': jivhaa,
        'Sweda': sweda,
        'Nadi': nadi,
        'aahar': aahar,
        'vihaar': vihaar,
        'address': address,
        'bp': bp,
        'cheif': cheif,
        'pulse': pulse,
        'dushya': dushya,
        'dosh': dosh,
        'family': fam,
        'kal': kal,
        'mal': mal,
        'previous': pre,
        'upshya': upshy,
        'anupshy': anupshy,
        'ritu': ritu,
        'medicine': medicine,
      
      };

  static PatientData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap as Map<String, dynamic>;

    return PatientData(
        aahar: snapshot['aahar'],
        address: snapshot['address'],
        age: snapshot['Age'],
        anupshy: snapshot['anupshy'],
        bala: snapshot['Bala'],
        bp: snapshot['bp'],
        cheif: snapshot['cheif'],
        dosh: snapshot['dosh'],
        dushya: snapshot['dushya'],
        fam: snapshot['family'],
        hetu: snapshot['Hetu'],
        jivhaa: snapshot['Jiwha'],
        kal: snapshot['kal'],
        mal: snapshot['mal'],
        medicine: snapshot['medicine'],
        nadi: snapshot['Nadi'],
        name: snapshot['name'],
        phno: snapshot['Phone_number'],
        prak: snapshot['Prakruti'],
        pre: snapshot['previous'],
        price: snapshot[''],
        pulse: snapshot['pulse'],
        ritu: snapshot['ritu'],
        sweda: snapshot['Sweda'],
        upshy: snapshot['upshya'],
        vega: snapshot['Vega'],
        vihaar: snapshot['vihaar']);
  }
}

class Doctor {
  String name;
  String email;
  String clinicN;
  String ph;
  String age;
  String city;
  String clinicAdd;
  Doctor({
    required this.name,
    required this.email,
    required this.clinicN,
    required this.ph,
    required this.age,
    required this.city,
    required this.clinicAdd,
  });
}

class DocRec {
  late String timeoflogin =
      DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now());

  String get docRecc {
    return timeoflogin;
  }

  set setdoc(String timeDate) {
    this.timeoflogin = timeoflogin;
  }
}

class Inventory {
  int? quantity;
  int? aprice;
  int? cprice;
  DateTime? expiryD;
  String? name;
  Inventory({
    this.quantity,
    this.aprice,
    this.cprice,
    this.expiryD,
    this.name,
  });
}
