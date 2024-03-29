import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5.0,
        title: Text("Forgot Password",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 40),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.email, size: 25),
                      onPressed: ()  {}
                  ),
                  Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Enter your email address", border: InputBorder.none),
                      )),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Text("• We will send you a message to set or reset your new Password",style: TextStyle(fontSize: 13),),
            SizedBox(height: 15,),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Sent",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
