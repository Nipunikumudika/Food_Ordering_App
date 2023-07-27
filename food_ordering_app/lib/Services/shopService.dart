import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_ordering_app/Models/food.dart';
import 'package:get/get.dart';
import '../Models/user.dart';

class ShopService {
  var userRef = FirebaseFirestore.instance.collection('User');
  Future<List<Food>> readAllFoods(String uid) async {
    List<Food> foodList = [];

    final databaseReference = FirebaseFirestore.instance;
    var query = await databaseReference
        .collection('User')
        .doc(uid)
        .collection('Foods')
        .get();
    query.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data();
      Food foodrM = Food.fromJson(data);
      foodList.add(foodrM);
    });
    return foodList;
  }

  Future<List<User>> readShopNames(String? country) async {
    List<User> shopList = [];

    var query = await userRef
        .where("country", isEqualTo: country)
        .where("catergory", isEqualTo: "shop")
        .get();
    query.docs.forEach((doc) async {
      User userM = await User.fromJson(doc.data());

      await userRef
          .doc(userM.id) //Get Document By ID
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (!documentSnapshot.exists) {
          print('Document does not exists on the database');
        } else {
          print(documentSnapshot.data());

          Map<String, dynamic> data = doc.data();
          User user = User.fromJson(data);
          shopList.add(user);
        }
      });
    });

    return shopList;
  }

  Future<void> readAllURLs(String? shopname) async {
    String downloadURL = await FirebaseStorage.instance
        .ref("/$shopname")
        .child("Flutter.png")
        .getDownloadURL();
  }

  Future getUserByID(String userID) async {
    userRef
        .doc(userID) //Get Document By ID
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (!documentSnapshot.exists) {
        print('Document does not exists on the database');
      } else {
        print(documentSnapshot.data());
      }
    });
  }

  Future writeNewDoc(
      String uid, String foodName, String price, String? url) async {
    var shopRef = FirebaseFirestore.instance;
    shopRef.collection('User').doc(uid).collection('Foods').doc().set({
      'foodName': foodName,
      'price': price,
      'url': url,
    });
  }
}
