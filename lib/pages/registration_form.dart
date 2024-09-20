import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  String name = "";
  int? age;
  String course = "";

  final _formKey1 = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _courseController = TextEditingController();

  String? currentDocumentId;

  showValue() {
    print("Name is : $name");
    print("Age is : $age");
    print("Course is : $course");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Registration Form",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: Colors.white),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.black.withOpacity(0.5), width: 1.5)),
              width: double.infinity,
              child: Center(
                child: Form(
                  key: _formKey1,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Student Registration Form",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        child: TextFormField(
                          controller: _nameController,
                          autocorrect: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.5),
                            ),
                            hintText: "Enter Student Name",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Student Name";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            name = newValue.toString();
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _ageController,
                          autocorrect: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.5),
                            ),
                            hintText: "Enter Age",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Age";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            age = int.parse(newValue!);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        child: TextFormField(
                          controller: _courseController,
                          autocorrect: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.5),
                            ),
                            hintText: "Enter Course",
                            hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Course";
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            course = newValue.toString();
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                              overlayColor:
                              MaterialStateProperty.all(Colors.grey),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: Colors.black, width: 1)))),
                          onPressed: () {
                            if (_formKey1.currentState!.validate()) {
                              _formKey1.currentState!.save();
                              if (currentDocumentId == null) {
                                FirebaseFirestore.instance
                                    .collection('Students')
                                    .add({
                                  'name': name,
                                  'age': age,
                                  'course': course,
                                });
                                print("Data Added Successfully");
                              } else {
                                FirebaseFirestore.instance
                                    .collection('Students')
                                    .doc(currentDocumentId)
                                    .update({
                                  'name': name,
                                  'age': age,
                                  'course': course,
                                });
                                print("Data Updated Successfully");
                                setState(() {
                                  currentDocumentId = null;
                                });
                              }

                              _nameController.clear();
                              _ageController.clear();
                              _courseController.clear();
                            }
                          },
                          child: Text(
                            currentDocumentId == null
                                ? "Add Student"
                                : "Update Student",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Text(
              'Student List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 230, // Define a fixed height
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Students')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                      ),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    final docs = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: docs.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final studentData =
                        docs[index].data() as Map<String, dynamic>;
                        return ListTile(
                          title: Text(studentData['name']),
                          subtitle: Text(
                              'Age: ${studentData['age']}, Course: ${studentData['course']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    _nameController.text = studentData['name'];
                                    _ageController.text =
                                        studentData['age'].toString();
                                    _courseController.text =
                                    studentData['course'];
                                    currentDocumentId = docs[index].id;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('Students')
                                      .doc(docs[index].id)
                                      .delete();
                                  print("Deleted Successfully");
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
