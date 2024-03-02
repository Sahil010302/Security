import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security/Guard/checkout.dart';
import 'package:security/Guard/home.dart';

import 'package:security/Guard/updatedetails.dart';
import 'package:security/Guard/vendorform.dart';
import 'package:security/Guard/verify.dart';
import 'package:security/Guard/view.dart';
import 'package:security/User/home.dart';
import 'package:security/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBDUXGfoOaO-MqUvUXrXYXPvCDnZ3fwHcI",
      appId: "1:811120906245:android:181d13aed0abe56b1e8c6c",
      messagingSenderId: "811120906245",
      projectId: "security-1d5b8",
      storageBucket: 'security-1d5b8.appspot.com',
    ),
  );

  Map<String, dynamic> newUsers = {"name": "Tejas Dongre", "age": 23};

  await FirebaseFirestore.instance.collection("User").add(newUsers);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null)
          ? Home()
          : LoginPage(),
      // home: Checkout(),
          
      // home: LoginPage(),
    );
  }
}
