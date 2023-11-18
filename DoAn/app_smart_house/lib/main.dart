import 'package:app_smart_house/HD_Screen.dart';
import 'package:app_smart_house/TB_Screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'BDLifelessGrotesk'),
      routes: {
        '/':(context) =>const HD_Screen(),
        '/TB':(context) => const TB_Screen(),
      },
      initialRoute:'/' ,
    );
  }
}
