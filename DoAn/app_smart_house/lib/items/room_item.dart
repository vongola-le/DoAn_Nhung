import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoomItem extends StatelessWidget {
  RoomItem({super.key, required this.name, this.sl = 0, this.tem = ""});
  final name;
  final tem;
  int sl;
  @override
  Widget build(BuildContext context) {
    String tb1 = "Không có thiết bị nào đang được dùng";
    String tb2 = "Có $sl thiết bị đang được sử dụng";

    return GestureDetector(
        child: Container(
      width: MediaQuery.of(context).size.width / 1.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color.fromARGB(255, 215, 230, 236)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage(
                  'assets/img/h1.jpg',
                ),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(tem == "" ? tem : tem + "°C"),
                      ],
                    ),
                    Text(
                      sl != 0 ? tb2 : tb1,
                      style: TextStyle(color: Colors.blueGrey),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
