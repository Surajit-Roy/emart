import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/cart_screen/shipping_screen.dart';
import 'package:emart_app/views/categories_screen/loadingIndicator.dart';
import 'package:emart_app/views/controllers/cart_controller.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Cartcontroller());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(color: redColor, onPress: (){
          Get.to(ShippingDetails());
        }, textColor: whiteColor, title: "Proceed to shipping",)),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),

      body: StreamBuilder(stream: FirestoreServices.getCart(currentUser!.uid), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
        if(!snapshot.hasData){
          return Center(
            child: loadingIndicator(),
          );
        }else if(snapshot.data!.docs.isEmpty){
          return Center(
            child: "Cart is empty".text.color(darkFontGrey).make(),
          );
        }else{
          var data = snapshot.data!.docs;
          controller.calculate(data);
          controller.productSnapshot = data;
          return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading: Image.network('${data[index]['img']}', width: 80, fit: BoxFit.cover,),
                  title: "${data[index]['title']} (x${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
                  subtitle: "${data[index]['tprice']}".numCurrency.text.color(redColor).fontFamily(semibold).make(),
                  trailing: Icon(Icons.delete, color: redColor,).onTap(() { 
                    FirestoreServices.deleteDocument(data[index].id);
                  }),
                );
              }),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Total price".text.fontFamily(semibold).color(darkFontGrey).make(),
                Obx(()=>"${controller.totalP.value}".numCurrency.text.fontFamily(semibold).color(redColor).make()),
              ],
            ).box.padding(EdgeInsets.all(12)).width(context.screenWidth-60).color(lightGolden).roundedSM.make(),
            10.heightBox,
            // SizedBox(
            //   width: context.screenWidth-60,
            //   child: ourButton(color: redColor, onPress: (){}, textColor: whiteColor, title: "Proceed to shipping",)),
          ],
        ),
      );
        }
      })
    );
  }
}
