import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security/Guard/home.dart';
import 'package:security/login/gardRegistration.dart';

class GuardLogin extends StatefulWidget {
  GuardLogin({super.key});

  @override
  State<GuardLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<GuardLogin> {
  TextEditingController Email = new TextEditingController();
  TextEditingController Password = new TextEditingController();

  void login() async {
    String email = Email.text.trim();
    String password = Password.text.trim();
    if (email == "" || password == "") {
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
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          margin: EdgeInsets.only(left: 5, bottom: 2),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Image.asset(
            "images/logo.png",
            fit: BoxFit.cover,
          ),
        ),
        title: const Text(
          "GuardianLock",
          style: TextStyle(fontFamily: "Roboto", fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 182, 220, 238),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 900,
          decoration: const BoxDecoration(color: Colors.white
              // gradient: LinearGradient(
              //   colors: [
              //     Colors.blue,
              //     Colors.white,
              //   ],
              // ),
              ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(400),
                ),
                height: 300,
                child: Image.asset("images/User.png"),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: Email,
                      decoration: InputDecoration(
                        hintText: "User login",
                        label: const Text(
                          "Email",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.black, width: 3),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: Password,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        label: const Text(
                          "Userpassword",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.black, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  login();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff5b6378),
                      border: Border.all(color: Colors.black)),
                  height: 50,
                  width: 100,
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "New here ?? ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GuardRegis()),
                      );
                    },
                    child: const Text(
                      "Register Now !!",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
