import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thecakecorner/vars.dart';

class YourOrder extends StatefulWidget {
  const YourOrder({super.key});

  @override
  State<YourOrder> createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {

  @override
  void initState() {
    getOrder();
    // TODO: implement initState
    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink,
        title: Text("My Order"),
      ),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                                orderList[index]['product_details']['CPhoto']??'',
                                width: 100),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    orderList[index]['product_details']
                                        ['cName'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  orderList[index]['product_details']
                                      ['cFlavor'],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "\₹${int.parse(orderList[index]['priceOrder'].toString()) * int.parse(orderList[index]['items'].toString())}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.black26,
                        ),
                        Text(
                          'items :',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(orderList[index]['items'].toString(),
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Customer :',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(orderList[index]['users_details']['full_name'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(orderList[index]['users_details']['mobile_Number'],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            orderList[index]['users_details']['emailAddress'] ??
                                '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(orderList[index]['users_details']['address'] ?? '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Pickup Date :",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(orderList[index]['PickupDate'] ?? '',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemCount: orderList.length)
          ],
        ),
      ),
    );
  }

  List<dynamic> orderList = [];

  Future<void> getOrder() async {
    orderList.clear();

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('userOrder').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      Map<String, dynamic> data =
          querySnapshot.docs[i].data() as Map<String, dynamic>;
      data['id'] = querySnapshot.docs[i].id;
      DocumentSnapshot<Map<String, dynamic>> product = await FirebaseFirestore
          .instance
          .collection('Product')
          .doc(data['productId'])
          .get();

      if (product.exists) {
        data['product_details'] = product.data();
      }

      if (userInfo['id'] == data['userId']) {
        DocumentSnapshot<Map<String, dynamic>> users = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(data['userId'])
            .get();

        if (users.exists) {
          data['users_details'] = users.data();
        }
        orderList.add(data);
      }
    }
    setState(() {});
  }
}