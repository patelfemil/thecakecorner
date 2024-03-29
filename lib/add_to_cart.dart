import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thecakecorner/vars.dart';
import 'package:thecakecorner/your_order.dart';
import 'package:intl/intl.dart';

class AddtoCart extends StatefulWidget {
  const AddtoCart({super.key});

  @override
  State<AddtoCart> createState() => _AddtoCartState();
}

class _AddtoCartState extends State<AddtoCart> {
  TextEditingController todayDate = TextEditingController();

  bool enable = false;
  bool boyCap = false;
  bool girlCap = false;
  bool magicCandle = false;
  bool flowerCandle = false;
  bool bnumberCandle = false;
  bool birthdayBanner = false;
  bool anniversaryBanner = false;
  bool birthdayCard = false;
  bool anniversaryCard = false;

  String radioSelect = '250';
  String? radioVal;

  @override
  void initState() {
    getAddCartProduct();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink,
        title: Text("Cart"),
        automaticallyImplyLeading: false,
      ),
      body: enable == true
          ? Shimmer.fromColors(
              enabled: true,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
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
                                    IconButton(
                                      padding: EdgeInsets.only(left: 320),
                                      splashRadius: 25,
                                      icon: Icon(Icons.delete, size: 25),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Confirmation"),
                                              content: Text(
                                                  "Are you sure you want to deleted?"),
                                              actions: [
                                                TextButton(
                                                  child: Text("Yes"),
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('AddCart')
                                                        .doc(cartList[index]
                                                            ['id'])
                                                        .delete();
                                                    getAddCartProduct();
                                                    setState(() {});
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("No"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 150,
                                      width: double.maxFinite,
                                      child: Image.network(
                                        "${cartList[index]['image']}",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text("${cartList[index]['name']}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                    Text(
                                      "${cartList[index]['flavor']}",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                      keyboardType: TextInputType.datetime,
                                      controller: TextEditingController(
                                          text: cartList[index]['orderdate'] ??
                                              ''),
                                      decoration: InputDecoration(
                                          hintText: 'Pickup Date',
                                          suffixIcon: IconButton(
                                            onPressed: () async {
                                              DateTime? datePicked =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2024),
                                                      lastDate: DateTime(2050));
                                              if (datePicked != null) {
                                                var date =
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(datePicked);
                                                cartList[index]['orderdate'] =
                                                    date;
                                                setState(() {});
                                                print(
                                                    "'Date Selected:${datePicked.year}-${datePicked.month}-${datePicked.day}');");
                                              }
                                            },
                                            icon: Icon(Icons.calendar_today,
                                                color: Colors.black),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\₹${int.parse(cartList[index]['price'].toString()) * cartList[index]['itemCount']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black26),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  if (cartList[index]
                                                          ['itemCount'] !=
                                                      1) {
                                                    cartList[index]
                                                        ['itemCount']--;
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                              Text(cartList[index]['itemCount']
                                                  .toString()),
                                              IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    cartList[index]
                                                            ['itemCount'] =
                                                        cartList[index]
                                                                ['itemCount'] +
                                                            1;
                                                    setState(() {});
                                                  })
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 02,
                                            primary: Colors.pink,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50, vertical: 15)),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('userOrder')
                                              .add({
                                            'status': 1,
                                            "PickupDate": cartList[index]
                                                ['orderdate'],
                                            "priceOrder": cartList[index]
                                                ['price'],
                                            "items": cartList[index]
                                                ['itemCount'],
                                            "productId": cartList[index]
                                                ['productId'],
                                            "userId": userInfo['id'],
                                          });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    YourOrder(),
                                              ));
                                        },
                                        child: Text(
                                          'Get Order',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ]));
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox();
                        },
                        itemCount: cartList.length)
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
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
                                  IconButton(
                                    padding: EdgeInsets.only(left: 320),
                                    splashRadius: 25,
                                    icon: Icon(Icons.delete, size: 25),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Confirmation"),
                                            content: Text(
                                                "Are you sure you want to deleted?"),
                                            actions: [
                                              TextButton(
                                                child: Text("Yes"),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('AddCart')
                                                      .doc(
                                                          cartList[index]['id'])
                                                      .delete();
                                                  getAddCartProduct();
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text("No"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 150,
                                    width: double.maxFinite,
                                    child: Image.network(
                                      "${cartList[index]['image']}",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("${cartList[index]['name']}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                    "${cartList[index]['flavor']}",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.datetime,
                                    controller: TextEditingController(
                                        text:
                                            cartList[index]['orderdate'] ?? ''),
                                    decoration: InputDecoration(
                                        hintText: 'Pickup Date',
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            DateTime? datePicked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2024),
                                                    lastDate: DateTime(2050));
                                            if (datePicked != null) {
                                              var date =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(datePicked);
                                              cartList[index]['orderdate'] =
                                                  date;
                                              setState(() {});
                                              print(
                                                  "'Date Selected:${datePicked.year}-${datePicked.month}-${datePicked.day}');");
                                            }
                                          },
                                          icon: Icon(Icons.calendar_today,
                                              color: Colors.black),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "\₹${int.parse(cartList[index]['price'].toString()) * cartList[index]['itemCount']}",
                                  //       style: TextStyle(
                                  //           fontSize: 20,
                                  //           color: Colors.red,
                                  //           fontWeight: FontWeight.w500),
                                  //     ),
                                  //     Spacer(),
                                  //     Container(
                                  //       margin: EdgeInsets.only(right: 20),
                                  //       decoration: BoxDecoration(
                                  //         border:
                                  //             Border.all(color: Colors.black26),
                                  //         borderRadius:
                                  //             BorderRadius.circular(25),
                                  //       ),
                                  //       child: Row(
                                  //         children: [
                                  //           IconButton(
                                  //             icon: Icon(Icons.remove),
                                  //             onPressed: () {
                                  //               if (cartList[index]
                                  //                       ['itemCount'] !=
                                  //                   1) {
                                  //                 cartList[index]
                                  //                     ['itemCount']--;
                                  //                 setState(() {});
                                  //               }
                                  //             },
                                  //           ),
                                  //           Text(cartList[index]['itemCount']
                                  //               .toString()),
                                  //           IconButton(
                                  //               icon: Icon(Icons.add),
                                  //               onPressed: () {
                                  //                 cartList[index]['itemCount'] =
                                  //                     cartList[index]
                                  //                             ['itemCount'] +
                                  //                         1;
                                  //                 setState(() {});
                                  //               })
                                  //         ],
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 02,
                                          primary: Colors.pink,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 15)),
                                      onPressed: () {
                                        showSheet(context, index);
                                      },
                                      child: Text(
                                        'Add +',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ]));
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox();
                      },
                      itemCount: cartList.length)
                ],
              ),
            ),
    );
  }

  showSheet(context, index) {
    return showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 550,
              color: Color(0xffF3F0F0FF),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network('${cartList[index]['image']},',
                              height: 80, fit: BoxFit.cover),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${cartList[index]['name']}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.mobile_screen_share))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Quantity',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                         border: Border.all(color: Colors.red),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                          child: Text('REQUIRED',style: TextStyle(color: Colors.red,fontSize: 13,fontWeight: FontWeight.w500),))
                                    ],
                                  ),
                                  Text(
                                    'Select any 1 option',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Divider(
                                    color: Colors.black26,
                                  ),
                                  Row(
                                    children: [
                                      Text('250 Gm',
                                          style: TextStyle(
                                            fontSize: 15,
                                          )),
                                      Spacer(),
                                      Text(
                                          "\₹ ${cartList[index]['productDetails']['price']['250']}",
                                          style: TextStyle(fontSize: 15)),
                                      Radio(
                                        value: '250 Gm',
                                        activeColor: Colors.pink,
                                        groupValue: radioSelect,
                                        onChanged: (value) {
                                          setState(() {
                                            radioSelect = value!;
                                            cartList[index]['selectPrice'] =
                                                cartList[index]
                                                        ['productDetails']
                                                    ['price']['250'];
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('500 Gm',
                                          style: TextStyle(fontSize: 15)),
                                      Spacer(),
                                      Text(
                                          "\₹ ${cartList[index]['productDetails']['price']['500']}",
                                          style: TextStyle(fontSize: 15)),
                                      Radio(
                                        value: '500 Gm',
                                        activeColor: Colors.pink,
                                        groupValue: radioSelect,
                                        onChanged: (value) {
                                          setState(() {
                                            radioSelect = value!;
                                            cartList[index]['selectPrice'] =
                                                cartList[index]
                                                        ['productDetails']
                                                    ['price']['500'];
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('750 Gm',
                                          style: TextStyle(fontSize: 15)),
                                      Spacer(),
                                      Text(
                                          "\₹ ${cartList[index]['productDetails']['price']['750']}",
                                          style: TextStyle(fontSize: 15)),
                                      Radio(
                                        value: '750 Gm',
                                        activeColor: Colors.pink,
                                        groupValue: radioSelect,
                                        onChanged: (value) {
                                          setState(() {
                                            radioSelect = value!;
                                            cartList[index]['selectPrice'] =
                                                cartList[index]
                                                        ['productDetails']
                                                    ['price']['750'];
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('1 Kg',
                                          style: TextStyle(fontSize: 15)),
                                      Spacer(),
                                      Text(
                                          "\₹ ${cartList[index]['productDetails']['price']['500']}",
                                          style: TextStyle(fontSize: 15)),
                                      Radio(
                                        value: '1 Kg',
                                        activeColor: Colors.pink,
                                        groupValue: radioSelect,
                                        onChanged: (value) {
                                          setState(() {
                                            radioSelect = value!;
                                            cartList[index]['selectPrice'] =
                                                cartList[index]
                                                        ['productDetails']
                                                    ['price']['1'];
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('2 Kg',
                                          style: TextStyle(fontSize: 15)),
                                      Spacer(),
                                      Text(
                                          "\₹ ${cartList[index]['productDetails']['price']['2']}",
                                          style: TextStyle(fontSize: 15)),
                                      Radio(
                                        value: '2 Kg',
                                        activeColor: Colors.pink,
                                        groupValue: radioSelect,
                                        onChanged: (value) {
                                          setState(() {
                                            radioSelect = value!;
                                            cartList[index]['selectPrice'] =
                                                cartList[index]
                                                        ['productDetails']
                                                    ['price']['2'];
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Your Birthday Caps',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Select up to 2 option',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Birthday Boys Cap',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: boyCap
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        '₹15',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: boyCap
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Checkbox(
                                        value: boyCap,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            boyCap = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Birthday Girls Cap',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: girlCap
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      // isChecked == false ? FontWeight.bold
                                      Spacer(),
                                      Text(
                                        '₹21',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: girlCap
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Checkbox(
                                        value: girlCap,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            girlCap = value!;
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white70),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white70, spreadRadius: 2)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Your Candle',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Select up to 3 option',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Magic Candle',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: magicCandle
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        '₹15',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: magicCandle
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Checkbox(
                                        value: magicCandle,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            magicCandle = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Flower Candle',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: flowerCandle
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      // isChecked == false ? FontWeight.bold
                                      Spacer(),
                                      Text(
                                        '7',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: flowerCandle
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Checkbox(
                                        value: flowerCandle,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            flowerCandle = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Birthday Number Candle',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: bnumberCandle
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      // isChecked == false ? FontWeight.bold
                                      Spacer(),
                                      Text(
                                        '10',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: bnumberCandle
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Checkbox(
                                        value: bnumberCandle,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            bnumberCandle = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white70),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white70, spreadRadius: 2)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Choose Your Banners',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Select up to 2 option',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Happy Birthday Banner',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: birthdayBanner
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        '50',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: birthdayBanner
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Checkbox(
                                        value: birthdayBanner,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            birthdayBanner = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Happy Aniversary Banner',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: anniversaryBanner
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      // isChecked == false ? FontWeight.bold
                                      Spacer(),
                                      Text(
                                        '50',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: anniversaryBanner
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Checkbox(
                                        value: anniversaryBanner,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            anniversaryBanner = value!;
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white70),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white70, spreadRadius: 2)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Greeting Card',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Select up to 2 option',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Birthday greeting card',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: birthdayCard
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Spacer(),
                                      Text(
                                        '99',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: birthdayCard
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Checkbox(
                                        value: birthdayCard,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            birthdayCard = value!;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Aniversary greeting card',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: anniversaryCard
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      // isChecked == false ? FontWeight.bold
                                      Spacer(),
                                      Text(
                                        '99',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: anniversaryCard
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      Checkbox(
                                        value: anniversaryCard,
                                        activeColor: Colors.pink,
                                        onChanged: (value) {
                                          setState(() {
                                            anniversaryCard = value!;
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (cartList[index]['itemCount'] != 1) {
                                    cartList[index]['itemCount']--;
                                    setState(() {});
                                  }
                                },
                              ),
                              Text(cartList[index]['itemCount'].toString()),
                              IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    cartList[index]['itemCount'] =
                                        cartList[index]['itemCount'] + 1;
                                    setState(() {});
                                  })
                            ],
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            primary: Colors.pink,
                          ),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('userOrder')
                                .add({
                              'status': 1,
                              "PickupDate": cartList[index]['orderdate'],
                              // "priceOrder":cartList[index]['price'],
                              "items": cartList[index]['itemCount'],
                              "productId": cartList[index]['productId'],
                              "userId": userInfo['id'],
                              'orderPrice': cartList[index]['selectPrice'],
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => YourOrder(),
                                ));
                          },
                          child: Text(
                            "\ Get order ₹${int.parse(cartList[index]['selectPrice'] ?? cartList[index]['productDetails']['price']['250']) * cartList[index]['itemCount']}",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  List<dynamic> cartList = [];

  Future<void> getAddCartProduct() async {
    cartList.clear();
    enable = true;
    setState(() {});
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('AddCart').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      Map<String, dynamic> data =
          querySnapshot.docs[i].data() as Map<String, dynamic>;
      data['id'] = querySnapshot.docs[i].id;
      data['itemCount'] = 1;
      data['orderDate'] = "";

      DocumentSnapshot<Map<String, dynamic>> product = await FirebaseFirestore
          .instance
          .collection("Product")
          .doc(data['productId'])
          .get();
      if (product.exists) {
        data['productDetails'] = product.data();
      }

      if (userInfo['id'] == data['userId']) {
        cartList.add(data);
      }
    }
    enable = false;
    setState(() {});
  }
}
