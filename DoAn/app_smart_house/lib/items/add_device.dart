import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'AllDeviceScreen.dart';

class add_device extends StatefulWidget {
  add_device({super.key});

  @override
  State<add_device> createState() => _add_deviceState();
}

class _add_deviceState extends State<add_device> {
  List<Station> stations = [
    Station(
      Image.asset(
        "assets/img/lamp.jpg",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      'lamp',
    ),
    Station(
      Image.asset(
        "assets/img/signal.jpg",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      'signal',
    ),
    Station(
      Image.asset(
        "assets/img/siren.jpg",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      'siren',
    ),
    Station(
      Image.asset(
        "assets/img/speaker.jpg",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      'speaker',
    ),
    Station(
      Image.asset(
        "assets/img/tv.jpg",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      'tv',
    ),
    Station(
      Image.asset(
        "assets/img/fan.jpg",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      'fan',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Align(child: Text("Add device"), alignment: Alignment.center),
        shadowColor: const Color.fromRGBO(5, 151, 242, 0),
      ),
      body: Container(
        color: Color.fromARGB(255, 244, 244, 243),
        child: GridView.count(
          childAspectRatio: 1.5,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: stations.map((item) {
            return StationItem(item: item);
          }).toList(),
        ),
      ),
    );
  }
}

class StationItem extends StatefulWidget {
  const StationItem({Key? key, required this.item}) : super(key: key);
  final Station item;

  @override
  State<StationItem> createState() => _StationItemState();
}

class _StationItemState extends State<StationItem> {
  final bool tt = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var inkWell = InkWell(
      onTap: () {
        // chuyen trang khi click vao

        print('Clicked ${widget.item.name}');
        openDialog(context);
      },
      splashColor: Colors.yellow,

      //child: Card(
      child: Expanded(
        child: Container(
          color: Colors.white,
          alignment: Alignment.topLeft,
          child: Column(children: [
            SizedBox(height: 10),
            widget.item.img,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.item.name,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      //),
    );
    return inkWell;
  }

  Future openDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Tên thiết bị'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter your name'),
            controller: controller,
          ),
          actions: [
            TextButton(
              child: Text('ADD'),
              onPressed: () {
                add;
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            )
          ],
        ),
      );
  void add(BuildContext context) {
    Navigator.of(context).pop(controller.text);
  }
}

class Station {
  Image img;
  String name;
  Station(this.img, this.name);
}
