import 'dart:ui';

import 'package:app_smart_house/HD_Screen.dart';
import 'package:app_smart_house/view/home_screen.dart';
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
<<<<<<< Updated upstream
=======
    
>>>>>>> Stashed changes
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/h4.png'),
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
                              color:  Color(0xFF0597F2),
                              shadows:[
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 10,
                                            offset: Offset(1, 1),
                                            spreadRadius: 5,
                                          ),
                                          // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                          
                                        ] ,),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Welcome back',
<<<<<<< Updated upstream
                          style: TextStyle(fontSize: 35, color: Colors.black),
=======
                          style: TextStyle(
                              fontSize: 35,
                              color: Color(0xFF0597F2),
                              fontWeight: FontWeight.w500,
                              shadows:[
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 10,
                                            offset: Offset(1, 1),
                                            spreadRadius: 5,
                                          ),
                                          // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                          
                                        ] ,
                              ),
>>>>>>> Stashed changes
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Container(
                            decoration: BoxDecoration(
<<<<<<< Updated upstream
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
=======
                              color: Colors.transparent,
                              border: Border.all(color: Color(0xFF0597F2),width: 2.0),
>>>>>>> Stashed changes
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
<<<<<<< Updated upstream
                                  hintText: 'Email/Phone',
=======
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    shadows:[
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 10,
                                            offset: Offset(1, 1),
                                            spreadRadius: 5,
                                          ),
                                          // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                          
                                        ] ,
                                    color: Color(0xFF0597F2),
                                    fontSize: 18 // Màu chữ gợi ý
                                  ),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
=======
                              
                              color: Colors.transparent,
                              border: Border.all(color: Color(0xFF0597F2),width: 2),
>>>>>>> Stashed changes
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
<<<<<<< Updated upstream
                                  border: InputBorder.none,
                                  hintText: 'Password',
=======
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText? Icons.visibility_off:Icons.visibility,
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
                                    shadows:[
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 10,
                                            offset: Offset(1, 1),
                                            spreadRadius: 5,
                                          ),
                                          // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                          
                                        ] ,
                                    color: Color(0xFF0597F2),
                                    fontSize: 18 
                                  ),
>>>>>>> Stashed changes
                                ),
                                obscureText: true,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Center(
<<<<<<< Updated upstream
                            child: ElevatedButton(
                              onPressed: signIn,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(250, 50),
                                backgroundColor: const Color(0xFF0597F2),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
=======
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
                                        color:
                                            Color.fromARGB(255, 6, 153, 245),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        shadows:[
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 10,
                                            offset: Offset(1, 1),
                                            spreadRadius: 5,
                                          ),
                                          // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                          
                                        ] 
                                      ),
                                    ),
>>>>>>> Stashed changes
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Center(
<<<<<<< Updated upstream
                            child: ElevatedButton(
                              onPressed: signInWithGoogle,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                                backgroundColor: const Color(0xFF0597F2),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
=======
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
                                        shadows:[
                                          BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 10,
                                            offset: Offset(1, 1),
                                            spreadRadius: 5,
                                          ),
                                          // Bóng đổ màu xanh, độ mờ 10, vị trí (-5, -5), kích thước 5
                                          
                                        ] 
                                      ),
                                    ),
>>>>>>> Stashed changes
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Sign in With Google',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
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
