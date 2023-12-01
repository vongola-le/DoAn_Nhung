import 'package:app_smart_house/model/userdata.dart';
import 'package:firebase_database/firebase_database.dart';


class DatabaseServiceUser {

  static Future<List<User2>> getUsers() async {
   DataSnapshot  snapshot = await FirebaseDatabase.instance
  .ref()
  .child("Users")
  .get(); // to debug and see if data is returned

    List<User2> users=[];

    List<dynamic> values = snapshot.value as List<dynamic>;

    for(var vl in values) {
      users.add(User2.fromSnapShot(vl as Map<String,dynamic>));
    }

    return users;
  }
}