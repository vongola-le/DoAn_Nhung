import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key,required this.index});
  final index;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      selectedItemColor:const Color(0xFF0597F2),
      unselectedItemColor: Colors.black,
      items:const[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          tooltip: "Trang chủ",
          label: "Trang chủ"),
          BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          tooltip: "Tất cả thiết bị",
          label: "Tất cả thiết bị"),
          BottomNavigationBarItem(
          icon: Icon(Icons.person),
          tooltip: "Trang cá nhân",
          label: "Trang cá nhân")
      ],
      onTap: (value) {
        if(value==0){
          //Trang chủ
        }
        else if(value==1){
          //Tất cả thiết bị
        }
        else if(value==2){
          //Trang cá nhân
        }
      }, 
      );
  }
}