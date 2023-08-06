import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/views/categories_screen/loadingIndicator.dart';
import 'package:emart_app/views/controllers/cart_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';


class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Cartcontroller>();
    return Obx(()=> Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose a Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value ? Center(
            child: loadingIndicator(),
          ): ourButton(
            onPress: () async{
              await controller.placeMyOrder(orderPaymentMethod: paymentMethods[controller.paymentIndex.value], totalAmount: controller.totalP.value);

              await controller.clearCart();
              VxToast.show(context, msg: "Order placed successfully");
              
              Get.offAll(Home());
            },
            color: redColor,
            textColor: whiteColor,
            title: "Place My Order",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(() => Column(
              children:List.generate(paymentMethodsImg.length, (index){
                return GestureDetector(
                  onTap: (){
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:controller.paymentIndex.value == index ? redColor : Colors.transparent,
                        width: 4,
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(paymentMethodsImg[index], width:double.infinity, height: 100, fit: BoxFit.cover, colorBlendMode:controller.paymentIndex.value == index ? BlendMode.darken: BlendMode.color, color: controller.paymentIndex.value == index ? Colors.black.withOpacity(0.2):Colors.transparent),
                        controller.paymentIndex.value == index? Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            activeColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                            value: true, onChanged: (value){}),
                        ):Container(),
                        Positioned(
                          bottom: 0,
                          right: 10,
                          child: paymentMethods[index].text.white.fontFamily(semibold).size(15).make()),
                      ],
                    ),
                  ),
                );
              })
            ),
          ),
        ),
      ),
    );
  }
}