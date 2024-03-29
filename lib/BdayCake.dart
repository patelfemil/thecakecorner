import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thecakecorner/vars.dart';

class BdayPage extends StatefulWidget {
  final String category;
  const BdayPage({super.key,required this.category});

  @override
  State<BdayPage> createState() => _BdayPageState();
}

class _BdayPageState extends State<BdayPage> {
  @override
  void initState() {
    getProduct();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child:
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            // SizedBox(height: 10,),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              itemCount: ProductList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 25),
                  padding: EdgeInsets.only(left: 15),
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
                        height: 20,
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
                                      color: ProductList[index]
                                      ['selectPrice'] ==
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
                                    BorderRadius.circular(20)),
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
                                    BorderRadius.circular(20)),
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
                                    BorderRadius.circular(20)),
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
                                    BorderRadius.circular(20)),
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
          ],
        ),
      ),
    );
  }
  List<dynamic> ProductList = [];

  Future<void> getProduct() async {
    ProductList.clear();
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Product').where("Categories",isEqualTo: widget.category.trim()).get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      Map<String, dynamic> data =
      querySnapshot.docs[i].data() as Map<String, dynamic>;
      data['id'] = querySnapshot.docs[i].id;
      data['selectPrice'] = "";
      ProductList.add(data);
    }
    setState(() {});
  }
}
