import 'package:app_smart_house/items/room_item.dart';
import 'package:app_smart_house/model/home_screen.dart';
import 'package:app_smart_house/model/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromRGBO(5, 151, 242, 0)),
          useMaterial3: true,
          fontFamily: 'BDLifelessGrotesk'),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
