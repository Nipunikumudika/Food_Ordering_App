import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  Future<String?> signUpUser(String email, String password) async {
    // Sign-up code
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? uid = credential.user!.uid;
      return uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> signInUser(String email, String pw) async {
    try {
      print("ok");
      print(email);
      print(pw);
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pw);
      String? uid = credential.user!.uid;
      print(uid);
      return uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Future signInUser(String email, String pw) async {
  //   try {
  //     print("ok");
  //     print(email);
  //     print(pw);
  //     final credential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: pw);
  //     String? uid = credential.user!.uid;
  //     return {"isError": false, "msg": uid};
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //       return {"isError": true, "msg": "No user found for that email."};
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //       return {
  //         "isError": true,
  //         "msg": "Wrong password provided for that user."
  //       };
  //     } else {
  //       print(e.code);
  //     }
  //   } catch (e) {
  //     print(e);
  //     return {"isError": true, "msg": "${e.toString()}"};
  //   }
  // }
}
