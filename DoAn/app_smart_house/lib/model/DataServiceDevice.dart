import 'package:app_smart_house/model/deviceData.dart';
import 'package:app_smart_house/model/userdata.dart';
import 'package:firebase_database/firebase_database.dart';


class DatabaseServiceDevice {


  static Future<List<Device>> getDevices() async {
    DataSnapshot snapshot = await FirebaseDatabase.instance
    .ref()
    .child("Device")
    .get();

    List<Device> devices=[];

    List<dynamic> values = snapshot.value as List<dynamic>;

    for(var vl in values) {
      devices.add(Device.fromSnapShot(vl as Map<Object?,Object?>));
    }

    return devices;
  }

  static Future<void> updateData(Device device) async{
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child('Device/${device.id-1}').update({
    "id": device.id,
    "img":device.img ,
    "name":device.name,
    "effect":device.effect,
    "room":device.room,
    "status":device.status,
    "type":device.type,
    "mode":device.mode
  });
  }

  static Future<void> addData(Device device) async{
    final databaseReference = FirebaseDatabase.instance.ref();
     databaseReference.child('Device').push().set({
      "id": device.id,
      "img":device.img ,
      "name":device.name,
      "effect":device.effect,
      "room":device.room,
      "status":device.status,
      "type":device.type,
      "mode":device.mode
     });
  }

}