import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thecakecorner/BdayCake.dart';
import 'package:thecakecorner/add_to_cart.dart';
import 'package:thecakecorner/loginpage.dart';
import 'package:thecakecorner/vars.dart';
import 'package:thecakecorner/your_account.dart';
import 'package:thecakecorner/your_order.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> cakeList = [
    "assets/img/cake1.jpg",
    "assets/img/cake2.jpg",
    "assets/img/cake3.jpg",
    "assets/img/cake4.jpg",
  ];


  int slideIndex = 0;
  bool enable = true;
  final box = GetStorage();
  int bottemIcon = 0;

  @override
  void initState() {
    // TODO: implement initState
    getProduct();
    getcategory();
    super.initState();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      enable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 5,
        title: Text("The Cake Corner",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        actions: [
          // Image.asset('assets/img/msg.jpg',width: 50,)
          IconButton(
              splashRadius: 20,
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => LoginView(),
                //     ));
              },
              icon: Icon(Icons.message))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              child: ListTile(
                  title: Text("Home"),
                  leading: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 25,
                  )),
            ),
            ListTile(
                title: Text("Offers"),
                leading: Icon(
                  Icons.local_offer,
                  color: Colors.black,
                  size: 25,
                )),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddtoCart(),
                    ));
              },
              child: ListTile(
                  title: Text("Cart"),
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 25,
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountPage(),
                    ));
              },
              child: ListTile(
                  title: Text("Account"),
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 25,
                  )),
            ),
            ListTile(
                title: Text("Saved Address"),
                leading: Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 25,
                )),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YourOrder(),
                    ));
              },
              child: ListTile(
                  title: Text("Your Orders"),
                  leading: Icon(
                    Icons.refresh,
                    color: Colors.black,
                    size: 25,
                  )),
            ),
            ListTile(
                title: Text("Notifications"),
                leading: Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 25,
                )),
            ListTile(
                title: Text("Settings"),
                leading: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 25,
                )),
            ListTile(
                title: Text("Bookmarks"),
                leading: Icon(
                  Icons.bookmark,
                  color: Colors.black,
                  size: 25,
                )),
            ListTile(
                title: Text("Help"),
                leading: Icon(
                  Icons.help,
                  color: Colors.black,
                  size: 25,
                )),
            Divider(
              color: Colors.black,
              indent: 10,
              endIndent: 10,
            ),
            InkWell(
              onTap: () {
                box.write('isLogin', false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              child: ListTile(
                  title: Text("Log out"),
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 25,
                  )),
            ),
          ],
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 0.90,
                      enlargeCenterPage: true,
                      onPageChanged: (index, context) {
                        setState(() {
                          slideIndex = index;
                        });
                      },
                      autoPlay: true,
                    ),
                    items: List.generate(cakeList.length, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(cakeList[index],
                                fit: BoxFit.cover, width: double.maxFinite)),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 15,
                    width: 100,
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(2),
                          child: Container(
                            width: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == slideIndex
                                  ? Colors.pink
                                  : Colors.black26,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    // width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: categoryList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BdayPage(
                                          category: categoryList[index]["Name"],
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      categoryList[index]['Photo'] ?? '',
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  categoryList[index]["Name"] ?? '',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 450,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(15.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: Color(0xFFFDF9EA),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  // spreadRadius: 1,
                                  blurRadius: 2)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Looking for Celebration?",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Here's what you might like to enjoy",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox();
                          },
                          itemCount: ProductList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 25),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 1.0,
                                      spreadRadius: 1.0,
                                    )
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 150,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    width: double.maxFinite,
                                    child: Image.network(
                                      "${ProductList[index]['CPhoto']}",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("${ProductList[index]['cName']}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                    "${ProductList[index]['cFlavor']}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      child: Text('Add to cart',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15)),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.pink,
                                          textStyle:
                                              TextStyle(color: Colors.white)),
                                      onPressed: () {
                                        if (ProductList[index]['selectPrice'] !=
                                            "") {
                                          FirebaseFirestore.instance
                                              .collection("AddCart")
                                              .add(
                                            {
                                              "productId": ProductList[index]
                                                  ['id'],
                                              "image": ProductList[index]
                                                  ['CPhoto'],
                                              "name": ProductList[index]
                                                  ['cName'],
                                              "flavor": ProductList[index]
                                                  ['cFlavor'],
                                              "price": ProductList[index]
                                                  ['selectPrice'],
                                              "userId": userInfo['id'],
                                            },
                                          ).then((value) {
                                            debugPrint("Success");
                                          }).onError((error, stackTrace) {
                                            debugPrint("Failed");
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please select your Quantity and Peice")));
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('The Cake Corner Special items',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Most popular Cheesecake around you",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text("ALL",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54)),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox();
                      },
                      itemCount: ProductList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ProductList[index]['Categories'] == "Cheese Cake"
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 25),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                width: 250,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                      )
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 150,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: double.maxFinite,
                                      child: Image.network(
                                        "${ProductList[index]['CPhoto']}",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("${ProductList[index]['cName']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                      "${ProductList[index]['cFlavor']}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (ProductList[index]
                                                      ['selectPrice'] ==
                                                  ProductList[index]['price']
                                                      ['250']) {
                                                ProductList[index]
                                                    ['selectPrice'] = "";
                                              } else {
                                                ProductList[index]
                                                        ['selectPrice'] =
                                                    ProductList[index]['price']
                                                        ['250'];
                                              }

                                              setState(() {});
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    color: ProductList[index][
                                                                'selectPrice'] ==
                                                            ProductList[index]
                                                                ['price']['250']
                                                        ? Colors.pink
                                                        : Colors.white,
                                                    border: Border.all(
                                                        color: Colors.black26),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "250 Gm",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "\₹ ${ProductList[index]['price']['250']}",
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (ProductList[index]
                                                      ['selectPrice'] ==
                                                  ProductList[index]['price']
                                                      ['500']) {
                                                ProductList[index]
                                                    ['selectPrice'] = "";
                                              } else {
                                                ProductList[index]
                                                        ['selectPrice'] =
                                                    ProductList[index]['price']
                                                        ['500'];
                                              }

                                              setState(() {});
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: ProductList[index]
                                                              ['selectPrice'] ==
                                                          ProductList[index]
                                                              ['price']['500']
                                                      ? Colors.pink
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "500 Gm",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "\₹ ${ProductList[index]['price']['500']}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (ProductList[index]
                                                      ['selectPrice'] ==
                                                  ProductList[index]['price']
                                                      ['750']) {
                                                ProductList[index]
                                                    ['selectPrice'] = "";
                                              } else {
                                                ProductList[index]
                                                        ['selectPrice'] =
                                                    ProductList[index]['price']
                                                        ['750'];
                                              }

                                              setState(() {});
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: ProductList[index]
                                                              ['selectPrice'] ==
                                                          ProductList[index]
                                                              ['price']['750']
                                                      ? Colors.pink
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "750 Gm",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "\₹ ${ProductList[index]['price']['750']}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (ProductList[index]
                                                      ['selectPrice'] ==
                                                  ProductList[index]['price']
                                                      ['1']) {
                                                ProductList[index]
                                                    ['selectPrice'] = "";
                                              } else {
                                                ProductList[index]
                                                        ['selectPrice'] =
                                                    ProductList[index]['price']
                                                        ['1'];
                                              }

                                              setState(() {});
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: ProductList[index]
                                                              ['selectPrice'] ==
                                                          ProductList[index]
                                                              ['price']['1']
                                                      ? Colors.pink
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "1 Kg",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "\₹ ${ProductList[index]['price']['1']}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (ProductList[index]
                                                      ['selectPrice'] ==
                                                  ProductList[index]['price']
                                                      ['2']) {
                                                ProductList[index]
                                                    ['selectPrice'] = "";
                                              } else {
                                                ProductList[index]
                                                        ['selectPrice'] =
                                                    ProductList[index]['price']
                                                        ['2'];
                                              }

                                              setState(() {});
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: ProductList[index]
                                                              ['selectPrice'] ==
                                                          ProductList[index]
                                                              ['price']['2']
                                                      ? Colors.pink
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "2 Kg",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "\₹ ${ProductList[index]['price']['2']}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        child: Text('Add to cart',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15)),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.pink,
                                        ),
                                        onPressed: () {
                                          if (ProductList[index]
                                                  ['selectPrice'] !=
                                              "") {
                                            FirebaseFirestore.instance
                                                .collection("AddCart")
                                                .add(
                                              {
                                                "productId": ProductList[index]
                                                    ['id'],
                                                "image": ProductList[index]
                                                    ['CPhoto'],
                                                "name": ProductList[index]
                                                    ['cName'],
                                                "flavor": ProductList[index]
                                                    ['cFlavor'],
                                                "price": ProductList[index]
                                                    ['selectPrice'],
                                                "userId": userInfo['id'],
                                              },
                                            ).then((value) {
                                              debugPrint("Success");
                                            }).onError((error, stackTrace) {
                                              debugPrint("Failed");
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please select your Quantity and Peice")));
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Jars",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("256 Bakeries near you",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text("ALL",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54)),
                              Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.only(left: 15),
                          height: 280,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 1.0,
                                  spreadRadius: 1.0,
                                )
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  "assets/img/download-removebg-preview.png",
                                  width: 120,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Cheese cake",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                "Cake Store",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black54),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$ 320",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "\$ 520",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.bookmark_border))
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ))),
    );
  }

  List<dynamic> ProductList = [];

  Future<void> getProduct() async {
    ProductList.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Product').where('Categories', isEqualTo: 'Favorite cake').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      Map<String, dynamic> data =
          querySnapshot.docs[i].data() as Map<String, dynamic>;
      data['id'] = querySnapshot.docs[i].id;
      data['selectPrice'] = "";
      ProductList.add(data);
    }
    setState(() {});
  }


  List<dynamic> categoryList = [];

  Future<void> getcategory() async {
    categoryList.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('category').orderBy('Name',descending: false).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      Map<String, dynamic> data =
          querySnapshot.docs[i].data() as Map<String, dynamic>;
      data['id'] = querySnapshot.docs[i].id;
      categoryList.add(data);
    }
    setState(() {});
  }
}
