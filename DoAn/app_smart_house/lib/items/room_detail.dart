import 'package:app_smart_house/items/device_item.dart';
import 'package:flutter/material.dart';

class RoomDetail extends StatefulWidget {
  const RoomDetail(
      {super.key,
      required this.name,
      this.tem = "",
      this.sl = 0,
      required this.img});
  final name;
  final tem;
  final img;
  final int sl;

  @override
  State<RoomDetail> createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            tooltip: "Thêm thiết bị",
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: ClipRRect(
                child: Image(
                  image: AssetImage(widget.img),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Số thiết bị: ${widget.sl}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.tem == "" ? widget.tem : "Nhiệt độ: ${widget.tem}°C",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thiết bị:",
                    style: TextStyle(fontSize: 20),
                  ),
                  GestureDetector(
                    child: Text(
                      "Mở tất cả",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 106, 189, 228)),
                    ),
                  )
                ],
              ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: 
            //     Column(
            //       children: List.generate(
            //         widget.sl,
            //         (index) => DeviceItem(
            //           name: "Đèn ${index + 1}",
            //           room: "Phòng ăn",
            //           light: true,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
