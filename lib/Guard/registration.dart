import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security/login/user.dart';

class UserRegi extends StatefulWidget {
  const UserRegi({super.key});

  @override
  State<UserRegi> createState() => _UserRegiState();
}

class _UserRegiState extends State<UserRegi> {
  TextEditingController Email = new TextEditingController();
  TextEditingController Password = new TextEditingController();
  TextEditingController cPassword = new TextEditingController();

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
              context, MaterialPageRoute(builder: (context) => UserLogin()));
        }
      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      appBar: AppBar(
        title: const Text(
          "User Registration",
          style: TextStyle(fontFamily: "Roboto", fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xfff5f6fa),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text(
                        "First Name",
                        style: TextStyle(
                          color: Color.fromARGB(255, 107, 101, 101),
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text(
                        "Last Name",
                        style: TextStyle(
                          color: Color.fromARGB(255, 107, 101, 101),
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: Email,
                    decoration: InputDecoration(
                      label: const Text(
                        "Email",
                        style: TextStyle(
                          color: Color.fromARGB(255, 107, 101, 101),
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      label: const Text(
                        "Flat Number",
                        style: TextStyle(
                          color: Color.fromARGB(255, 107, 101, 101),
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: Password,
                    decoration: InputDecoration(
                      label: const Text(
                        "Password",
                        style: TextStyle(
                          color: Color.fromARGB(255, 107, 101, 101),
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: cPassword,
                    decoration: InputDecoration(
                      label: const Text(
                        "Confirm Password",
                        style: TextStyle(
                          color: Color.fromARGB(255, 107, 101, 101),
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Createaccount();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff5b6378),
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
    );
  }
}




//******************************************** */


