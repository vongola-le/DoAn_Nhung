import 'dart:convert';
import 'package:app_smart_house/model/db_user_Reader.dart';

class User {
  int id;
  String img;
  String name;
  String account;
  String date;
  String password;
  String phone;
  String email;
  String address;
  String sex;
  User(this.id,this.img,this.name,this.account,this.date,this.password,this.phone,this.email,this.address,this.sex); 

  User.fromJson(Map<String,dynamic> json)
    :id=json['id'],
    img=json['img'],
    name=json['name'],
    account=json['account'],
    date=json['date'],
    password=json['password'],
    phone=json['phone'],
    email=json['email'],
    address=json['address'],
    sex=json['sex'];
  static List<User> users=[];

  
  static Future<void> loadData() async{
    InforUserReader reader=InforUserReader();
    String data =await reader.getInfor();
    List<dynamic> lst=jsonDecode(data);
    for (var entry in lst){
      users.add(User.fromJson(entry));
    }
  }

}