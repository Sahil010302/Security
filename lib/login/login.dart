import 'package:flutter/material.dart';
import 'package:security/login/user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fa),
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 18),
            height: 350,
            child: Image.asset(
              "images/logo.png",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            child: Text(
              "Effortless Living, One App Away.",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              print("Guard");
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff5b6378),
              ),
              height: 80,
              width: 180,
              child: const Center(
                child: Text(
                  "GUARD",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("User");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserLogin()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 177, 180, 183),
              ),
              height: 80,
              width: 180,
              child: const Center(
                child: Text(
                  "USER",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
