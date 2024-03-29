import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:thecakecorner/vars.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? imgPath;
  String? cameraPath;
  File? image;
  String url = '';

  bool enable = false;

  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userInfo['emailAddress'] != null) {
      email.text = userInfo['emailAddress'];
    }
    name.text = userInfo['full_name'];
    mobileNumber.text = userInfo['mobile_Number'];
    if (userInfo['address'] != null) {
      address.text = userInfo['address'];
    }
    if (userInfo['userPhoto'] != null) {
      url = userInfo['userPhoto'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  url != ""
                      ? ClipRRect(
                          child: Image.network(url, height: 180, width: 180),
                          borderRadius: BorderRadius.circular(90),
                        )
                      : ClipRRect(
                          child: Image.asset("assets/img/add-image_5007662.png",
                              height: 180, width: 180),
                          borderRadius: BorderRadius.circular(90),
                        ),
                  Positioned(
                    top: 120,
                    left: 120,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                        onPressed: () {
                          showSheet(context);
                        },
                        icon: Icon(Icons.camera_alt),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    hintText: userInfo['full_name'] ?? '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: mobileNumber,
                decoration: InputDecoration(
                    hintText: userInfo['mobile_Number'] ?? '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Email Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: address,
                decoration: InputDecoration(
                    hintText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(userInfo['id'])
                        .update({
                      'userPhoto': url,
                      'mobile_Number': mobileNumber.text,
                      'full_name': name.text,
                      'emailAddress': email.text,
                      'address': address.text,
                    }).then((value) async {
                      DocumentSnapshot<Map<String, dynamic>> users =
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(userInfo['id'])
                              .get();
                      if (users.exists) {
                        userInfo = users.data()!;
                        userInfo['id'] = users.id;
                        debugPrint(userInfo.toString());
                        Navigator.pop(context);
                      }
                    });
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  showSheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(10),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black26,
          //         blurRadius: 5.0,
          //         spreadRadius: 2.0,
          //         // blurStyle: BlurStyle.outer
          //         // offset: Offset(1,0),
          //       ),
          //     ]),
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5,
                    width: 50,
                    // padding: EdgeInsets.only(left: 50),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "Cake Photo",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        size: 25,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                          onPressed: () async {
                            final picker = ImagePicker();
                            final XFile? camera = await picker.pickImage(
                                source: ImageSource.camera);

                            cameraPath = camera?.path;
                            setState(() {});
                          },
                          icon: Icon(Icons.camera_alt),
                        ),
                      ),
                      Text("Camera"),
                    ],
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(30)),
                        child: IconButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            XFile? picked = await picker.pickImage(
                                source: ImageSource.gallery);

                            if (picked != null) {
                              image = File(picked.path);
                              uploadFile(context);
                            }
                          },
                          icon: Icon(Icons.photo),
                        ),
                      ),
                      Text("Gallery"),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  Future uploadFile(context) async {
    if (image == null) return "";
    final fileName = basename(image!.path);
    final destination = 'Image/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(image!);
      url = await ref.getDownloadURL();
      setState(() {});
      Navigator.pop(context);
      return url;
    } catch (e) {
      debugPrint('error occurred');
      return "";
    }
  }
}
