<<<<<<< HEAD
import 'package:app_smart_house/firebase_options.dart';
import 'package:app_smart_house/items/AllDeviceScreen.dart';
import 'package:app_smart_house/items/home_screen.dart';
import 'package:app_smart_house/items/login.dart';
import 'package:app_smart_house/model/sign_up.dart';
import 'package:app_smart_house/view/ProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
=======
import 'package:app_smart_house/items/auth_page.dart';
import 'package:app_smart_house/items/sign_in.dart';
>>>>>>> main
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

<<<<<<< HEAD
void main() async{
=======
Future<void> main() async {
>>>>>>> main
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
<<<<<<< HEAD
  runApp(const MyApp());
  
  
=======
  runApp(MyApp());
>>>>>>> main
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  addData() async{
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
<<<<<<< HEAD
      home:const HomeScreen(),
=======
      // home: LoginScreen(),
      home: const AuthPage(),
>>>>>>> main
      debugShowCheckedModeBanner: false,
    );
  }
}
