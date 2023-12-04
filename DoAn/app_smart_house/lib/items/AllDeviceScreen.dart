import 'package:app_smart_house/items/add_device.dart';
import 'package:app_smart_house/items/device_item.dart';
import 'package:app_smart_house/model/DataServiceDevice.dart';
import 'package:app_smart_house/model/deviceData.dart';
import 'package:app_smart_house/view/BottomMenu.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

<<<<<<< HEAD

=======
>>>>>>> main
class AllDevices extends StatefulWidget {
  const AllDevices({super.key});

  @override
  State<AllDevices> createState() => _AllDevicesState();
}

class _AllDevicesState extends State<AllDevices> {
<<<<<<< HEAD
  List<Device> lst_devices=[];
  int newIdDevice=1;

  _setupDevice() async{
     List<Device> deviceData=await DatabaseServiceDevice.getDevices();
     if(mounted){
        setState(() {
          newIdDevice=deviceData[deviceData.length-1].id+1;
          lst_devices=deviceData;
        });
     }
=======
  List<Device> lst_devices = [];
  int newIdDevice = 1;

  _setupDevice() async {
    List<Device> deviceData = await DatabaseServiceDevice.getDevices();
    if (mounted) {
      setState(() {
        newIdDevice = deviceData[deviceData.length - 1].id + 1;
        lst_devices = deviceData;
      });
    }
>>>>>>> main
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupDevice();
  }

<<<<<<< HEAD


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
       _setupDevice();
    });
    return Scaffold(
        appBar: AppBar(
          title:Text("Trang Thiết Bị"),
=======
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      _setupDevice();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text("Trang Thiết Bị"),
>>>>>>> main
          backgroundColor: const Color(0xFF0597F2),
          actions: [
            IconButton(
              tooltip: "Hướng dẫn sử dụng",
<<<<<<< HEAD
              onPressed: () { 
                showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Hướng dẫn thao tác!'),
                    content: Text('- Nhấn giữ vào thiết bị để mở hộp thoại xóa thiết bị.\n- Nhấn 2 lần vào thiết bị để mở hộp thoại thực hiện đổi tên và vị trí của thiết bị'),
                    actions: [
                      TextButton(
                        child: Text('Ok',style: TextStyle(color: Colors.blue,fontSize: 18),),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
=======
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Hướng dẫn thao tác!'),
                      content: Text(
                          '- Nhấn giữ vào thiết bị để mở hộp thoại xóa thiết bị.\n- Nhấn 2 lần vào thiết bị để mở hộp thoại thực hiện đổi tên và vị trí của thiết bị'),
                      actions: [
                        TextButton(
                          child: Text(
                            'Ok',
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
>>>>>>> main
                );
              },
              icon: Icon(
                Icons.help_outline_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
        bottomNavigationBar:const BottomMenu(index: 1),
        body: ListView(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          children: [
            if (lst_devices.isEmpty)
              Column(
                children: [
<<<<<<< HEAD
                  Padding(
                      padding: EdgeInsets.only(
                          top: 20)),
=======
                  Padding(padding: EdgeInsets.only(top: 20)),
>>>>>>> main
                  Icon(
                    Icons.disabled_by_default_outlined,
                    color: Colors.red[100],
                    size: 100,
                  ),
                  Text(
                    'No device',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 10),
                  Text('Click add new device to add device',
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
<<<<<<< HEAD
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> add_device(newIdDevice: newIdDevice,)));
=======
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => add_device(
                                      newIdDevice: newIdDevice,
                                    )));
>>>>>>> main
                      },
                      child:
                          Text("Add device", style: TextStyle(fontSize: 30))
                  ),
                  
                  ],
                )
            else
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All device',
<<<<<<< HEAD
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> add_device(newIdDevice: newIdDevice,)));
=======
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => add_device(
                                          newIdDevice: newIdDevice,
                                        )));
>>>>>>> main
                          },
                          child: Text("Add device")),
                    ],
                  ),
<<<<<<< HEAD
                  for(var value in lst_devices)
                      Column(
                        children: [
                            DeviceItem(device: value,)
                        ],
                      )
=======
                  for (var value in lst_devices)
                    Column(
                      children: [
                        DeviceItem(
                          device: value,
                        )
                      ],
                    )
>>>>>>> main
                ],
              ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Text(
              'All Button',
<<<<<<< HEAD
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
=======
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
>>>>>>> main
            ),
            const Text(
              'Số lượng: 7',
              style: TextStyle(fontSize: 18),
            ),
            Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
