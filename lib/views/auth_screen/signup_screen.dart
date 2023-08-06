import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/controllers/auth_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:get/get.dart';

import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "Join the $appname".text.fontFamily(bold).white.size(20).make(),
          15.heightBox,
          Obx(() => Column(
              children: [
                customTextField(hint: nameHint, title: name, controller: nameController, isPass: false),
                customTextField(hint: emailHint, title: email, controller: emailController, isPass: false),
                customTextField(hint: passwordHint, title: password, controller: passwordController, isPass: true),
                customTextField(hint: passwordHint, title: retypePassword, controller: passwordRetypeController, isPass: true),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPass.text.make())),
                Row(
                  children: [
                    Checkbox(
                        checkColor: redColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        }),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: termsAndCond,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            )),
                        TextSpan(
                            text: " and ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redColor,
                            )),
                      ])),
                    )
                  ],
                ),
                5.heightBox,
                controller.isloading.value?const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ): ourButton(
                        color: isCheck == true ? redColor : lightGrey,
                        title: signup,
                        textColor: whiteColor,
                        onPress: () async{
                          if(isCheck != false){
                            controller.isloading(true);
                            try{
                              await controller.signupMethod(context: context, email: emailController.text, password: passwordController.text).then((value){
                                return controller.storeUserData(
                                  email: emailController.text, password: passwordController.text, name: nameController.text
                                );
                              }).then((value){
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(()=> const Home());
                              });
                            } catch(e){
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isloading(false);
                            }
                          }
                        },)
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                10.heightBox,
          
                //wrapping into gesture detector of velocity X
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alreadyHaveAccount.text.color(fontGrey).make(),
                    login.text.color(redColor).make().onTap(() {
                      Get.back();
                    })
                  ],
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          )
        ],
      )),
    ));
  }
}
