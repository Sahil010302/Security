import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security/Guard/home.dart';
import 'package:security/login/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBDUXGfoOaO-MqUvUXrXYXPvCDnZ3fwHcI",
        appId: "1:811120906245:android:181d13aed0abe56b1e8c6c",
        messagingSenderId: "811120906245",
        projectId: "security-1d5b8"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: (FirebaseAuth.instance.currentUser != null) ? Home() : LoginPage(),
    );
  }
}
