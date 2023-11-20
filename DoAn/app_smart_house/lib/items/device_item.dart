import 'package:flutter/material.dart';

class DeviceItem extends StatefulWidget {
  const DeviceItem({super.key});

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 215, 230, 236)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.lightbulb_outline, size: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đèn 1",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "Phòng ăn",
                  style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                )
              ],
            ),
            Align(
              widthFactor: MediaQuery.of(context).size.width / 100,
              alignment: AlignmentDirectional.centerEnd,
              child: Switch(
                value: light,
                activeColor: Color(0xFF0597F2),
                onChanged: (bool value) {
                  setState(() {
                    light = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
