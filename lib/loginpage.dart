import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:thecakecorner/HomePage.dart';
import 'package:thecakecorner/forgotpassword.dart';
import 'package:thecakecorner/vars.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoadervisible = false;

  TextEditingController fName = TextEditingController();
  TextEditingController mNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  // TextEditingController fName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                        // blurStyle: BlurStyle.outer
                        // offset: Offset(1,0),
                      ),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                      ),
                      child: Image.asset("assets/img/cake.png",
                          height: 120, width: 150),
                    ),
                    TabBar(
                        labelStyle: TextStyle(color: Colors.black),
                        unselectedLabelStyle: TextStyle(color: Colors.black38),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.pink,
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                        tabs: [
                          Tab(
                            child: Text("Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            // text: "Login",
                          ),
                          Tab(
                            child: Text("Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            // text: "Sign up",
                          )
                        ]),
                  ],
                ),
              ),
              Container(
                height: 1000,
                child: TabBarView(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: mNumber,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your Mobile Number";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Mobile Number or email adddress",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPassword(),
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Forgot Password?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                              onTap: () async {
                                isLoadervisible = true;
                                setState(() {});
                                QuerySnapshot users = await FirebaseFirestore
                                    .instance
                                    .collection("users")
                                    .where('mobile_Number',
                                        isEqualTo: mNumber.text)
                                    .where('password', isEqualTo: password.text)
                                    .get();
                                isLoadervisible = false;
                                setState(() {});
                                if (users.docs.isNotEmpty) {
                                  userInfo = users.docs[0].data()
                                      as Map<String, dynamic>;
                                  userInfo['id'] = users.docs[0].id;
                                  box.write('isLogin', true);
                                  box.write("userDetails", userInfo);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Invalid Mobile Number and Password")));
                                }
                              },
                              child: !isLoadervisible
                                  ? Container(
                                height: 60,
                                      // padding: EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.pinkAccent,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Login",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    )
                                  : Container(
                                height: 60,
                                // padding: EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(
                                          color: Colors.pinkAccent,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            backgroundColor: Colors.black26,
                                            valueColor: AlwaysStoppedAnimation(Colors.white),
                                            strokeWidth: 5,
                                          ),
                                        ],
                                      ),
                                    )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "or",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 60),
                              leading: Image.asset(
                                  "assets/img/facebook_889102.png",
                                  height: 30),
                              title: Text("Login with Facebook",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 1.0,
                                      spreadRadius: 1.5,
                                      offset: Offset(1, 0))
                                ]),
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 65),
                              leading: Image.asset("assets/img/google.png",
                                  height: 30),
                              title: Text("Login with Google",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black26),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 2.0,
                                        spreadRadius: 1.0)
                                  ]
                                  // borderRadius: BorderRadius.circular(10)
                                  ),
                              child: Image.asset(
                                "assets/img/google.png",
                                width: 35,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black26),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 2.0,
                                        spreadRadius: 1.0)
                                  ]
                                  // borderRadius: BorderRadius.circular(10)
                                  ),
                              child: Image.asset(
                                "assets/img/fb.png",
                                width: 35,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: fName,
                          decoration: InputDecoration(
                              hintText: "Full Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: mNumber,
                          decoration: InputDecoration(
                              hintText: "Mobile Number or email adddress",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: password,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove_red_eye)),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove_red_eye)),
                              hintText: "Confirm Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                signUp();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0,
                                          offset: Offset(0, 2))
                                    ],
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Container(
                              width: 65,
                              height: 55,
                              child: Text(
                                "Already a member? Login",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final box = GetStorage();
  signUp() {
    FirebaseFirestore.instance.collection("users").add({
      'full_name': fName.text,
      'mobile_Number': mNumber.text,
      'password': password.text,
    });
  }
}
