import 'package:app_smart_house/items/AllDeviceScreen.dart';
import 'package:app_smart_house/model/DataServiceDevice.dart';
import 'package:app_smart_house/model/deviceData.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeviceItem extends StatefulWidget {
  DeviceItem(
      {super.key, required this.device});
  Device device;

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  @override
  Widget build(BuildContext context) {
    double effect=widget.device.effect.toDouble();
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 215, 230, 236)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
          child: Column(children: [
            if(widget.device.type==0)
              Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outlined, size: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.device.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.device.room,
                          style:
                              TextStyle(fontSize: 15, color: Colors.blueGrey),
                        )
                      ],
                    )
                  ],
                ),
                Switch(
                  value: widget.device.status==0?false:true,
                  activeColor: Color(0xFF0597F2),
                  onChanged: (bool value) {
                    setState(() {
                      widget.device.status = value?1:0;
                    });
                    DatabaseServiceDevice.updateData(widget.device);
                  },
                ),
                  
              ]),
            if(widget.device.type==1)
              Column(
                children: [
                  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outlined, size: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.device.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.device.room,
                          style:
                              TextStyle(fontSize: 15, color: Colors.blueGrey),
                        )
                      ],
                    )
                  ],
                ),
                Text("Độ sáng: ${effect.toString()}",),
                Switch(
                  value: widget.device.status==0?false:true,
                  activeColor: Color(0xFF0597F2),
                  onChanged: (bool value) {
                    setState(() {
                      widget.device.status = value?1:0;
                    });
                    DatabaseServiceDevice.updateData(widget.device);
                  },
                ),
                  
              ]),
              Slider(
                    value:widget.device.effect.toDouble(),
                    min: 0,
                    max: 255,
                    divisions: 30,
                    label: widget.device.effect.toDouble().toString(),
                    activeColor: Colors.purple,
                    inactiveColor: Colors.amber,
                    onChanged: (value) {
                      setState(() {
                        widget.device.effect = value.toInt();
                        effect=value;
                      });
                      DatabaseServiceDevice.updateData(widget.device);
                    }
                  )
                ],
              )
          ],)
        ),
      ),
    );
  }
}
