import 'package:AyurCar/screens/login_page.dart';
import 'package:AyurCar/services/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassword extends StatelessWidget {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Reset Your Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'Raleway',
                    package: 'my_package'),
              ),
              SizedBox(
                height: 50,
              ),
              ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(colors: [
                    Color.fromRGBO(255, 255, 255, 1),
                    Colors.white,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                      .createShader(bounds);
                },
                child: SvgPicture.asset(
                  'assets/icon/dr3.svg',
                  height: height * 27 / 100,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: email,
                  // onSaved: (value) {
                  //   emai = value;
                  //   email.text = value;
                  // },
                  decoration: InputDecoration(
                      labelText: 'Enter Your Email',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                child: Builder(
                  builder: (context) => ElevatedButton(
                    // style: ButtonStyle(shape: , color: Colors.black.withOpacity(0.7),
                    // splashColor: Colors.blue[900],
                    // backgroundColor: MaterialStateProperty(),

                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(Colors.blue[900]),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),

                    onPressed: () async {
                      print(email.text);
                      await _firebaseAuth.sendPasswordResetEmail(
                          email: email.text);
                      final snackBar = SnackBar(
                        content: Text('Kindly Check Your Email'),
                      );
                      // Scaffold.of(context).showSnackBar(snackBar);
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              TextButton(
                // splashColor: Colors.black,
                // hoverColor: Colors.black,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home()));
                },
                child: Text('Return To Login Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
