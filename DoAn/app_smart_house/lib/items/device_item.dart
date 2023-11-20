import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeviceItem extends StatefulWidget {
  DeviceItem(
      {super.key, required this.name, required this.room, required this.light});
  final name;
  final room;
  bool light;

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 215, 230, 236)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
          child: Row(
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
                          widget.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.room,
                          style:
                              TextStyle(fontSize: 15, color: Colors.blueGrey),
                        )
                      ],
                    )
                  ],
                ),
                Switch(
                  value: widget.light,
                  activeColor: Color(0xFF0597F2),
                  onChanged: (bool value) {
                    setState(() {
                      widget.light = value;
                    });
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
