import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseOperation {
  static Future<void> create(String name, int age, String course) async {
    // Add a new document with a generated ID
    await FirebaseFirestore.instance.collection('Students').add({
      'name': name,
      'age': age,
      'course': course,
    });
  }

  static update(String documentId, String field, var newFieldValue) async {
    await FirebaseFirestore.instance
        .collection("Students")
        .doc(documentId)
        .update({field: newFieldValue});
  }

  static delete(String documentId) async {
    await FirebaseFirestore.instance
        .collection("Students")
        .doc(documentId)
        .delete();
  }
}
