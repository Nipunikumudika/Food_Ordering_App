import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user.dart';

class UserService {
  var userRef = FirebaseFirestore.instance.collection('User');

  Future<List<User>> readAllUsers() async {
    // userRef
    // .get()
    // .then((QuerySnapshot querySnapshot) {
    //   List<User> userList = [];
    //     querySnapshot.docs.forEach((doc) {
    //       User userM = userFromJson(doc.data().toString());
    //       userList.add(userM);
    //     });
    //     return userList;
    // });

    List<User> userList = [];
    QuerySnapshot querySnapshot = await userRef.get();

    //? Query with where condition
    //QuerySnapshot querySnapshot = await userRef.where("age", isGreaterThan: 18).get();

    querySnapshot.docs.forEach((doc) {
      print(doc.get("email"));
      // User userM = userFromJson();
      // userList.add(userM);
    });
    return userList;
  }

  Future<User?> getUserByID(String userID) async {
    User? usr;
    await userRef
        .doc(userID) //Get Document By ID
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (!documentSnapshot.exists) {
        print('Document does not exists on the database');
      } else {
        usr = User(
          id: documentSnapshot.get("id"),
          name: documentSnapshot.get("name"),
          email: documentSnapshot.get("email"),
          country: documentSnapshot.get("country"),
          catergory: documentSnapshot.get("catergory"),
        );
      }
    });
    return usr;
  }

  Future writeNewDoc(String uid, String email, String name, String country,
      String catergory) async {
    var docRef = userRef.doc(uid);
    //? Create document by auto generated ID
    docRef
        .set({
          'id': uid,
          'email': email,
          'name': name,
          'country': country,
          'catergory': catergory,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future updateDoc() async {
    userRef
        .doc("rND7I47tPv2W8ekQE6fa")
        .update({'username': "hiyou"})
        .then((value) => print("User updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
