import 'package:app_smart_house/items/add_device.dart';
import 'package:app_smart_house/items/device_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'infor_device.dart';

class device extends StatelessWidget {
  const device({super.key});
  @override
  Widget build(BuildContext context) {
    List<infor_device> lst_device = List.empty();
    return Scaffold(
        appBar: AppBar(
          title:
              const Align(child: Text("Device"), alignment: Alignment.center),
          shadowColor: const Color.fromRGBO(5, 151, 242, 0),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          children: [
            if (lst_device.isEmpty)
              Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3)),
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
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const add_device()));
                      },
                      child:
                          Text("Add device", style: TextStyle(fontSize: 30))),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const add_device()));
                          },
                          child: Text("Add device")),
                    ],
                  ),
                  // for (int i = 0; i < 5; i++)
                  //   // DeviceItem(name: "đèn $i", room: "khách", light: false)
                ],
              )
          ],
        ));
  }
}
