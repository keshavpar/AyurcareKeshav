

import 'package:AyurCar/model/pateint.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

File? fi;

class NewPatient extends StatefulWidget {
  @override
  NewPatientState createState() => NewPatientState();
}

class NewPatientState extends State<NewPatient> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  PatientData pat = PatientData();

  String? m;
  initState() {
    super.initState();
    if (auth.currentUser != null) {
      setState(() {
        m = auth.currentUser!.uid;
      });
    }
  }

  int? length;

  final _firestore = FirebaseFirestore.instance;
  String? k;
  int flag = 0;

  final TextEditingController name = TextEditingController();
  final TextEditingController fathername = TextEditingController();
  final TextEditingController nadi = TextEditingController();
  final TextEditingController hetu = TextEditingController();
  final TextEditingController medicine = TextEditingController();
  final TextEditingController ph = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController bp = TextEditingController();
  final TextEditingController pul = TextEditingController();
  final TextEditingController dushya = TextEditingController();
  final TextEditingController dosh = TextEditingController();
  final TextEditingController fam = TextEditingController();
  final TextEditingController pre = TextEditingController();
  final TextEditingController upshy = TextEditingController();
  final TextEditingController anups = TextEditingController();
  final TextEditingController kal = TextEditingController();
  final TextEditingController ritu = TextEditingController();
  final TextEditingController mal = TextEditingController();
  final TextEditingController cheif = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController prak = TextEditingController();
  final TextEditingController bala = TextEditingController();
  final TextEditingController vega = TextEditingController();
  final TextEditingController aahar = TextEditingController();
  final TextEditingController vihaar = TextEditingController();
  final TextEditingController jivha = TextEditingController();
  final TextEditingController sweda = TextEditingController();
  var pri;
  Map<dynamic, dynamic>? med;
  var fprice;

  List<String> productName = [];
  var docid;
  int _currsteps = 0;
  Future _openGalllery() async {
    ImagePicker _picker = ImagePicker();
    var pic = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      try {
        fi = File(pic!.path);
      } catch (e) {}
    });
  }

  var mname;
  var quant;
  var cp;
  Future messagestream() async {
    final med = FirebaseFirestore.instance.collection('Inventory');
    med.get().then((value) {
      value.docs.forEach((element) {
        print(element.id);
      });
    });
    //   await for (var snapshot in _firestore.collection('Inventory').snapshots()) {
    //     for (var message in snapshot.documents) {
    //       mname = message.data['Name'];
    //       quant = message.data['Quantity'];
    //       cp = message.data['Cost_p'];
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    Future uploadPic(BuildContext) async {
      firebase_storage.Reference firebase = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("images/" + name.text);
      firebase_storage.UploadTask uploadTask = firebase.putFile(fi!);
      firebase_storage.TaskSnapshot task =
          await uploadTask.whenComplete(() => (task) async {
                k = await task.ref.getDownloadURL();
              });

      setState(() {
        // print(k);
        print("picture uploaded");
        print(name.text);
        flag = 1;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Details Uploaded'),
        ));
      });
    }

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.blue[100]),
        child: Stepper(
          type: StepperType.horizontal,
          steps: _mystep(),
          currentStep: _currsteps,
          onStepTapped: (step) {
            setState(() {
              _currsteps = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (_currsteps < _mystep().length - 1) {
                if (_currsteps == 0) {
                  uploadPic(BuildContext);
                }
                _currsteps = _currsteps + 1;
              } else {
                PatientData pat = PatientData(
                    aahar: aahar.text,
                    address: address.text,
                    age: age.text,
                    anupshy: anups.text,
                    bala: bala.text,
                    bp: bp.text,
                    cheif: cheif.text,
                    dosh: dosh.text,
                    dushya: dushya.text,
                    fam: fam.text,
                    hetu: hetu.text,
                    jivhaa: jivha.text,
                    kal: kal.text,
                    mal: mal.text,
                    medicine: medicine.text,
                    nadi: nadi.text,
                    name: name.text,
                    phno: ph.text,
                    prak: prak.text,
                    pre: pre.text,
                    price: int.parse(price.text),
                    pulse: int.parse(pul.text),
                    ritu: ritu.text,
                    sweda: sweda.text,
                    upshy: upshy.text,
                    vega: vega.text,
                    vihaar: vihaar.text);

                if (_currsteps == _mystep().length - 1) {
                  print(k);
                  _firestore
                      .collection('userData')
                      .doc(m)
                      .collection('Patients')
                      .add(pat.toJson());
                  //   'URL': k,
                  //   'Id': docid,
                  //   'Name': name.text.toUpperCase(),
                  //   "Father's_Name": age.text.toUpperCase(),
                  //   'Phone_number': ph.text,
                  //   'Prakruti': prak.text,
                  //   'Hetu': hetu.text,
                  //   'Bala': bala.text,
                  //   'Vega': vega.text,
                  //   'Jiwha': jivha.text,
                  //   'Sweda': sweda.text,
                  //   'Nadi': nadi.text,
                  //   'aahar': aahar.text,
                  //   'vihaar': vihaar.text,
                  //   'address': address.text,
                  //   'bp': bp.text,
                  //   'cheif': cheif.text,
                  //   'pulse': pul.text,
                  //   'dushya': dushya.text,
                  //   'dosh': dosh.text,
                  //   'family': fam.text,
                  //   'kal': kal.text,
                  //   'mal': mal.text,
                  //   'previous': pre.text,
                  //   'upshya': upshy.text,
                  //   'anupshy': anups.text,
                  //   'ritu': ritu.text,
                  //   'medicine': medicine.text.toUpperCase(),
                  // });

                  if (flag == 1) {
                    name.clear();
                    fi!.delete();

                    address.clear();
                    age.clear();
                    bp.clear();
                    cheif.clear();
                    fam.clear();
                    kal.clear();
                    hetu.clear();
                    medicine.clear();
                    upshy.clear();
                    dushya.clear();
                    dosh.clear();
                    pre.clear();
                    mal.clear();
                    ritu.clear();
                    ph.clear();
                    pre.clear();
                    anups.clear();
                    nadi.clear();
                    fi!.delete();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Home(
                    //               ind: 3,
                    //             )));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Enter all the Details'),
                    ));
                  }
                }
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currsteps > 0) {
                _currsteps = _currsteps - 1;
              }
            });
          },
        ),
      ),
    );
  }

  List<Step> _mystep() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<Step> _steps = [
      Step(
        title: Icon(
          Icons.account_box_outlined,
          color: Colors.black87,
        ),
        content: Container(
            decoration: BoxDecoration(color: Colors.blue[100]),
            child: Column(
              children: <Widget>[
                SizedBox(
                    height: 0,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Enter the User Details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    )),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    height: height * 0.25,
                    width: width * 0.3,
                    child: GestureDetector(
                      child: fi == null
                          ? Icon(Icons.add_a_photo)
                          : Image.file(
                              fi!,
                              fit: BoxFit.fill,
                            ),
                      onTap: () {
                        _openGalllery();
                      },
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.all(20),
                        child: Material(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          elevation: 8,
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Name',
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 40,
                  child: Material(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    elevation: 8,
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          labelText: "Age ",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      controller: age,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.all(20),
                  child: Material(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    elevation: 8,
                    child: TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          // errorText: 'Enter Your Address',
                          labelText: "Address",
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      controller: address,
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Material(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    elevation: 8,
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: ph,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        // errorText: 'Enter Your Number',
                        labelText: 'Phone Number',

                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                  child: Material(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    elevation: 8,
                    child: TextField(
                      controller: prak,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Prakruti',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Material(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    elevation: 8,
                    child: TextField(
                      controller: cheif,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Cheif Complaints',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        isActive: _currsteps >= 0,
      ),
      Step(
          title: Icon(Icons.pages),
          content: Container(
            decoration: BoxDecoration(color: Colors.blue[100]),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: bp,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                            filled: true,
                            labelText: 'BP',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: pul,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Pulse',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
                        child: TextField(
                          controller: nadi,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Nadi',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                        child: TextField(
                          controller: hetu,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Hetu',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
                        child: TextField(
                          controller: bala,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Bala',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                        child: TextField(
                          controller: vega,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Vega',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
                        child: TextField(
                          controller: kal,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Kaal',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                        child: TextField(
                          controller: ritu,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Ritu',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
                        child: TextField(
                          controller: upshy,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Upshyaya',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                        child: TextField(
                          controller: anups,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Anupshaya',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(15, 5, 5, 10),
                        child: TextField(
                          controller: jivha,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Jivha',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
                        child: TextField(
                          controller: sweda,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Sweda',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: TextField(
                    controller: aahar,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Aahar',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: TextField(
                    controller: vihaar,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Vihaar',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isActive: _currsteps >= 1,
          state: StepState.complete),
      Step(
          title: Icon(Icons.history),
          content: Container(
            decoration: BoxDecoration(color: Colors.blue[100]),
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: TextField(
                    controller: dosh,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Dosh',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: TextField(
                    controller: dushya,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Dushya',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: TextField(
                    controller: mal,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Mala',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: TextField(
                    maxLines: 2,
                    controller: pre,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Previous History',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 10),
                  child: TextField(
                    onEditingComplete: () {
                      messagestream();
                    },
                    controller: fam,
                    maxLines: 3,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // errorText: 'Enter Family History',
                      labelText: 'Family History',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isActive: _currsteps >= 2,
          state: StepState.complete),

      Step(
        title: Icon(Icons.medical_services),
        content: Container(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: TextField(
                        // onChanged: (value) {
                        //   var k = Firestore.instance
                        //       .collection('Inventory')
                        //       .where('Name', isEqualTo: value)
                        //       .snapshots();

                        //   k.forEach((element) {
                        //     element.documents.asMap().forEach((key, value) {
                        //       productName.add(element.documents[key]["name"]);
                        //     });
                        //   });
                        // },
                        controller: medicine,
                        maxLines: 3,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Medicines',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                      child: IconButton(
                    icon: Icon(
                      Icons.search_off_rounded,
                      color: Colors.black87,
                    ),
                    onPressed: () async {
                      String u = medicine.text;
                      List<String> t = u.split(",");
                      for (var i in t) {
                        FirebaseFirestore.instance
                            .collection('userData')
                            .doc(m)
                            .collection('Inventory')
                            .where('name', isEqualTo: i)
                            .get()
                            .then((value) => {
                                  value.docs.forEach((element) {
                                    // docid = element.documentID;
                                    med = element.data();
                                    pri = med!['Actual_p'];
                                    setState(() {
                                      fprice = fprice + pri;
                                    });
                                  })
                                });

                        // print(fprice);
                        // fprice = fprice + int.parse(med['Actual_p']);
                      }
                    },
                  ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 130, 10),
                child: Text(
                  "Price : " + fprice.toString(),
                ),
              ),
            ],
          ),
        ),
        isActive: _currsteps >= 3,
        state: StepState.complete,
      )
      // Step(
      //     title: Text('Medication'),
      //     content: TextField(),
      //     isActive: _currsteps >= 3)
    ];
    return _steps;
  }
}
