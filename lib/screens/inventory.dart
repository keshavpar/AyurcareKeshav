// import 'package:Ayurvedaa/user.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'auth.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  final TextEditingController name = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? k;
  DateTime? _expirydate;
  final TextEditingController quantity = TextEditingController();
  final TextEditingController aprice = TextEditingController();
  final TextEditingController cprice = TextEditingController();
  String? m;
  final TextEditingController cxp = TextEditingController();
  initState() {
    super.initState();
    if (auth.currentUser != null) {
      setState(() {
        m = auth.currentUser!.uid;
        print(m);
      });
    }
  }

  String? mvalue;
  @override
  Widget build(BuildContext context) {
    List<Userdet> dat = [];

    String? nam;
    int? actprice;
    int? mrp;
    String? typ;
    String docid;

    // AuthService l = AuthService();
    String? expirydate;
    int? qaunt;
    final _firestore = FirebaseFirestore.instance;
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(color: Colors.blue[100]),
        child: Column(
          children: <Widget>[
            Container(
              width: width - 20,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Medicine Details',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 10, 2, 8),
                            child: GestureDetector(
                              child: TextField(
                                controller: cxp,
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2030))
                                      .then((value) {
                                    _expirydate = value;
                                    setState(() {
                                      cxp.text = _expirydate!.day.toString() +
                                          '/' +
                                          _expirydate!.month.toString() +
                                          '/' +
                                          _expirydate!.year.toString();
                                    });
                                  });
                                },
                                decoration: InputDecoration(
                                    labelText: 'Expiry Date',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 10, 8, 8),
                            child: TextField(
                              controller: quantity,
                              keyboardType: TextInputType.numberWithOptions(),
                              decoration: InputDecoration(
                                  labelText: 'Quantity',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6, 10, 1, 8),
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: aprice,
                              decoration: InputDecoration(
                                  labelText: 'Actual Price',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            height: 75,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(2, 8, 0, 8),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      hint: Text('Type'),
                                      value: mvalue,
                                      items: [
                                        DropdownMenuItem<String>(
                                          child: Text('Capsule'),
                                          value: 'Capsule',
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text('Kadha'),
                                          value: 'Kadha',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Tablet'),
                                          value: 'Tab',
                                        )
                                      ],
                                      onChanged: (nvalue) {
                                        print(nvalue.toString());
                                        setState(() {
                                          mvalue = nvalue;
                                        });
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6, 10, 1, 8),
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: cprice,
                              onEditingComplete: () async {
                                print(cxp.text);
                                _firestore
                                    .collection('userData')
                                    .doc(m)
                                    .collection('Inventory')
                                    .add({
                                  'name': name.text.toUpperCase(),
                                  'Expirydate': cxp.text,
                                  'Quantity': int.parse(quantity.text),
                                  "Actual_p": int.parse(aprice.text),
                                  'MRP': int.parse(cprice.text),
                                  'Type': mvalue,
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: 'MRP',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: heigth * 0.44,
              child: Column(children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('userData')
                        .doc(m)
                        .collection('Inventory')
                        .snapshots(),
                    builder: (context, snapshot) {
                      // initState();
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return CircularProgressIndicator();
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            print(snapshot.error);
                          }
                          final dataa = snapshot.data!.docs;

                          for (var data in dataa) {
                            nam = data['name'];
                            qaunt = data["Quantity"];
                            expirydate = data["Expirydate"];
                            actprice = data['Actual_p'];
                            mrp = data['MRP'];
                            typ = data['Type'];
                            docid = data.id;
                            final dataa = Userdet(
                              name: nam,
                              quant: qaunt,
                              act: actprice,
                              cst: mrp,
                              expi: expirydate,
                              typi: typ,
                              docid: docid,
                              mdocid: m,
                            );

                            dat.add(dataa);
                          }
                      }
                      return Expanded(
                        child: ListView(children: dat),
                      );
                    })
              ]),
            )
          ],
        ),
      ),
    ));
  }
}

class Userdet extends StatefulWidget {
  final String? name;
  final String? docid;
  final String? mdocid;

  // final String datestart;

  final int? act;
  final int? cst;
  final int? quant;
  final String? expi;
  final String? typi;

  Userdet({
    this.name,
    this.act,
    this.expi,
    this.cst,
    this.quant,
    this.typi,
    this.docid,
    this.mdocid,

    // @required this.datestart,
  });

  @override
  _UserdetState createState() => _UserdetState();
}

class _UserdetState extends State<Userdet> {
  var flag = 0;
  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice) {
      FirebaseFirestore.instance
          .collection('userData')
          .doc(widget.mdocid)
          .collection('Inventory')
          .doc(widget.docid)
          .delete()
          .whenComplete(() => {
                setState(() {
                  Navigator.pop(context);
                  _UserdetState();
                })
              })
          .catchError((e) {
        print(e);
      });
    }

    return Material(
      child: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(color: Colors.blue[100]),
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [Colors.green[200], Colors.green[50]])),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
              elevation: 10,
              child: Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Name : ' + widget.name!,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Quantity  : ' + widget.quant.toString(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Expiry Date  : ' + widget.expi!,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Cost Price  : ' + widget.cst.toString(),
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            Text('Med Typ : ' + widget.typi.toString(),
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            Text("M.R.P  : " + widget.act.toString(),
                                style: TextStyle(fontWeight: FontWeight.w600))
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: double.minPositive,
                      child: PopupMenuButton(
                          onSelected: choiceAction,
                          itemBuilder: (BuildContext context) {
                            return Constatnts.choices.map((String choice) {
                              return PopupMenuItem(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          }),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class Constatnts {
  static const String Delete = 'Delete';
  static const List<String> choices = [Delete];
}