<<<<<<< HEAD
                    InforButton(name: "Nút mật khẩu(0)",location: "Cửa chính",function: "Dùng để nhập mật khẩu với giá trị là 0",),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    InforButton(name: "Nút mật khẩu(1)",location: "Cửa chính",function: "Dùng để nhập mật khẩu với giá trị là 1",)
=======
                    InforButton(
                      name: "Nút mật khẩu(0)",
                      location: "Cửa chính",
                      function: "Dùng để nhập mật khẩu với giá trị là 0",
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    InforButton(
                      name: "Nút mật khẩu(1)",
                      location: "Cửa chính",
                      function: "Dùng để nhập mật khẩu với giá trị là 1",
                    )
>>>>>>> main
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
<<<<<<< HEAD
                    InforButton(name: "Nút đèn phòng ăn",location: "Phòng ăn",function: "Dùng để bật/tắt đèn",),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    InforButton(name: "Nút đèn phòng khách",location: "Phòng khách",function: "Dùng để bật/tắt đèn",),
                    
=======
                    InforButton(
                      name: "Nút đèn phòng ăn",
                      location: "Phòng ăn",
                      function: "Dùng để bật/tắt đèn",
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    InforButton(
                      name: "Nút đèn phòng khách",
                      location: "Phòng khách",
                      function: "Dùng để bật/tắt đèn",
                    ),
>>>>>>> main
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
<<<<<<< HEAD
                    InforButton(name: "Nút đèn WC",location: "WC",function: "Dùng để bật/tắt đèn",),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    InforButton(name: "Nút đèn phòng ngủ",location: "Phòng ngủ",function: "Dùng để bật/tắt đèn và tăng giảm độ sáng đèn",)
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                InforButton(name: "Nút khẩn cấp",location: "Phòng khách",function: "Dùng để bật/tắt toàn bộ đèn hoặc bật chế độ báo động làm chớp nháy toàn bộ đèn",width: false,),
=======
                    InforButton(
                      name: "Nút đèn WC",
                      location: "WC",
                      function: "Dùng để bật/tắt đèn",
                    ),
                    Padding(padding: EdgeInsets.only(left: 5)),
                    InforButton(
                      name: "Nút đèn phòng ngủ",
                      location: "Phòng ngủ",
                      function: "Dùng để bật/tắt đèn và tăng giảm độ sáng đèn",
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                InforButton(
                  name: "Nút khẩn cấp",
                  location: "Phòng khách",
                  function:
                      "Dùng để bật/tắt toàn bộ đèn hoặc bật chế độ báo động làm chớp nháy toàn bộ đèn",
                  width: false,
                ),
>>>>>>> main
                Padding(padding: EdgeInsets.only(top: 20)),
              ],
            )
          ],
        ));
  }
}

<<<<<<< HEAD

class InforButton extends StatelessWidget {
   InforButton({super.key,required this.function,required this.location,required this.name,this.width=true});
=======
class InforButton extends StatelessWidget {
  InforButton(
      {super.key,
      required this.function,
      required this.location,
      required this.name,
      this.width = true});
>>>>>>> main
  String name;
  String location;
  String function;
  bool width;

  @override
  Widget build(BuildContext context) {
    return Padding(
<<<<<<< HEAD
      padding: EdgeInsets.all(0),
      child: Container(
        width: width?MediaQuery.of(context).size.width/2-10:MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 215, 230, 236)),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.radio_button_on_outlined, size: 50),
                    Padding(padding: EdgeInsets.only(left: 5),
                        child: Container(
                          width: width?MediaQuery.of(context).size.width/2-80:MediaQuery.of(context).size.width-80,
                          height: width?140:null,
                          child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text(
                          name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          location,
                          style:
                              TextStyle(fontSize: 15, color: Colors.blueGrey),
                        ),
                         Text("Chức năng: $function",style: TextStyle(fontSize: 15),),
                        
                        ]),),)
                        
                  ],
                  
                ),
                
                ]
                )
                )
                )
                );
  }
}

=======
        padding: EdgeInsets.all(0),
        child: Container(
            width: width
                ? MediaQuery.of(context).size.width / 2 - 10
                : MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 215, 230, 236)),
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.radio_button_on_outlined, size: 50),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Container(
                              width: width
                                  ? MediaQuery.of(context).size.width / 2 - 80
                                  : MediaQuery.of(context).size.width - 80,
                              height: width ? 140 : null,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      location,
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blueGrey),
                                    ),
                                    Text(
                                      "Chức năng: $function",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ]))));
  }
}
>>>>>>> main
