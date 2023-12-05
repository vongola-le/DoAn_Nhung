import 'dart:ui';

import 'package:app_smart_house/view/HDScreen.dart';
import 'package:app_smart_house/view/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  Future<void> signIn() async {
    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/signIn.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        top:
                            280 // Adjust the top padding to push the content down
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hello Again!',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                            color: Color(0xFF0597F2),
                            shadows: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(1, 1),
                                spreadRadius: 5,
                              ),
                              // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Welcome back',
                          style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF0597F2),
                              fontWeight: FontWeight.w500,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                  offset: Offset(1, 1),
                                  spreadRadius: 5,
                                ),
                                // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                              ]),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Color(0xFF0597F2), width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                style: TextStyle(
                                  color: Color(0xFF0597F2),
                                  fontSize: 18,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 10,
                                      offset: Offset(1, 1),
                                      spreadRadius: 5,
                                    ),
                                    // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                  ],
                                ),
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF0597F2),
                                    fontSize: 18,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 10,
                                        offset: Offset(1, 1),
                                        spreadRadius: 5,
                                      ),
                                      // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                    ], // Màu chữ gợi ý
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: Color(0xFF0597F2), width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Color(0xFF0597F2),
                                  fontSize: 18,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 10,
                                      offset: Offset(1, 1),
                                      spreadRadius: 5,
                                    ),
                                    // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                  ],
                                ),
                                controller: passwordController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Color(0xFF0597F2),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: Color(0xFF0597F2),
                                      fontSize: 18,
                                      shadows: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 10,
                                          offset: Offset(1, 1),
                                          spreadRadius: 5,
                                        ),
                                        // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                      ]),
                                ),
                                obscureText: _obscureText,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: signIn,
                                borderRadius: BorderRadius.circular(50),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: const Color(0xFF0597F2),
                                      width: 2,
                                    ),
                                  ),
                                  child: Container(
                                    width: 250,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: const Color(0xFF0597F2),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10,
                                              offset: Offset(1, 1),
                                              spreadRadius: 5,
                                            ),
                                            // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: signInWithGoogle,
                                borderRadius: BorderRadius.circular(50),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: const Color(0xFF0597F2),
                                      width: 2,
                                    ),
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Sign in With Google',
                                      style: TextStyle(
                                          color: Color(0xFF0597F2),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 10,
                                              offset: Offset(1, 1),
                                              spreadRadius: 5,
                                            ),
                                            // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }
}
