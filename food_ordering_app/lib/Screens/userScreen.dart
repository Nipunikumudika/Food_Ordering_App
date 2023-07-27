import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Controllers/shopController.dart';
import 'package:food_ordering_app/Models/food.dart';
import 'package:food_ordering_app/Screens/foodDetailpageUser.dart';
import 'package:food_ordering_app/Screens/insertShopDetailScreen.dart';
import 'package:food_ordering_app/Screens/logInScreen.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Controllers/userController.dart';
import '../Models/user.dart';
import 'foodDetailPageShop.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserController userController = Get.put(UserController());
  final ShopController shopController = Get.put(ShopController());

  User? usr;
  String greeting = "Welcome";
  Future<void> read() async {
    var res;
    await shopController.readShops(usr?.country);
    await 1000.milliseconds.delay();
    if (usr!.country == "Sri Lanka") {
      res = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Colombo'));
    } else if (usr!.country == "Japan") {
      res = await http
          .get(Uri.parse('http://worldtimeapi.org/api/timezone/Asia/Tokyo'));
    }

    print(res);
    Map data = jsonDecode(res.body);
    String date = data["datetime"];
    print(date);
    String hour = date.substring(11, 13);
    print(hour);

    int hours = int.parse(hour);
    print(hours);
    if (hours >= 0 && hours <= 12) {
      greeting = "Good Morning!";
    } else if (hours >= 12 && hours <= 16) {
      greeting = "Good Afternoon!";
    } else if (hours >= 16 && hours <= 21) {
      greeting = "Good Evening!";
    } else if (hours >= 21 && hours <= 24) {
      greeting = "Good Night!";
    }
    print("done");
  }

  @override
  void initState() {
    super.initState();
    usr = userController.getCUser();
    print(usr?.id);
    shopController.clearShopList;
    read().then((Value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(greeting)),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            "User Dashboard",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Obx(() => ListView.builder(
                itemCount: shopController.allShopList.value.length,
                itemBuilder: (context, index) {
                  User user = shopController.allShopList.value[index];
                  return GestureDetector(
                    onTap: () {
                      print("user.id");
                      print(user.id);
                      userController.setShopId(user.id!);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodDetailsPageUser()));

                      //userController.setChattingUser(user);
                      //gotoChatScreen();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 106, 179, 239)),
                      height: 50,
                      margin: EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(user.name!),
                      ),
                    ),
                  );
                })),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LogInSCreen()));
            },
            child: Text("Logout"))
      ]),
    );
  }

  get(Uri uri) {}
}
