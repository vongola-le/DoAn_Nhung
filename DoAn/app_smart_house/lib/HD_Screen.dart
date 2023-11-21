import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HD_Screen extends StatefulWidget {
  const HD_Screen({super.key});

  @override
  State<HD_Screen> createState() => _HD_ScreenState();
}

class _HD_ScreenState extends State<HD_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(100, 5, 151, 242),
        child:const  Text('S K I P',style: TextStyle(color: Colors.white),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/h1.jpg',fit: BoxFit.cover),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/h2.jpg',fit: BoxFit.cover),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/img/h3.jpg',fit: BoxFit.cover),
                ),
              ],
              options: CarouselOptions(
                  initialPage: 0,
                  height: MediaQuery.of(context).size.height,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: null,
                  scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}