import 'package:company_chat_app/helper/methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> CreateAccount(BuildContext context,
    {required String email, required String password}) async {
  try {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    ShowSnackBar(context, message: "Successfully");
  } catch (e) {
    ShowSnackBar(context, message: e.toString());
  }
}

// Future<void> firebaseCreateUserWithEmailAndPassword(BuildContext context,
//     {required String email, password}) async {
//   try {
//     CreateAccount(context, email: email, password: password);
//   } on FirebaseAuthException catch (ex) {
//     if (ex.code == 'weak-password') {
//       ShowSnackBar(context, message: "The entered password is too weak");
//     } else if (ex.code == 'email-already-in-use') {
//       ShowSnackBar(context,
//           message: "The account already exists for that email");
//     }
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(e.toString()),
//       ),
//     );
//   }
// }