import 'package:app_smart_house/items/device_item.dart';
import 'package:app_smart_house/items/room_item.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
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
          ),
          CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 3.2,
                viewportFraction: 0.6,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                RoomItem(name: "Phòng ăn"),
                RoomItem(name: "Phòng khách"),
                RoomItem(name: "Phòng ngủ"),
                RoomItem(name: "Phòng WC")
              ]),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Text(
                  "Devices In Use",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: SingleChildScrollView(
              child: DeviceItem(),
            ),
          )
        ],
      ),
    );
  }
}
