import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class PatientStream {
  var name;

  String? age;
  String? bp;
  String? mal;
  String? nadi;
  String? hetu;
  String? jiwha;
  String? bala;
  String? vega;
  String? sweda;
  String? medicine;
  String? ph;
  String? address;
  String? pul;
  String? dushya;
  String? dosh;
  String? fam;
  String? pre;
  String? prakruti;
  String? upshy;
  String? anups;
  String? kal;
  String? ritu;
  String? cheif;
  String? url;

  PatientStream({
    this.address,
    this.age,
    this.anups,
    this.bala,
    this.bp,
    this.cheif,
    this.dosh,
    this.dushya,
    this.fam,
    this.hetu,
    this.jiwha,
    this.kal,
    this.mal,
    this.medicine,
    this.nadi,
    this.name,
    this.ph,
    this.prakruti,
    this.pre,
    this.pul,
    this.ritu,
    this.sweda,
    this.upshy,
    this.url,
    this.vega,
  });
}
