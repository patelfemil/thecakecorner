import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thecakecorner/BdayCake.dart';
import 'package:thecakecorner/add_to_cart.dart';
import 'package:thecakecorner/home.dart';
import 'package:thecakecorner/loginpage.dart';
import 'package:thecakecorner/vars.dart';
import 'package:thecakecorner/your_account.dart';
import 'package:thecakecorner/your_order.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {


  int bottemIcon = 0;

  late TabController tabController;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController =
        TabController(length: 4, initialIndex: bottemIcon, vsync: this);
    tabController.animation!.addListener(() {
      if (bottemIcon != tabController.animation!.value.round()) {
        setState(() {
          bottemIcon = tabController.animation!.value.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            bottemIcon = value;
            tabController.index = value;
            setState(() {});
          },
          iconSize: 25,
          showSelectedLabels: false,
          elevation: 5,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: bottemIcon == 0 ? Colors.pink : Colors.black,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: bottemIcon == 1 ? Colors.pink : Colors.black,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: bottemIcon == 2 ? Colors.pink : Colors.black,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: bottemIcon == 3 ? Colors.pink : Colors.black,
                ),
                label: 'Account'),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            HomeScreen(),
            YourOrder(),
            AddtoCart(),
            AccountPage(),
          ],
        ));
  }
}
