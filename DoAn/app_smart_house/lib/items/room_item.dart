import 'package:flutter/material.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color.fromARGB(255, 215, 230, 236)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: AssetImage(
                  'assets/img/h1.jpg',
                ),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width / 2.2,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Row(
                children: [Text("ASC")],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
