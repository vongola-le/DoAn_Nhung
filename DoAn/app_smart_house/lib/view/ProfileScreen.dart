import 'package:app_smart_house/model/user.dart';
import 'package:app_smart_house/view/BottomMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({
    super.key,
    // Truyền ID người dùng vào đây
    // required this.id
  });
  int id = 1;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Users> lst_users = [];
  Users user = Users(0, "", "", "", "", "", "", "", "", "");
  @override
  void initState() {
    super.initState();
    Users.loadData().then((value) {
      setState(() {
        lst_users = Users.users;
        for (var us in lst_users) {
          if (us.id == widget.id) {
            user = us;
          }
        }
      });
    });
  }

  // sign user out method
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF5BA9D9),
          title: const Text('Trang Cá Nhân'),
        ),
        bottomSheet: null,
        body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                CircleAvatar(
                  backgroundImage: NetworkImage((user.img != ""
                      ? user.img
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOH2aZnIHWjMQj2lQUOWIL2f4Hljgab0ecZQ&usqp=CAU")),
                  radius: 80.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(10),
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: UserInfoItem(user: user)),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(5),
                                child: Text("Tài khoản liên kết",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25)),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ShareInfoItem(text: "Lý Anh Hào"),
                                        ShareInfoItem(text: "Lê Hoàng Đệ"),
                                        ShareInfoItem(text: "Lê Ngọc Bá Thông"),
                                        ShareInfoItem(
                                            text: "Nguyễn Thị Cẩm Duyên"),
                                        Icon(
                                          Icons.add_circle,
                                          size: 35,
                                          color: Color.fromARGB(
                                              255, 148, 236, 151),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: signOut,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Color.fromARGB(255, 252, 77, 77),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class UserInfoItem extends StatefulWidget {
  UserInfoItem({super.key, required this.user});
  Users user;

  @override
  State<UserInfoItem> createState() => _UserInfoItemState();
}

enum Sex { male, female, unknow }

class _UserInfoItemState extends State<UserInfoItem> {
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');
  final _user = FirebaseAuth.instance.currentUser!;
  String _Address = '';
  String _Birthday = '';
  String _Email = '';
  String _Name = '';
  String _Password = '';
  String _Phone = '';
  String _Sex = '';

  Future<void> getData() async {
    QuerySnapshot querySnapshot;

    try {
      querySnapshot =
          await _collectionRef.where('Email', isEqualTo: _user.email).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          print('Document data: ${doc.data()}');
          var data = doc.data() as Map<String, dynamic>;
          var address = data?['Address'];
          var birthday = data?['Birthday'];
          var email = data?['Email'];
          var name = data?['Name'];
          var pass = data?['Password'];
          var phone = data?['Phone'];
          var sex = data?['Sex'];

          setState(() {
            _Address = address;
            _Birthday = birthday;
            _Email = email;
            _Name = name;
            _Password = pass;
            _Phone = phone;
            _Sex = sex;
          });
        }
      } else {
        print('Document does not exist on the database');
      }
    } catch (e) {
      print(e);
    }
  }

  void _modalBottomSheetMenu(int stt) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          Sex? _sex = widget.user.sex == ""
              ? Sex.unknow
              : (widget.user.sex == "Nam" ? Sex.male : Sex.female);
          return Column(children: [
            if (stt == 1)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập tên người dùng mới",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          child: const Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ))
            else if (stt == 2)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập tên tài khoản mới",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 3)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                            hintText: "Nhập ngày sinh mới",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 4)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập mật khẩu mới",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập lại mật khẩu mới",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 5)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Nhập số điện thoại mới",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 6)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập Email mới",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 7)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập địa chỉ mới",
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
            else if (stt == 8)
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      RadioListTile<Sex>(
                        title: const Text("Nam"),
                        value: Sex.male,
                        groupValue: _sex,
                        onChanged: (Sex? value) {
                          setState(() {
                            _sex = value!;
                          });
                        },
                      ),
                      RadioListTile<Sex>(
                        title: const Text("Nữ"),
                        value: Sex.female,
                        groupValue: _sex,
                        onChanged: (Sex? value) {
                          setState(() {
                            _sex = value!;
                          });
                        },
                      ),
                      RadioListTile<Sex>(
                        title: const Text("Không rõ"),
                        value: Sex.unknow,
                        groupValue: _sex,
                        onChanged: (Sex? value) {
                          setState(() {
                            _sex = value!;
                          });
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Xác nhận",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color(0xFF0597F2)),
                              shape: MaterialStatePropertyAll(
                                  BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5))))),
                    ],
                  ))
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tên người dùng:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(1);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.name,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tên tài khoản:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(2);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.account,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ngày sinh:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(3);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.date,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Mật khẩu:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(4);
                  },
                  child: Row(children: [
                    Text(
                      "************",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Số điện thoại:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(5);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.phone,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Email:${_user.email}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(6);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.email,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Địa chỉ:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(7);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.address,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Giới tính:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 40.0),
                GestureDetector(
                  onTap: () {
                    _modalBottomSheetMenu(8);
                  },
                  child: Row(children: [
                    Text(
                      widget.user.sex,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Icon(Icons.edit_square)
                  ]),
                ),
              ],
            ),
          ],
        ));
  }
}

class ShareInfoItem extends StatelessWidget {
  final String text;
  const ShareInfoItem({
    super.key,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('  $text',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(width: 40.0),
          GestureDetector(
            onTap: null,
            child: const Row(children: [
              Icon(
                Icons.delete_forever,
                color: Color.fromARGB(255, 245, 142, 135),
                size: 30,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
