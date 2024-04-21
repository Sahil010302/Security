import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:security/login/gardLogin.dart';

class GuardRegis extends StatefulWidget {
  const GuardRegis({Key? key}) : super(key: key);

  @override
  State<GuardRegis> createState() => _UserRegiState();
}

class _UserRegiState extends State<GuardRegis> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController Name = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController Adhar = TextEditingController();
  TextEditingController Phone = TextEditingController();
  TextEditingController Work = TextEditingController();

  void showRegistrationSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(15),
        content: Text(
          "Registered successfully!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void GuardDetail() async {
    String name = Name.text.trim();
    String age = Age.text.trim();
    String adhar = Adhar.text.trim();
    String phone = Phone.text.trim();
    String work = Work.text.trim();

    Map<String, dynamic> guard = {
      "name": name,
      "age": age,
      "adharNo": adhar,
      "workAt": work,
      "phoneNo": phone,
    };

    await FirebaseFirestore.instance.collection("GuardDetails").add(guard);
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password); // Encode the password as UTF-8
    var digest = sha256.convert(bytes); // Hash the password using SHA-256
    return digest.toString(); // Return the hashed password as a string
  }

  void Createaccount() async {
    String email = Email.text.trim();
    String password = Password.text.trim();
    String cpassword = cPassword.text.trim();

    if (email == "" || password == "" || cpassword == "") {
      const incompleteFields = SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(15),
        content: Text(
          "Fill all the field",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(incompleteFields);
    } else if (password != cpassword) {
      const incompleteFields = SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Color.fromARGB(255, 231, 217, 97),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(15),
        content: Text(
          "Password incorrect",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(incompleteFields);
    } else {
      try {
        String hashedPassword = hashPassword(password);

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: hashedPassword);
        if (userCredential.user != null) {
          GuardDetail();
          showRegistrationSnackBar();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GuardLogin()),
          );
        }
      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Guard Registration",
          style: TextStyle(fontFamily: "Roboto", fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 152, 181, 232),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            "https://www.pngall.com/wp-content/uploads/5/Profile.png",
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 90,
                          child: Icon(
                            CupertinoIcons.photo_camera_solid,
                            color: Colors.grey,
                            shadows: [
                              Shadow(
                                blurRadius: 10.1,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    guardDetails(
                      controller: Name,
                      labletext: "Name",
                      hinttext: "Enter your name",
                      icons: Icon(CupertinoIcons.person),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    guardDetails(
                      controller: Age,
                      labletext: "Age",
                      hinttext: "Enter your age",
                      icons: const Icon(CupertinoIcons.number),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    guardDetails(
                      controller: Adhar,
                      labletext: "AdharCard Number ",
                      hinttext: "Enter your adhar number",
                      icons: const Icon(CupertinoIcons.doc_on_clipboard),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    guardDetails(
                      controller: Phone,
                      labletext: "Phone Number ",
                      hinttext: "Enter your phone number",
                      icons: const Icon(CupertinoIcons.phone),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    guardDetails(
                      controller: Work,
                      labletext: "Previously Work At  ",
                      hinttext: "Previously work at ",
                      icons: const Icon(CupertinoIcons.location),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    guardDetails(
                      controller: Email,
                      labletext: " Email ",
                      hinttext: "Enter your email id ",
                      icons: const Icon(CupertinoIcons.mail),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    guardDetails(
                      controller: Password,
                      labletext: "Password  ",
                      hinttext: " Enter your password",
                      icons: const Icon(CupertinoIcons.captions_bubble),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    guardDetails(
                      controller: cPassword,
                      labletext: "Confirm Password  ",
                      hinttext: " Enter your password",
                      icons: const Icon(CupertinoIcons.checkmark_seal),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Createaccount();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xff5b6378),
                        ),
                        height: 50,
                        width: 100,
                        child: const Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

TextField guardDetails(
    {required String hinttext,
    required String labletext,
    required Icon icons,
    required TextEditingController controller,
    bool obscureText = false}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      hintText: hinttext,
      labelText: labletext,
      labelStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      icon: icons,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    ),
  );
}
