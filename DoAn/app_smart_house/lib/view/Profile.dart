import 'package:app_smart_house/view/BottomMenu.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';

  var stt=8;
  var sexbool=false;
class Profile extends StatefulWidget {
   Profile({super.key,});
   int stt=0;
   bool sexbool=false;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xFF0597F2),
        title: const Text('Trang Cá Nhân'),
      ),
      drawer:const DrawerEditProfile(),
      bottomNavigationBar:const BottomMenu(index: 2),
      body: ListView(
        children: [
          Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          CircleAvatar(
            backgroundImage:const NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&usqp=CAU"),
            radius: 80.0,
            child: Container(
                decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2.0),
              ),
            ),
          ),
            Padding(
              padding:const EdgeInsetsDirectional.all(10),
              child: Container(
            padding:const EdgeInsets.all(5),
            decoration: BoxDecoration(
            border: Border.all(
            color: Colors.black,
            width: 2.0,
           ),
           borderRadius: BorderRadius.circular(10.0),
           ),
            child: const Column(
              children: [
                UserInfoItem(text: 'Tên người dùng:', value: 'Phương  '),
                UserInfoItem(text: 'Tên tài khoản:', value: 'DangPhuong  '),
                UserInfoItem(text: 'Ngày sinh:', value: '11/05/2003  '),
                UserInfoItem(text: 'Mật khẩu:', value: '******  '),
                UserInfoItem(text: 'Số điện thoại:', value: '0123423423  '),
                UserInfoItem(text: 'Email:', value: 'phuong@gmail.com  '),
                UserInfoItem(text: 'Địa chỉ:', value: 'Tỉnh Tiền Giang  '),
                UserInfoItem(text: 'Giới tính:', value: 'Nam  '),
              ],
            ),
          ),),
          
          Column(
        children: [
           Padding(
            padding:const EdgeInsets.all( 10),
            child:  Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.all(5),
                  child: Text("Tài khoản liên kết", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),),
                   Container(
                        width: MediaQuery.of(context).size.width-20,
                        decoration:  BoxDecoration(
                          border: Border.all(width: 2,color: Colors.black),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child:const Padding(padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             ShareInfoItem(text: "Lý Anh Hào"),
                             ShareInfoItem(text: "Lê Hoàng Đệ"),
                             ShareInfoItem(text: "Lê Ngọc Bá Thông"),
                             ShareInfoItem(text: "Nguyễn Thị Cẩm Duyên"),
                             Icon(Icons.add_circle,size: 35,color: Color.fromARGB(255, 148, 236, 151),)
                          ],
                        ),)
                   )
                ],
              )
            ],
          ),),

        ],
      ),
      ],
    ) ,
        ],
      )
        
  );
  }
}
class UserInfoItem extends StatelessWidget {
  final String text;
  final String value;
  const UserInfoItem({super.key, required this.text,required this.value,});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('  $text',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
          const SizedBox(width: 40.0),
          GestureDetector(
            onTap: () {
              if(text=='Tên người dùng:'){
                stt=1;
              }
              else if(text=='Tên tài khoản:'){
                stt=2;
              }
              else if(text=='Ngày sinh:'){
                stt=3;
              }
              else if(text=='Mật khẩu:'){
                stt=4;
              }
              else if(text=='Số điện thoại:'){
                stt=5;
              }
              else if(text=='Email:'){
                stt=6;
              }
              else if(text=='Địa chỉ:'){
                stt=7;
              }
              else if(text=='Giới tính:'){
                stt=8;
              }
              Scaffold.of(context).openDrawer();
            },
            child: Row(children: [
              Text(value,style:const TextStyle(fontSize: 15),),
              const Icon(Icons.edit_square)
            ]),
          ),
        ],
      ),
    );
  }
}

class ShareInfoItem extends StatelessWidget {
  final String text;
  const ShareInfoItem({super.key, required this.text,});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('  $text',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
          const SizedBox(width: 40.0),
          GestureDetector(
            onTap: null,
            child:const Row(children: [
               Icon(Icons.delete_forever,color: Color.fromARGB(255, 245, 142, 135),size: 30,)
            ]),
          ),
        ],
      ),
    );
  }
}

class DrawerEditProfile extends StatefulWidget {
  const DrawerEditProfile({super.key});
  
