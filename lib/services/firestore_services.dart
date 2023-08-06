import 'package:emart_app/consts/consts.dart';

class FirestoreServices{

  //get users data
  static getUser(uid){
    return firestore.collection(userCollection).where('id', isEqualTo: uid).snapshots();
  }
  //get products accroding to category
  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category', isEqualTo: category).snapshots();
  }

  static getSubCategoryProducts(title){
    return firestore.collection(productsCollection).where('p_subcategory', isEqualTo: title).snapshots();
  }

  //get cart
  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by', isEqualTo: uid).snapshots();
  }

  //delete document in the cart
  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //get all chat messages
  static getChatMessages(docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on',descending: false).snapshots();
  }


  //get all orders
  static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).snapshots();
  }

  //get all Wishlist
  static getWishList(){
    return firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).snapshots();
  }
  
  //get all Messages
  static getAllMessages(){
    return firestore.collection(chatsCollection).where('formId', isEqualTo: currentUser!.uid).snapshots();
  }

  //get all counts
  static getCounts() async{
    var res = await Future.wait([
      firestore.collection(cartCollection).where('added_by', isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allProducts(){
    return firestore.collection(productsCollection).snapshots();
  }

  //get featured products method
  static getFeaturedProducts(){
    return firestore.collection(productsCollection).where('is_featured', isEqualTo: true).get();
  }


  static searchProduct(title){
    return firestore.collection(productsCollection).get();
  }

  
}