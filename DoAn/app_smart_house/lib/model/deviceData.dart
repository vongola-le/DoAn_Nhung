class Device {
   int id;
   int effect;
   String name;
   String img;
   String room;
   int status;
   int type;
   int mode;

  Device({required this.id,required this.img,required this.name,required this.effect,required this.room,required this.status,required this.type,required this.mode}); 

  Device.fromSnapShot(Map<Object?,Object?> js):
    id=int.parse( js["id"].toString()) ,
    img=js["img"].toString(),
    name= js["name"].toString(),
    effect=int.parse(js["effect"].toString()),
    room=js["room"].toString(),
    status=int.parse(js["status"].toString()),
    type=int.parse(js["type"].toString()),
    mode=int.parse(js["mode"].toString());

    toJson(){
      return{
        "id": id,
        "img":img ,
        "name":name,
        "effect":effect,
        "room":room,
        "status":status,
        "type":type,
        "mode":mode
      };
    }
}