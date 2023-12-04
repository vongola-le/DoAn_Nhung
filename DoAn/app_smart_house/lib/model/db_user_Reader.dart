import 'package:flutter/services.dart';

<<<<<<< HEAD
class InforUserReader{
  Future<String> getInfor() async{
    String s="";
    try{
      s=await rootBundle.loadString('assets/data/user.json');
      return (s);
    }catch (e){
      return e.toString();
    }
  }
}
=======
class InforUserReader {
  Future<String> getInfor() async {
    String s = "";
    try {
      s = await rootBundle.loadString('assets/data/user.json');
      return (s);
    } catch (e) {
      return e.toString();
    }
  }
}
>>>>>>> main
