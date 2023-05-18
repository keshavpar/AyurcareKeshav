import 'package:AyurCar/controller/homecontroller.dart';
import 'package:AyurCar/routes/app_pages.dart';
import 'package:get/get.dart';

import '../screens/patientList.dart';

import '../screens/inventory.dart';

import '../screens/login_page.dart';
import '../screens/newUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final ind;

  Home({this.ind, l}) : super();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;
  String? uid;
  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('PersonalInfo')
        .get()
        .then((val) {
      val.docs.forEach((element) {
        var nam = element.data();
        setState(() {
          name = nam['ClinicName'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var user = FirebaseAuth.instance.currentUser;
    // controller.getdata();

    void choiceAction(String choice) {
      controller.signOut();
      Get.offAllNamed(Routes.LOGIN);
    }

    Future<bool?> onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you really want to exit'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('No'),
            ),
            TextButton(
                child: Text('Yes'),
                onPressed: () {
                  controller.signOut();

                  Get.offNamed(Routes.LOGIN);
                })
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: WillPopScope(
        onWillPop:
            (() => onBackPressed() as Future<bool>) as Future<bool> Function()?,
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.blue[100],
              appBarTheme: AppBarTheme(
                color: Colors.blue[100],
              ),
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: Colors.blue[100])),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                name == null ? 'AyurCare' : name!,
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w900),
              ),
              actions: <Widget>[
                PopupMenuButton(
                    onSelected: choiceAction,
                    itemBuilder: (BuildContext context) {
                      return Constatnts.choices.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    })
              ],
              bottom: TabBar(
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.black87,
                labelColor: Colors.black87,
                tabs: <Widget>[
                  Tab(
                    child: Text('Enter Details'),
                  ),
                  Tab(
                    child: Text('Patient List'),
                  ),
                  Tab(
                    child: Text('Inventory'),
                  )
                ],
              ),
              backgroundColor: Colors.blue[200],
            ),
            body: TabBarView(
              children: <Widget>[
                NewPatient(),
                Listf(uid = uid),
                Inventory(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Constatnts {
  static const String SignOut = 'SignOut';
  static const List<String> choices = [SignOut];
}
