import 'package:flutter/material.dart';
import 'package:thecakecorner/edit_profile.dart';
import 'package:thecakecorner/vars.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});



  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink,
        elevation: 0,
        title: Text("My Account",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Personal details",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(),
                            )).then((value) {
                          setState(() {});
                        });
                      },
                      child: Text("Edit")),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 1.5,
                        blurStyle: BlurStyle.inner,
                      )
                    ]),
                child: Row(
                  children: [
                    userInfo['userPhoto'] != null
                        ? ClipRRect(
                            child: Image.network(userInfo['userPhoto'] ?? '',
                                height: 150),
                          )
                        : ClipRRect(
                            child: Image.asset(
                                'assets/img/add-image_5007662.png'??'',
                                height: 150),
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userInfo['full_name'] ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15)),
                        SizedBox(
                          height: 15,
                        ),
                        userInfo['emailAddress'] != null
                            ? Text(userInfo['emailAddress'] ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 10))
                            : Text("Email Address??",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15)),
                        SizedBox(
                          height: 15,
                        ),
                        Text(userInfo['mobile_Number'] ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15)),
                        SizedBox(
                          height: 15,
                        ),
                        userInfo['address'] != null
                            ? Text(userInfo['address'] ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15))
                            : Text("Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  items(
                      icons: Icons.bookmark_border,
                      text: "Bookmarks",
                      onTap: () {}),
                  SizedBox(
                    width: 7,
                  ),
                  items(
                      icons: Icons.notifications,
                      text: "Notification",
                      onTap: () {}),
                  SizedBox(
                    width: 7,
                  ),
                  items(icons: Icons.settings, text: "Settings", onTap: () {}),
                  SizedBox(
                    width: 7,
                  ),
                  items(icons: Icons.payment, text: "Payments", onTap: () {}),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              details(text: 'Your Orders', onTap: () {}),
              SizedBox(
                height: 15,
              ),
              details(text: 'Feedback & Refunds', onTap: () {}),
              SizedBox(
                height: 15,
              ),
              details(text: 'Help', onTap: () {}),
              SizedBox(
                height: 15,
              ),
              Text("Send Feedback",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 10,
              ),
              Text("Report an Emergency",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 10,
              ),
              Text("Rate us on the Play Store",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 10,
              ),
              Text("Log Out",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black26),
                    boxShadow: [
                      // BoxShadow(
                      //   color: Colors.white,
                      //   blurRadius: 2,
                      //   blurStyle: BlurStyle.outer,
                      //   spreadRadius: 5,
                      // )
                    ]),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.info), Text("About")],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget items({required icons, required String text, Function? onTap}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 2,
              blurRadius: 2,
              // blurStyle: BlurStyle.inner
            )
          ]),
      child: Column(
        children: [

          Icon(icons as IconData?, size: 20),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    ),
  );
}

Widget details({required String text, Function? onTap}) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black26),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        Spacer(),
        Icon(Icons.chevron_right)
      ],
    ),
  );
}
