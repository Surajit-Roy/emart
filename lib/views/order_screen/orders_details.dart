import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/order_screen/components/order_place_detail.dart';
import 'package:emart_app/views/order_screen/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  orderStatus(
                    color: redColor, icon: Icons.shopping_cart, title: "Placed", showDone: data['order_placed'],
                  ),
                  orderStatus(
                    color: Colors.blue, icon: Icons.thumb_up, title: "Confirmed", showDone: data['order_confirmed'],
                  ),
                  orderStatus(
                    color: Colors.teal, icon: Icons.delivery_dining
                    , title: "On Delivery", showDone: data['order_on_delivery'],
                  ),
                  orderStatus(
                    color: Colors.purple, icon: Icons.done_all_rounded, title: "Delivered", showDone: data['order_delivered'],
                  ),
              
                  Divider(),
                  10.heightBox,
                  Column(
                    children: [
                      orderPlaceDetails(
                        d1: data['order_code'],
                        d2: data['shipping_method'],
                        title1: "Order Code",
                        title2: "Shipping Method",
                      ),
                      orderPlaceDetails(
                        d1:intl.DateFormat().add_yMd().format( data['order_date'].toDate()),
                        d2: data['payment_method'],
                        title1: "Order Date",
                        title2: "Payment Method",
                      ),
                      orderPlaceDetails(
                        d1:"Unpaid",
                        d2: "Order Placed ",
                        title1: "Payment Status",
                        title2: "Delivery Status",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:14.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Address".text.fontFamily(bold).make(),
                                "${data['order_by_name']}".text.make(),
                                "${data['order_by_email']}".text.make(),
                                "${data['order_by_adderess']}".text.make(),
                                "${data['order_by_city']}".text.make(),
                                "${data['order_by_state']}".text.make(),
                                "${data['order_by_phone']}".text.make(),
                                "${data['order_by_postalcode']}".text.make(),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                "Total Amount".text.fontFamily(bold).make(),
                                "${data['total_amount']}".numCurrency.text.color(redColor).fontFamily(bold).make(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).box.white.outerShadowMd.make(),
                  Divider(),
                  10.heightBox,
        
                  "Ordered Product".text.color(darkFontGrey).fontFamily(semibold).size(20).makeCentered(),
        
                  10.heightBox,
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(data['orders'].length, (index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          title1: data['orders'][index]['title'],
                          title2: data['orders'][index]['tprice'],
                          d1: "${data['orders'][index]['qty']}x",
                          d2: "Refundable",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:16.0),
                          child: Container(
                            width: 30,
                            height: 20,
                            color: Color(data['orders'][index]['color']),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                  ).box.white.outerShadowMd.margin(EdgeInsets.only(bottom: 4)).make(),
                  20.heightBox,


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}