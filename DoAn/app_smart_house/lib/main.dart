import 'package:app_smart_house/items/auth_page.dart';
import 'package:app_smart_house/view/SignInScreen.dart';
import 'package:app_smart_house/view/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
<<<<<<< HEAD
      home: const AuthPage(),
      // home: const AuthPage(),
=======
      // home: Profile(),
      home: const AuthPage(),
>>>>>>> main
      debugShowCheckedModeBanner: false,
    );
  }
}
