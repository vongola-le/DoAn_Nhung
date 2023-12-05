import 'package:app_smart_house/items/notification_drawer.dart';
import 'package:app_smart_house/items/add_device.dart';
import 'package:app_smart_house/items/device_item.dart';
import 'package:app_smart_house/items/room_item.dart';
import 'package:app_smart_house/model/DataServiceDevice.dart';
import 'package:app_smart_house/model/DeviceData.dart';
import 'package:app_smart_house/view/BottomMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color notifiColor = const Color.fromARGB(255, 220, 198, 4);
<<<<<<< HEAD:DoAn/app_smart_house/lib/view/home_screen.dart
  Device device=Device(id: -1, name: "", effect: 0, room: "", status: -1, type: -1, mode: -1, data: "", id_room: -1);
=======
  Device device = Device(
      id: -1,
      name: "",
      effect: 0,
      room: "",
      status: -1,
      type: -1,
      mode: -1,
      data: "",
      id_room: -1);
>>>>>>> main:DoAn/app_smart_house/lib/view/HomeScreen.dart
  List<Device> lst_devices = [];
  int sl_pk = 0;
  int sl_gara = 0;
  int sl_pa = 0;
  int sl_pn = 0;
  int sl_wc = 0;
  int newIdDevice = 1;
<<<<<<< HEAD:DoAn/app_smart_house/lib/view/home_screen.dart
  bool alarm=false;

=======
  bool alarm = false;
>>>>>>> main:DoAn/app_smart_house/lib/view/HomeScreen.dart

  _setupDevice() async {
    List<Device> devicesdata = await DatabaseServiceDevice.getDevices();
    if (mounted) {
      setState(() {
<<<<<<< HEAD:DoAn/app_smart_house/lib/view/home_screen.dart
        device=devicesdata[1];
=======
        device = devicesdata[1];
>>>>>>> main:DoAn/app_smart_house/lib/view/HomeScreen.dart
        lst_devices.clear();
        sl_pk = 0;
        sl_gara = 0;
        sl_pa = 0;
        sl_pn = 0;
        sl_wc = 0;
        newIdDevice = devicesdata[devicesdata.length - 1].id + 1;
        for (var value in devicesdata) {
          if (value.status == 1) {
            lst_devices.add(value);
          }
          if (value.id_room == 0) {
            sl_pk++;
          } else if (value.id_room == 1) {
            sl_gara++;
          } else if (value.id_room == 2) {
            sl_pa++;
          } else if (value.id_room == 3) {
            sl_pn++;
          } else if (value.id_room == 4) {
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
    _setupDevice();
    final currentUser = FirebaseAuth.instance.currentUser;
    final String email = currentUser?.email ?? '';
    final String username = email.isNotEmpty ? email.split('@')[0] : '';
    final String welcomeText =
<<<<<<< HEAD:DoAn/app_smart_house/lib/view/home_screen.dart
        "WELCOME ${currentUser?.displayName!=""?currentUser!.displayName:(username.isNotEmpty ? username : "Unknown User")}";
=======
        "WELCOME ${currentUser?.displayName != "" ? currentUser!.displayName : (username.isNotEmpty ? username : "Unknown User")}";
>>>>>>> main:DoAn/app_smart_house/lib/view/HomeScreen.dart
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF0597F2),
          title: Text(
            welcomeText,
            style: TextStyle(color: Colors.white),
          ),
          
          actions: [
            Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                  notifiColor = Colors.white;
                },
                icon: Icon(
                  Icons.notifications,
                  color: notifiColor,
                ),
              );
            })
          ]),
      endDrawer: const NotificationDrawer(),
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
<<<<<<< HEAD:DoAn/app_smart_house/lib/view/home_screen.dart
                      device.mode==0?device.mode=1:device.mode=0;
                      DatabaseServiceDevice.updateData(device);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 227, 98, 89),

                      )
                    ),
                    child: Text("Báo động")
                    )
=======
                      device.mode == 0 ? device.mode = 1 : device.mode = 0;
                      DatabaseServiceDevice.updateData(device);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 227, 98, 89),
                    )),
                    child: Text("Báo động"))
>>>>>>> main:DoAn/app_smart_house/lib/view/HomeScreen.dart
              ],
            ),
          ),
          CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.6,
                initialPage: 0,
                enableInfiniteScroll: true,
                // enlargeCenterPage: true,
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
                  img: "assets/img/h2.jpg",
                  id_room: 0,
                ),
                RoomItem(
                  name: "Phòng ngủ",
                  sl: sl_pn,
                  img: "assets/img/h3.jpg",
                  id_room: 3,
                ),
                RoomItem(
                  name: "Phòng WC",
                  sl: sl_wc,
                  img: "assets/img/h4.jpg",
                  id_room: 4,
                ),
                RoomItem(
                  name: "Ga-ra",
                  sl: sl_gara,
                  img: "assets/img/h5.jpg",
                  id_room: 1,
                )
              ]),
<<<<<<< HEAD:DoAn/app_smart_house/lib/view/home_screen.dart

          Column(
            children: [
              if(device.mode==1)
                Container(
                width: MediaQuery.of(context).size.width/1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded,color: Color.fromARGB(255, 227, 98, 89),size: 120,),
                    Text("Chú ý ngôi nhà của đang ở trạng thái báo động!",style: TextStyle(color: Color.fromARGB(255, 227, 98, 89),fontSize: 20),textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ],
          ),
          
          Padding(
=======
          Column(
            children: [
              if (device.mode == 1)
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Color.fromARGB(255, 227, 98, 89),
                        size: 120,
                      ),
                      Text(
                        "Chú ý ngôi nhà của bạn đang ở trạng thái báo động!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 227, 98, 89),
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
            ],
          ),
          const Padding(
>>>>>>> main:DoAn/app_smart_house/lib/view/HomeScreen.dart
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
              child: Column(children: [
                if (lst_devices.isNotEmpty)
                  Column(
                    children: List.generate(
                      lst_devices.length,
                      (index) => DeviceItem(device: lst_devices[index]),
                    ),
                  )
                else
                  const Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        "Không có thiết bị đang hoạt động !",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
