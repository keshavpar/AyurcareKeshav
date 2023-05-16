
import 'package:AyurCar/controller/logincontroller.dart';

import 'package:get/get.dart';


import '../services/forgotpass.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends GetView<LoginController> {
  // void updateEmail(BuildContext context, String email) {
  //   context.read(emailprovider).state = email;
  // }

  // void updatePass(BuildContext context, String pass) {
  //   context.read(passprovider).state = pass;
  // }

  GoogleSignInAccount? curr;

  UserCredential? user;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    bool isloading = false;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue[100],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: height * 0.1,
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
                  height: height * 0.02,
                ),
                // Image.asset(
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                            colors: [
                          Color.fromRGBO(255, 255, 255, 1),
                          Colors.white,
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)
                        .createShader(bounds);
                  },
                  child: SvgPicture.asset(
                    'assets/icon/dr1.svg',
                    height: height * 27 / 100,
                  ),
                ),

               
                SizedBox(
                  height: 30,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.loginformKey,
                                  child: Column(
                                    children: [
                                      Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      onSaved: (value) {
                        controller.email = value!;
                      },
                      validator: (value) {
                        controller.validateEmail(value!);
                      },
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black87),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Colors.black87),
                          labelText: 'Enter your email',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: EdgeInsets.all(1)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                     Padding(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                  child: TextFormField(
                    onSaved: (value) {
                      controller.password = value!;
                    },
                    validator: (value) {
                      controller.validatePass(value!);
                    },
                    obscureText: true,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black87),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black87,
                      ),
                      labelText: 'Enter your Password',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                    textAlign: TextAlign.center,
                    controller: controller.passwordController,
                  ),
                ),
                     ],
                                  ),
                ),

             
                SizedBox(
                  height: height * 0.03,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: width - 30,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                           
                            onPressed: () {
                              controller.checklogin();
                              print(controller.email);
                              print(controller.password);
                              controller.signin(
                                  email: controller.email,
                                  password: controller.password);

                                  
                              // print(email);
                              // print(password);                                             
                              // _auth.signin(
                              //     email: email, password: password);
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                    
                   TextButton(
                      
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: Text('Forgot Password'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          child: ElevatedButton(
                           
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Sign In with Google',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            onPressed: () {
                              controller.login();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ));
                    },
                    child: Text(
                      'Dont Have an Account? Sign Up',
                      style: TextStyle(color: Colors.black87),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// // ignore: must_be_immutable
// class AuthSign extends ConsumerWidget {
//   var email;
//   var password;
//   AuthSign(this.email, this.password);

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final _auth = watch(authServiceP);
//     final user = _auth.signin(email: email.text, password: password.text);

//     if (user != null) {
//       return CircularProgressIndicator();
//     } else {
//       return AlertDialog(
//         actions: [
//           Text('Error'),
//           TextButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => LoginPage(),
//                     ));
//               },
//               child: Text('Ok'))
//         ],
//       );
//     }
//   }
// }
