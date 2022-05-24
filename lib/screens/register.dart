import 'package:AyurCar/services/home.dart';

import 'login_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';

import 'package:string_validator/string_validator.dart';

final TextEditingController name = TextEditingController();

final TextEditingController email = TextEditingController();
final TextEditingController clinicN = TextEditingController();
final TextEditingController ph = TextEditingController();
final TextEditingController age = TextEditingController();
final TextEditingController city = TextEditingController();
final TextEditingController clinica = TextEditingController();
String? uidd;

final TextEditingController pass = TextEditingController();

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final _firestore = FirebaseFirestore.instance;

    return Container(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'Register',
        //   ),
        // ),
        body: Container(
          alignment: Alignment.center,
          height: height,
          decoration: BoxDecoration(
            color: Colors.blue[100],
          ),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Text(
                'Welcome to Ayurcare',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'Raleway',
                    package: 'my_package'),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Dr Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Email Address'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: TextField(
                  controller: pass,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Enter Password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: TextField(
                  obscureText: true,
                  controller: pass,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Re Enter Password'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async {
                    var em = isEmail(email.text);
                    if (em == true) {
                      await Firebase.initializeApp();
                      final currentUser = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email.text, password: pass.text);
                      currentUser.user!.sendEmailVerification();
                      setState(() {
                        uidd = currentUser.user!.uid;
                        print(uidd);
                      });
                      AlertDialog alert = AlertDialog(
                        title: Text('Verify Your Email Address '),
                        actions: [
                          RaisedButton(
                              child: Text('Ok'),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  )))
                        ],
                      );

                      print(currentUser.user!.uid);
                      _firestore
                          .collection('userData')
                          .doc(uidd)
                          .collection('PersonalInfo')
                          .add({
                        'DrName': name.text.toUpperCase(),
                        'ClinicName': clinicN.text.toUpperCase(),
                        'Address': clinica.text,
                        'Age': int.parse(age.text),
                        "PhoneNumber": int.parse(ph.text),
                        'City': city.text,
                      });

                      if (FirebaseAuth.instance.currentUser != null) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            });
                      }
                    }
                  },
                  color: Colors.black,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  hoverColor: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Or Sign Up with',
                style: TextStyle(color: Colors.black87),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                child: Column(
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.black,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          Text(
                            'Sign Up with Google',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.black,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.phoneAlt,
                            color: Colors.white,
                          ),
                          Text(
                            'Sign Up with Phone',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
