import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var auth = FirebaseAuth.instance.currentUser?.uid;
var store = FirebaseFirestore.instance;
var collectionpersonal =
    store.collection('userData').doc(auth).collection('PersonalInfo');
var patientlistv =
    store.collection('userData').doc(auth).collection("Patients");
