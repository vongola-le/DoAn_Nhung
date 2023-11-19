import 'package:app_smart_house/items/room_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text(
              "WELCOME",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
              ),
            ]),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My rooms",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(onPressed: null, child: Text("Add new"))
                ],
              ),
              RoomItem(),
              Row(
                children: [Text("Devices In Use")],
              )
            ],
          ),
        )));
  }
}
