import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserF extends StatefulWidget {
  final String? name;
  final String? age;

  UserF({this.age, this.name});
  @override
  UserFState createState() => UserFState();
}

class UserFState extends State<UserF> {
  var fetchdata;
  String? url;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? m;
  initState() {
    super.initState();
    // auth.onAuthStateChanged
    //     .firstWhere((element) => element != null)
    //     .then((value) {
    //   setState(() {
    //     m = value.uid;
    //   });

    //   print(m);
    //   fetchdata = Firestore.instance
    //       .collection('userData')
    //       .document(m)
    //       .collection('Patients')
    //       .where('Name', isEqualTo: widget.name)
    //       .where("Father's_Name", isEqualTo: widget.age)
    //       .snapshots();
    // });
    if (auth.currentUser != null) {
      setState(() {
        m = auth.currentUser!.uid;
      });
    }
    fetchdata = FirebaseFirestore.instance
        .collection('userData')
        .doc(m)
        .collection('Patients')
        .where('Name', isEqualTo: widget.name)
        .where("Father's_Name", isEqualTo: widget.age)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final String? na = widget.name;
    String? name;
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
    // ignore: unused_local_variable
    String? id;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('$na'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: fetchdata,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              CircularProgressIndicator();
            }
            final dataa = snapshot.data!.docs;
            for (var k in dataa) {
              url = k['URL'];
              print(url);
              id = k['Id'];
              name = k['Name'];
              prakruti = k['Prakruti'];
              age = k["Father's_Name"];
              bp = k["bp"];
              mal = k["mal"];
              nadi = k['Nadi'];
              hetu = k['Hetu'];
              bala = k['Bala'];
              vega = k['Vega'];
              jiwha = k['Jiwha'];
              sweda = k['Sweda'];
              address = k['address'];
              cheif = k['cheif'];
              dosh = k['dosh'];
              dushya = k['dushya'];
              fam = k['family'];
              kal = k['kal'];
              pre = k['previous'];
              pul = k['pulse'];
              ritu = k['ritu'];
              anups = k['anupshy'];
              upshy = k['upshya'];
              ph = k['Phone_number'];
              medicine = k['medicine'];
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Material(
                          elevation: 20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              url!,
                              height: 180,
                              width: 150,
                            ),
                          ),
                        ),
                        Text('Age  :  ' + age!),
                        Text('Address  :  ' + address!),
                        Text('Phone No :  ' + ph!),
                        Text('Prakruti :  ' + prakruti!),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Patient Details",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 20),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "BP  :  " + bp!,
                                      ),
                                    )),
                                DecoratedBox(
                                    decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Pulse :  " + pul!),
                                    )),
                              ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 0),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Bala  :" + bala!),
                                  )),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Vega :  " + vega!),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 0),
                          padding: const EdgeInsets.all(10.0),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Dushya  :  " + dushya!),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 0),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Jivha :  " + jiwha!),
                                  )),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Sweda :  " + sweda!),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Nadi :  " + nadi!),
                                  )),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Dosh  :  " + dosh!),
                                  )),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: <Widget>[
                        //       DecoratedBox(
                        //           decoration: BoxDecoration(
                        //               border: Border.all(),
                        //               borderRadius: BorderRadius.circular(5)),
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Text("Ushaya  :  " + upshy),
                        //           )),
                        //       DecoratedBox(
                        //           decoration: BoxDecoration(
                        //               border: Border.all(),
                        //               borderRadius: BorderRadius.circular(5)),
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: Text("Anupshya  :  " + anups),
                        //           )),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Upshaya  :  " + upshy!),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Hetu  :  " + hetu!),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Anupshya  :  " + anups!),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Kaal  :  " + kal!),
                                  )),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Ritu  :  " + ritu!),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Mal  :  " + mal!),
                                  )),
                              DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Family   :  " + fam!),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Cheif Problem  :  " + cheif!),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Previous History  :  " + pre!),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Medicines  :  " + medicine!),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
