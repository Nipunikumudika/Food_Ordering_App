import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_ordering_app/Models/food.dart';
import 'package:food_ordering_app/Services/shopService.dart';
import 'package:get/get.dart';

import '../Models/user.dart';
import '../Services/userService.dart';

class ShopController {
  var allFoodList = <Food>[].obs;
  var allShopList = <User>[].obs;
  var urlList = [].obs;
  ShopService shopService = ShopService();
  // var uid = "".obs;
  // var cuser = User().obs;

  // void setID(String na) {
  //   uid.value = na;
  // }

  // String? getID() {
  //   return uid.value;
  // }

  // void setCUser(User usr) {
  //   cuser.value = usr;
  // }

  // User? getCUser() {
  //   return cuser.value;
  // }

  Future readAllFoods(String? uid) async {
    List<Food> foodList = await shopService.readAllFoods(uid!);
    allFoodList.value = foodList;
    print(allFoodList);
  }

  clearShopList() {
    allShopList.value = [];
  }

  clearFoodList() {
    allFoodList.value = [];
  }

  Future readShops(String? country) async {
    allShopList.value = await shopService.readShopNames(country);
    print(allShopList);
  }

  Future writeNewDoc(
      String uid, String foodName, String price, String? url) async {
    ShopService shopService = ShopService();
    await shopService.writeNewDoc(uid, foodName, price, url);
  }

  Future updateDoc() async {
    UserService userService = UserService();
    await userService.updateDoc();
  }
}
