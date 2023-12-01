import 'package:app_smart_house/items/add_device.dart';
import 'package:app_smart_house/items/device_item.dart';
import 'package:app_smart_house/items/room_item.dart';
import 'package:app_smart_house/model/DataServiceDevice.dart';
import 'package:app_smart_house/model/deviceData.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Device> lst_devices=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupUsers();
  }

  _setupUsers() async{
    List<Device> devicesdata=await DatabaseServiceDevice.getDevices();
      setState(() {
      lst_devices=devicesdata;
    });
  }
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => add_device(),
                        ),
                      );
                    },
                    child: Text("Add new"))
              ],
            ),
          ),
          CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.6,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                RoomItem(
                  name: "Phòng ăn",
                  tem: "30",
                  sl: 2,
                  img: "assets/img/h1.jpg",
                ),
                RoomItem(
                  name: "Phòng khách",
                  img: "assets/img/h3.jpg",
                ),
                RoomItem(
                  name: "Phòng ngủ",
                  img: "assets/img/h1.jpg",
                ),
                RoomItem(
                  name: "Phòng WC",
                  img: "assets/img/h2.jpg",
                ),
                RoomItem(
                  name: "Phòng Gara",
                  img: "assets/img/h2.jpg",
                )
              ]),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Row(
              children: [
                Text(
                  "Recently Use",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  lst_devices.length,
                  (index) => DeviceItem(
                    device: lst_devices[index]
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
