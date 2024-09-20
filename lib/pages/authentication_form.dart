import 'package:flutter/material.dart';


import '../services/firebase_authentication.dart';

Color selection =
const Color.fromARGB(255, 46, 99, 91); // Selects a mid-range green.

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({super.key});

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  bool isShowPassword = true;

  changeShowPasswordValue() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;
  changeLoginValue() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  String firstname = "";
  String lastname = "";
  String email = "";
  String password = "";

  showSnackBar() {
    final snackbar = SnackBar(
      margin: const EdgeInsets.all(10),
      content: isLogin
          ? const Text(
        "SignIn Successfully.",
        style:
        TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      )
          : const Text(
        "SigUp Successfully.",
        style:
        TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1)),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
          label: "Undo",
          textColor: Colors.blue,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  submitForm() {
    if (!isLogin) print("First Name is : $firstname");
    if (!isLogin) print("Last Name is: $lastname");
    print("Email is : $email");
    print("Password is : $password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selection,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLogin
                          ? const Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      )
                          : const Text(
                        "Sign up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                      isLogin
                          ? const SizedBox(height: 30)
                          : const SizedBox(height: 30),
                      if (!isLogin)
                        Container(
                          // color: const Color.fromARGB(255, 12, 12, 12),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          width: MediaQuery.of(context).size.width,
                          // height: 45,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            key: const ValueKey("first-name"),
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_outline),
                                prefixIconColor: Colors.white,
                                contentPadding: EdgeInsets.only(left: 10),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 50), // Add this

                                hintText: " Enter Your First Name",
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color.fromARGB(255, 12, 12, 12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                )),
                            validator: (value) {
                              if (value.toString().length <= 2) {
                                return "Please enter correct first name";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              firstname = value.toString();
                            },
                          ),
                        ),
                      if (!isLogin) const SizedBox(height: 10),
                      if (!isLogin)
                        Container(
                          //  color: const Color.fromARGB(255, 12, 12, 12),
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          width: MediaQuery.of(context).size.width,
                          // height: 45,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            key: const ValueKey("last_name"),
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_outline),
                                prefixIconColor: Colors.white,
                                contentPadding: EdgeInsets.only(left: 10),
                                prefixIconConstraints:
                                BoxConstraints(minWidth: 50), // Add this

                                hintText: " Enter Your Last Name",
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color.fromARGB(255, 12, 12, 12),
                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                )),
                            validator: (value) {
                              if (value.toString().length <= 2) {
                                return "Please enter correct last name";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              lastname = value.toString();
                            },
                          ),
                        ),
                      isLogin
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: 10),
                      Container(
                        // color: const Color.fromARGB(255, 12, 12, 12),
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: MediaQuery.of(context).size.width,
                        // height: 45,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          key: const ValueKey("email"),
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              prefixIconColor: Colors.white,
                              contentPadding: EdgeInsets.only(left: 10),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 50), // Add this

                              hintText: " Enter Your Email",
                              hintStyle: TextStyle(color: Colors.white),
                              filled: true,
                              fillColor: Color.fromARGB(255, 12, 12, 12),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                              )),
                          validator: (value) {
                            if (value.toString().isEmpty ||
                                !value.toString().contains("@")) {
                              return "Please Enter Correct email";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            email = value.toString();
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        // color: const Color.fromARGB(255, 12, 12, 12),
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: MediaQuery.of(context).size.width,
                        // height: 45,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          key: const ValueKey("password"),
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outlined),
                            prefixIconColor: Colors.white,
                            contentPadding: const EdgeInsets.only(left: 10),
                            prefixIconConstraints: const BoxConstraints(
                                minWidth: 50), // Add this

                            hintText: " Enter Your Password",
                            hintStyle: const TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 12, 12, 12),
                            border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  changeShowPasswordValue();
                                },
                                icon: isShowPassword
                                    ? const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.white,
                                )
                                    : const Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.white,
                                )),
                            suffixIconColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value.toString().length < 5 ||
                                !value.toString().contains("#")) {
                              return "Please enter strong password";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            password = value.toString();
                          },
                          obscureText: isShowPassword,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              overlayColor:
                              WidgetStateProperty.all(Colors.grey),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 198, 198, 198)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              isLogin
                                  ? AuthenticationFunction.signIn(
                                  context, email, password)
                                  : AuthenticationFunction.signUp(context,
                                  email, password, firstname, lastname);
                              showSnackBar();
                              submitForm();
                            }
                            // if (_formKey.currentState!.validate()) {
                            //   _formKey.currentState!.save();
                            //   isLogin
                            //       ? FirebaseAuthentication.signIn(
                            //           context, email, password)
                            //       : FirebaseAuthentication.signUp(
                            //           context, email, password);
                            // }
                          },
                          child: isLogin
                              ? const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Color.fromARGB(255, 12, 12, 12),
                                fontSize: 17),
                          )
                              : const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color.fromARGB(255, 12, 12, 12),
                                fontSize: 17),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      TextButton(
                        onPressed: () {
                          changeLoginValue();
                        },
                        child: isLogin
                            ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              " Sign up.",
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                            : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                )),
                            Text(" Sign in.",
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   margin: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         "--------------------------------- ",
                      //         style: TextStyle(
                      //             color: Colors.white.withOpacity(0.5)),
                      //       ),
                      //       Text(
                      //         "or",
                      //         style: TextStyle(
                      //             color: Colors.black.withOpacity(0.5),
                      //             fontSize: 15),
                      //       ),
                      //       Text(
                      //         " ---------------------------------",
                      //         style: TextStyle(
                      //             color: Colors.white.withOpacity(0.5)),
                      //       ),
                      //     ],
                      //   ),
                      // )

                      // )
                      // Container(
                      //   margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 50),
                      //   height: 40,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: ElevatedButton(
                      //     style: ButtonStyle(
                      //         overlayColor: WidgetStateProperty.all(Colors.grey),
                      //         backgroundColor:
                      //             WidgetStateProperty.all<Color>(selection),
                      //         shape:
                      //             WidgetStateProperty.all(RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           side: const BorderSide(
                      //               color: Color.fromARGB(255, 198, 198, 198),
                      //               width: 1),
                      //         ))),
                      //     onPressed: () {
                      //       print("Clicked Sign In");
                      //     },
                      //     child: const Text(
                      //       "Create Account",
                      //       style: TextStyle(
                      //           color: Color.fromARGB(255, 198, 198, 198),
                      //           fontSize: 17),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
