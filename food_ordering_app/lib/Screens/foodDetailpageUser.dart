import 'package:flutter/material.dart';
import 'package:food_ordering_app/Controllers/shopController.dart';
import 'package:food_ordering_app/Models/food.dart';
import 'package:food_ordering_app/Screens/insertShopDetailScreen.dart';
import 'package:food_ordering_app/Screens/userScreen.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Controllers/userController.dart';
import '../Models/user.dart';

class FoodDetailsPageUser extends StatefulWidget {
  const FoodDetailsPageUser({super.key});

  @override
  State<FoodDetailsPageUser> createState() => _FoodDetailsPageUserState();
}

class _FoodDetailsPageUserState extends State<FoodDetailsPageUser> {
  final UserController userController = Get.put(UserController());
  final ShopController shopController = Get.put(ShopController());

  User? usr;
  @override
  void initState() {
    super.initState();
    usr = userController.getCUser();
    String id = userController.getShopId();
    print(id);
    shopController.readAllFoods(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome ....")),
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Text(
            "Shop Dashboard",
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
                itemCount: shopController.allFoodList.value.length,
                itemBuilder: (context, index) {
                  Food food = shopController.allFoodList.value[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 220, 235, 248)),
                      height: 100,
                      margin: EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, bottom: 3, left: 50, right: 50),
                              child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 80,
                                color: Color.fromARGB(255, 220, 235, 248),
                                child: Image.network(food.url!),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  food.foodName!,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  food.price!,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserScreen()));
            },
            child: Text("Back"))
      ]),
    );
  }
}
