 import 'package:flutter/material.dart';

class SignuPReg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final TextEditingController clinicN = TextEditingController();
    final TextEditingController age = TextEditingController();
    final TextEditingController city = TextEditingController();
    final TextEditingController clinica = TextEditingController();
    return Scaffold(
      body: Container(
        color: Colors.blue[100],
        height: height,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
              child: TextField(
                controller: clinicN,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.local_hospital),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Clinic Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
              child: TextField(
                controller: clinica,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.add_road),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Clinic Address'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: age,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Age'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
              child: TextField(
                controller: city,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'City'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
