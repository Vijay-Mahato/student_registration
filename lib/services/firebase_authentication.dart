import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationFunction {
  static signUp(BuildContext context, String email, String password,
      String firstname, String lastname) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // const ToDo add user details to the Database
      if (credential.user?.uid != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'id': credential.user!.uid,
          "First_Name": firstname,
          "Last_Name": lastname,
          'Email': email,
          "Password": password
        });
      }
      print("Not any Error");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          margin: const EdgeInsets.all(10),
          content: const Text(
            "The password provided is too weak.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:
              BorderSide(color: Theme.of(context).primaryColor, width: 1)),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
              label: "Undo",
              textColor: Colors.blue,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }),
        ));

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          margin: const EdgeInsets.all(10),
          content: const Text(
            "The account already exists for that email.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:
              BorderSide(color: Theme.of(context).primaryColor, width: 1)),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
              label: "Undo",
              textColor: Colors.blue,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }),
        ));

        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static signIn(BuildContext context, String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("Log In");
    } on FirebaseAuthException catch (e) {
      print('Error code: ${e.code}');
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          margin: const EdgeInsets.all(10),
          content: const Text(
            "No user found for that email.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:
              BorderSide(color: Theme.of(context).primaryColor, width: 1)),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
              label: "Undo",
              textColor: Colors.blue,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }),
        ));

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Error code: ${e.code}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          margin: const EdgeInsets.all(10),
          content: const Text(
            "Wrong password provided for that user.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side:
              BorderSide(color: Theme.of(context).primaryColor, width: 1)),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
              label: "Undo",
              textColor: Colors.blue,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }),
        ));

        print('Wrong password provided for that user.');
      }
    }
  }
}
