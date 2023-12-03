import 'package:app_smart_house/items/sign_in.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HD_Screen extends StatelessWidget {
  const HD_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Picture(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Picture extends StatefulWidget {
  const Picture({super.key});

  @override
  State<Picture> createState() => _TrangThaiState();
}

class _TrangThaiState extends State<Picture> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        backgroundColor: Colors.transparent,
        child: const Text(
          'SKIP',
          style: TextStyle(color: Colors.cyan, fontSize: 18),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/h1.jpg', fit: BoxFit.cover),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/h2.jpg', fit: BoxFit.cover),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/h3.jpg', fit: BoxFit.cover),
                ),
              ],
              options: CarouselOptions(
                initialPage: 0,
                viewportFraction: 2.0,
                enableInfiniteScroll: false,
                reverse: false,
                enlargeCenterPage: true,
                enlargeFactor: 0,
                scrollDirection: Axis.horizontal,
                height: MediaQuery.of(context).size.height - 30,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Số lượng slides
                (index) => buildDot(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.cyan : Colors.grey,
        ),
      ),
    );
  }
}
