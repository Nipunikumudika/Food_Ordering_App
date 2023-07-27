// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:food_ordering_app/Screens/foodDetailPageShop.dart';
import 'package:food_ordering_app/Screens/signupScreenShop.dart';
import 'package:food_ordering_app/Screens/signupScreenUser.dart';
import 'package:food_ordering_app/Screens/userScreen.dart';
import 'package:get/get.dart';
import '../Controllers/authController.dart';
import '../Controllers/shopController.dart';
import '../Controllers/userController.dart';
import '../Models/user.dart';

class LogInSCreen extends StatefulWidget {
  const LogInSCreen({super.key});
  @override
  State<LogInSCreen> createState() => _LogInSCreenState();
}

class _LogInSCreenState extends State<LogInSCreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final ShopController shopController = Get.put(ShopController());
  String errorMessageemail = '';
  String errorMessagepw = '';

  final UserController userController = Get.put(UserController());

  User? usr;
  void signInUser() async {
    AuthController authController = AuthController();
    String? id = await authController.signInUser(
        emailcontroller.text, passwordcontroller.text);

    if (id != null) {
      userController.setID(id);
      await userController.getUserByID(id);
      User usr = userController.getCUser();

      if (usr.catergory == "shop") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => FoodDetailsPageShop()));
      } else if (usr.catergory == "user") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserScreen()));
      }
    } else {
      print("no user");
    }
  }

  void validateEmail(String val) {
    if (!EmailValidator.validate(val, true)) {
      setState(() {
        errorMessageemail = "Invalid Email Address";
      });
    } else {
      setState(() {
        errorMessageemail = "";
      });
    }
  }

  void validatePassword(String val) {
    if (val == "") {
      setState(() {
        errorMessagepw = "Enter Your Password";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Welcome!")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            emailInputWidget(emailcontroller),
            passwordInputWidget(passwordcontroller),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 11, 199, 246),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(200, 40), //////// HERE
                  ),
                  onPressed: () {
                    signInUser();
                  },
                  child: const Text("Sign In")),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "No Account. Click below buttons to SignUp",
                style: TextStyle(color: Color.fromARGB(255, 52, 15, 239)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 11, 199, 246),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(200, 40), //////// HERE
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreenUser()));
                    },
                    child: const Text("Sign Up as User")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 11, 199, 246),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(200, 40), //////// HERE
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreenShop()));
                    },
                    child: const Text("Sign Up as a Shop")),
              ],
            ),
          ],
        ));
  }

  Widget emailInputWidget(TextEditingController ctrl) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: ctrl,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              //errorText: "Error",
              border: OutlineInputBorder(),
              labelText: "Email Address",
              hintText: "Enter Your Email Address",
            ),
            onChanged: (val) {
              validateEmail(val);
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorMessageemail,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordInputWidget(TextEditingController ctrl) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: ctrl,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              //errorText: "Error",
              border: OutlineInputBorder(),
              labelText: "Password",
              hintText: "Enter Your Password",
            ),
            onChanged: (val) {
              validatePassword(val);
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, bottom: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorMessagepw,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
