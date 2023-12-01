class User2 {
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

  User2({required this.id,required this.img,required this.name,required this.account,required this.date,required this.password,required this.phone,required this.email,required this.address,required this.sex}); 

  User2.fromSnapShot(Map<String,dynamic> js):
    id=js["id"] ,
    img=js["img"],
    name= js["name"],
    account= js["account"],
    date= js["date"],
    password= js["password"],
    phone= js["phone"],
    email= js["email"],
    address= js["address"],
    sex= js["sex"];

    toJson(){
      return{
        "id": id,
        "img":img ,
        "name":name,
        "account": account,
        "date": date,
        "password": password,
        "phone": phone,
        "email": email,
        "address": address,
        "sex": sex,
      };
    }
}
