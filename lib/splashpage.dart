import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thecakecorner/HomePage.dart';
import 'package:thecakecorner/loginpage.dart';
import 'package:thecakecorner/vars.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(70),
          child: Image.asset(
            "assets/img/cake.png",
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        bool isLogin = GetStorage().read('isLogin')??false;
        debugPrint(isLogin.toString());
        if(isLogin){
          userInfo = GetStorage().read('userDetails');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        }else{
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        }
      },
    );
  }
}
