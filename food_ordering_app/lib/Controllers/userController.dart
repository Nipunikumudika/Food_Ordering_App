import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Models/user.dart';
import '../Services/userService.dart';

class UserController {
  var uid = "".obs;
  var shopid = "".obs;
  var cuser = User().obs;

  void setID(String na) {
    uid.value = na;
  }

  String getID() {
    print(uid.value);
    return uid.value;
  }

  void setCUser(User usr) {
    cuser.value = usr;
    print(usr.id);
    print("user sets");
  }

  void setShopId(String id) {
    shopid.value = id;
  }

  String getShopId() {
    return shopid.value;
  }

  User getCUser() {
    return cuser.value;
  }

  Future readAllUsers() async {
    UserService userService = UserService();
    List<User> userList = await userService.readAllUsers();
  }

  Future getUserByID(String? userID) async {
    UserService userService = UserService();
    User? usr = await userService.getUserByID(userID!);
    setCUser(usr!);
  }

  Future writeNewDoc(String uid, String email, String name, String country,
      String catergory) async {
    UserService userService = UserService();
    await userService.writeNewDoc(uid, email, name, country, catergory);
    User? usr = await userService.getUserByID(uid);
    setCUser(usr!);
  }

  Future updateDoc() async {
    UserService userService = UserService();
    await userService.updateDoc();
  }
}
