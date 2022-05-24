import 'package:AyurCar/const.dart';
import 'package:AyurCar/model/pateint.dart';

import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Listf extends StatefulWidget {
  final String? uid;

  Listf(this.uid);

  @override
  _ListfState createState() => _ListfState();
}

class _ListfState extends State<Listf> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? m;
  var fetch;
  @override
  void initState() {
    super.initState();

    if (auth.currentUser != null) {
      setState(() {
        m = auth.currentUser!.uid;
        print(m);
      });
    }
    print(m);
    CircularProgressIndicator();
    //   fetch = Firestore.instance
    //       .collection('userData')
    //       .document(m)
    //       .collection('Patients')
    //       .snapshots();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.blue[70]),

        // if (snapshot.connectionState == ConnectionState.waiting &&
        //     snapshot.data == null) {
        //   CircularProgressIndicator();
        // }

        child: StreamBuilder(
            stream: firestore
                .collection('userData')
                .doc(m)
                .collection('Patients')
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot sn = snapshot.data!.docs[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserF(
                                        name: sn['Name'],
                                        age: sn["Father's_Name"],
                                      )));
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
                            elevation: 5,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.fromLTRB(15, 7, 20, 7),
                                      width: 60,
                                      height: 60,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(sn['URL']))),
                                  Expanded(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                        Wrap(
                                          runAlignment: WrapAlignment.center,
                                          runSpacing: 20,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  sn['Name'].toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(sn["Father's_Name"]),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Text(sn['cheif']),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(sn['Nadi']),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                        // Text(sn['Name']),
                                      ])),
                                ])));
                  },
                  // itemCount: sna.docs.length,
                );
              }
            }));
  }
}
