import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key, required this.name});
  final name;

  @override
  Widget build(BuildContext context) {
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text("30°C"),
                      ],
                    ),
                    Text(
                      "Không có thiết bị nào đang được dùng",
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
