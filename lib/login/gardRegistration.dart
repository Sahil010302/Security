import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:security/login/gardLogin.dart';

class GuardRegis extends StatefulWidget {
  const GuardRegis({super.key});

  @override
  State<GuardRegis> createState() => _UserRegiState();
}

class _UserRegiState extends State<GuardRegis> {
  TextEditingController Email = new TextEditingController();
  TextEditingController Password = new TextEditingController();
  TextEditingController cPassword = new TextEditingController();
  TextEditingController Name = new TextEditingController();
  TextEditingController Age = new TextEditingController();
  TextEditingController Adhar = new TextEditingController();
  TextEditingController Phone = new TextEditingController();
  TextEditingController Work = new TextEditingController();

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
    String email = Email.text.trim();
    String password = Password.text.trim();
    String cpassword = cPassword.text.trim();
    String name = Name.text.trim();
    String age = Age.text.trim();
    String adhar = Adhar.text.trim();
    String phone = Phone.text.trim();
    String work = Work.text.trim();

    if (email != " " &&
        password != "" &&
        cpassword != "" &&
        name != " " &&
        age != "" &&
        adhar != "" &&
        phone != " " &&
        work != "") {
      if (password == cpassword) {
        Map<String, dynamic> Guard = {
          "name": name,
          "age": age,
          "adharNo": adhar,
          "workAt": work,
          "cpassword": cpassword,
          "email": email,
          "phoneNo": phone,
          "password": password
        };

        await FirebaseFirestore.instance.collection("GuardDetails").add(Guard);
      }
    }
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
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GuardLogin()));
              showRegistrationSnackBar();
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
          "User Registration",
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    guardDetails(
                      controller: cPassword,
                      labletext: "Confirm Password  ",
                      hinttext: " Enter your password",
                      icons: const Icon(CupertinoIcons.checkmark_seal),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Createaccount();
                        GuardDetail();
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
    required TextEditingController controller}) {
  return TextField(
    controller: controller,
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






