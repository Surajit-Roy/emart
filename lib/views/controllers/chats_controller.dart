// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emart_app/consts/consts.dart';
// import 'package:emart_app/views/controllers/home_controller.dart';
// import 'package:get/get.dart';

// class ChatsController extends GetxController{


//   @override
//   void onInit() {
//     getChatId();
//     super.onInit();
//   }

//   var chats = firestore.collection(chatsCollection);
//   var friendName = Get.arguments[0];
//   var friendId = Get.arguments[1];
//   var senderName = Get.find<HomeController>().username;
//   var currentId = currentUser!.uid;
//   var msgController = TextEditingController();
//   dynamic chatDocId;
//   var isLoading = false.obs;

//   void getChatId() async{

//     isLoading(true);

//     await chats.where('user', isEqualTo: {
//       friendId: null,
//       currentId: null
//     }).limit(1).get().then((QuerySnapshot snapshot){
//       if(snapshot.docs.isNotEmpty){
//         chatDocId = snapshot.docs.single.id;
//       }else{
//         chats.add({
//           'created_on': null,
//           'last_msg': '',
//           'users': {friendId:null, currentId:null},
//           'toId': '',
//           'fromId': '',
//           'friend_name': friendName,
//           'sender_name':senderName
//         }).then((value){
//           {chatDocId = value.id;}
//         });
//       }
//     });
//       isLoading(false);
//   }

//   sendMsg(String msg) async{
//     if(msg.trim().isNotEmpty){
//       chats.doc(chatDocId).update({
//         'created_on': FieldValue.serverTimestamp(),
//         'last_msg': msg,
//         'toId': friendId,
//         'fromId': currentId,
//       });

//       chats.doc(chatDocId).collection(messagesCollection).doc().set({
//         'created_on': FieldValue.serverTimestamp(),
//         'msg': msg,
//         'uid': currentId,
//       });
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  final chats = FirebaseFirestore.instance.collection(chatsCollection);
  final friendName = Get.arguments[0];
  final friendId = Get.arguments[1];
  final senderName = Get.find<HomeController>().username;
  final currentId = FirebaseAuth.instance.currentUser!.uid;
  final msgController = TextEditingController();
  var chatDocId = ''.obs; // Observable variable
  var isLoading = false.obs;

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  void getChatId() async {
    isLoading.value = true;

    final querySnapshot = await chats
        .where('users.$friendId', isEqualTo: null)
        .where('users.$currentId', isEqualTo: null)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      chatDocId.value = querySnapshot.docs.first.id; // Assign the value using 'value'
    } else {
      final newChatDocRef = await chats.add({
        'created_on': null,
        'last_msg': '',
        'users': {friendId: null, currentId: null},
        'toId': '',
        'fromId': '',
        'friend_name': friendName,
        'sender_name': senderName,
      });
      chatDocId.value = newChatDocRef.id; // Assign the value using 'value'
    }

    isLoading.value = false;
  }

  void sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      await chats.doc(chatDocId.value).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': currentId,
      });

      await chats.doc(chatDocId.value)
          .collection(messagesCollection)
          .add({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