  @override
  State<DrawerEditProfile> createState() => _DrawerEditProfileState();
}
enum Sex{male,female}
class _DrawerEditProfileState extends State<DrawerEditProfile> {
  @override
  Widget build(BuildContext context) {
    final title=stt==1?const Text("Chỉnh sửa tên người dùng",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),):(stt==2?const Text("Chỉnh sửa tên tài khoản",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)):
              stt==3?const Text("Chỉnh sửa ngày sinh",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)):(stt==4?const Text("Chỉnh sửa mật khẩu",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)):
              stt==5?const Text("Chỉnh sửa số điện thoại",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)):(stt==6?const Text("Chỉnh sửa Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)):
              stt==7?const Text("Chỉnh sửa địa chỉ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)):const Text("Chỉnh sửa giới tính",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)))));
    Sex? _sex=sexbool?Sex.male:Sex.female;          
    return BottomDrawer(

      header: title,
       body: Column(children: [
        const Padding(padding: EdgeInsets.all(10)),
        if(stt==1)
          Column(
            children: [
              TextField(
            decoration: InputDecoration(
              hintText: "Nhập tên người dùng mới",
              border:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton(
                onPressed:() {

                }, 
                child: Text("Xác nhận",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                  shape: MaterialStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))))
                ),
            ],
          )
        else if(stt==2)
          Column(
            children: [
              TextField(
            decoration: InputDecoration(
              hintText: "Nhập tên tài khoản mới",
              border:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton(
                onPressed:() {

                }, 
                child: Text("Xác nhận",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                  shape: MaterialStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))))
                ),
            ],
          )
        else if(stt==3)
          Column(
            children: [
              TextField(
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              hintText: "Nhập ngày sinh mới",
              border:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton(
                onPressed:() {

                }, 
                child: Text("Xác nhận",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                  shape: MaterialStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))))
          ),
            ],
          )
        else if(stt==4)
           Column(
            children: [
               TextField(
            decoration: InputDecoration(
              hintText: "Nhập mật khẩu mới",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          ),
          SizedBox(height: 10),
           TextField(
            decoration: InputDecoration(
              hintText: "Nhập lại mật khẩu mới",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton(
                onPressed:() {

                }, 
                child: Text("Xác nhận",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                  shape: MaterialStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))))
                ),
            ],
          )
        else if(stt==5)
          Column(
            children: [
              TextField(
                keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Nhập số điện thoại mới",
              border:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          ElevatedButton(
                onPressed:() {

                }, 
                child: Text("Xác nhận",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                  shape: MaterialStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))))
                ),
            ],
          )
        else if(stt==6)
          Column(
            children: [
              TextField(
            decoration: InputDecoration(
              hintText: "Nhập Email mới",
              border:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          ),
          ElevatedButton(
                onPressed:() {

                }, 
                child: Text("Xác nhận",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                  shape: MaterialStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))))
                ),
            ],
          )
        else if(stt==7)
          Column(
            children: [
              TextField(
            decoration: InputDecoration(
              hintText: "Nhập địa chỉ mới",
              border:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          ),
          ElevatedButton(
                onPressed:() {

                }, 
                child: Text("Xác nhận",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                  shape: MaterialStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))))
                ),
            ],
          )
        else if(stt==8)
          Column(
            children: [
              RadioListTile<Sex>(
                title:const Text("Nam"),
                value: Sex.male,
                groupValue: _sex,
                onChanged: (Sex? value){
                  setState(() {
                    _sex=value!;
                    sexbool=_sex==Sex.male?true:false;
                  });
                },
              ),
              RadioListTile<Sex>(
                title:const Text("Nữ"),
                value: Sex.female,
                groupValue: _sex,
                onChanged: (Sex? value){
                  setState(() {
                    _sex=value!;
                    sexbool=_sex==Sex.male?true:false;
                  });
                },
              ),
              ElevatedButton(
                onPressed:() {

                }, 
                child: Text("Xác nhận",style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                  shape: MaterialStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(5))))
                ),
            ],
          )
       ]), 
       headerHeight: MediaQuery.of(context).size.height/1.5, 
       drawerHeight: MediaQuery.of(context).size.height/1.5);
  }
}