import 'package:AyurCar/screens/login_page.dart';
import 'package:AyurCar/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Splash1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.blue[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 20 / 100,
            ),
            Text(
              'Welcome to Ayurcare',
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
                  // Colors.green[100],
                  // Colors.black26
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                    .createShader(bounds);
              },
              child: SvgPicture.asset(
                'assets/icon/dr2.svg',
                height: height * 27 / 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: Text(
                'Ayurcare is a cloud solution to assist Ayurvedic Practitioners to store their patient details and to manage their inventory effeciently',
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        // color: Colors.black54,6
                        child: Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        }),
                  ),
                 TextButton(
                      onPressed: () {
                       
                      },
                      child: Text('Already Have an Account? Log In'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
