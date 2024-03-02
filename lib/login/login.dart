import 'package:flutter/material.dart';
import 'package:security/login/gardLogin.dart';
import 'package:security/login/user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: 
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color.fromARGB(255, 156, 196, 214)],
            ),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 40,
            ),
            
            Container(
              margin: const EdgeInsets.only(left: 18),
              height: 350,
              child: Image.asset(
                "images/logo1.png",
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              "GuardianLock",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(
              child: Text(
                "Effortless Living, One App Away.!!",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 21,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                print("Guard");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GuardLogin(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                  ),
                ),
                height: 80,
                width: 180,
                child: const Center(
                  child: Text(
                    "GUARD",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserLogin(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                height: 80,
                width: 180,
                child: const Center(
                  child: Text(
                    "USER",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
