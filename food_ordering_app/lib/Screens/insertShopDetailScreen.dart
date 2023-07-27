import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Controllers/shopController.dart';
import 'package:food_ordering_app/Controllers/userController.dart';
import 'package:food_ordering_app/Screens/foodDetailPageShop.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/user.dart' as Usr;

class InsertShopDetailScreen extends StatefulWidget {
  const InsertShopDetailScreen({super.key});

  @override
  State<InsertShopDetailScreen> createState() => _InsertShopDetailScreenState();
}

class _InsertShopDetailScreenState extends State<InsertShopDetailScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? uid;
  File? _photo;
  Usr.User? usr;
  final ImagePicker _picker = ImagePicker();
  final UserController userController = Get.put(UserController());

  final ShopController shopController = Get.put(ShopController());
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController foodnamecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();

  void getc() {
    final User? user = auth.currentUser;
    uid = user?.uid;
  }

  @override
  void initState() {
    super.initState();
    getc();
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future AddDetails() async {
    final User? user = auth.currentUser;
    String? uid = user?.uid;
    userController.getUserByID(uid);
    usr = userController.getCUser();
    print(usr!.id);

    if (_photo == null) {
      print("no image");
      return;
    }

    String fileName = foodnamecontroller.text;
    String? shopname = usr!.name;
    String? url;
    try {
      final storageRef = storage
          .ref("/$shopname") //Folder Structure
          .child(fileName); //File name
      final taskSnapshot = await storageRef.putFile(
        _photo!,
      );
      url = await taskSnapshot.ref.getDownloadURL();
      print(url);
    } catch (e) {
      print('error occured');
    }
    print("uid");
    print(uid);
    shopController.writeNewDoc(
        uid!, foodnamecontroller.text, pricecontroller.text, url);
    print("done all");
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => FoodDetailsPageShop()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Upload Screen")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(children: [
            foodnameInputWidget(foodnamecontroller),
            priceInputWidget(pricecontroller),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  imgFromGallery();
                },
                child: const Text('Select An Image'),
              ),
            ),
            const SizedBox(height: 35),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: _photo != null
                  ? Image.file(_photo!, fit: BoxFit.cover)
                  : const Text('Please select an image'),
            ),
            const SizedBox(height: 35),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  AddDetails();
                },
                child: const Text('Add'),
              ),
            ),
            // Container(
            //     alignment: Alignment.center,
            //     width: double.infinity,
            //     height: 300,
            //     color: Colors.grey[300],
            //     child: Image.network(
            //         "https://firebasestorage.googleapis.com/v0/b/test-project-67c92.appspot.com/o/test_upload%2Fsample-image1?alt=media&token=afe5107c-dd83-4840-9066-5e7d0cf0bc4f")),
          ]),
        ),
      ),
    );
  }

  Widget foodnameInputWidget(TextEditingController ctrl) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: ctrl,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              //errorText: "Error",
              border: OutlineInputBorder(),
              labelText: "Food Name",
              hintText: "Enter Food Name",
            ),
          ),
        ),
      ],
    );
  }

  Widget priceInputWidget(TextEditingController ctrl) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: TextFormField(
            controller: ctrl,
            decoration: const InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              //errorText: "Error",
              border: OutlineInputBorder(),
              labelText: "Price",
              hintText: "Enter the Price",
            ),
          ),
        ),
      ],
    );
  }
}
