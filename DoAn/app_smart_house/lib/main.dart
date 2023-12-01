import 'package:app_smart_house/firebase_options.dart';
import 'package:app_smart_house/items/AllDeviceScreen.dart';
import 'package:app_smart_house/items/home_screen.dart';
import 'package:app_smart_house/items/login.dart';
import 'package:app_smart_house/model/sign_up.dart';
import 'package:app_smart_house/view/ProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  
  
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
      home:const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
