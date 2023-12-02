import 'package:app_smart_house/items/add_device.dart';
import 'package:app_smart_house/items/device_item.dart';
import 'package:app_smart_house/items/room_item.dart';
import 'package:app_smart_house/model/DataServiceDevice.dart';
import 'package:app_smart_house/model/deviceData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseReference usersRef = FirebaseDatabase.instance.ref('Device');
  
  List<Device> lst_devices=[];
  int sl_pk=0;
  int sl_gara=0;
  int sl_pa=0;
  int sl_pn=0;
  int sl_wc=0;
  int newIdDevice=1;
  _setupDevice() async{
    List<Device> devicesdata=await DatabaseServiceDevice.getDevices();
    if(mounted){
      setState(() {
        lst_devices.clear();
        sl_pk=0;
        sl_gara=0;
        sl_pa=0;
        sl_pn=0;
        sl_wc=0;
        newIdDevice=devicesdata[devicesdata.length-1].id+1;
      for(var value in devicesdata){
        if(value.status==1){
          lst_devices.add(value);
        }
        if(value.id_room==0){
          sl_pk++;
        }
        else if(value.id_room==1){
          sl_gara++;
        }
        else if(value.id_room==2){
          sl_pa++;
        }
        else if(value.id_room==3){
          sl_pn++;
        }
        else if(value.id_room==4){
          sl_wc++;
        }
      }
    });
    }
  }

  @override
  void initState() {
    super.initState();
    _setupDevice();
  }


  @override
  Widget build(BuildContext context) {    
    Future.delayed(Duration(seconds: 5), () {
       _setupDevice();
    });
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
                          builder: (context) => add_device(newIdDevice: newIdDevice,),
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
                  sl: sl_pa,
                  img: "assets/img/h1.jpg",
                  id_room: 2,
                ),
                RoomItem(
                  name: "Phòng khách",
                  sl: sl_pk,
                  img: "assets/img/h3.jpg",
                  id_room: 0,
                ),
                RoomItem(
                  name: "Phòng ngủ",
                  sl: sl_pn,
                  img: "assets/img/h1.jpg",
                  id_room: 3,
                ),
                RoomItem(
                  name: "Phòng WC",
                  sl: sl_wc,
                  img: "assets/img/h2.jpg",
                  id_room: 4,
                ),
                RoomItem(
                  name: "Ga-ra",
                  sl: sl_gara,
                  img: "assets/img/h2.jpg",
                  id_room: 1,
                )
              ]),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
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
                      children: [
                        if(lst_devices.isNotEmpty)
                          Column(
                            children: List.generate(
                            lst_devices.length,
                            (index) => DeviceItem(
                              device: lst_devices[index]
                            ),
                            ),
                          )
                        else
                          const Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 20)),
                              Text("Không có thiết bị đang hoạt động !",style: TextStyle(fontSize: 20,),)
                            ],
                          )
                      ]
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
