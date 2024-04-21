
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:security/splash_screen.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
   // home: (FirebaseAuth.instance.currentUser != null)
     //    ? Home()
       //  : LoginPage(),
    // routes: {
    //'/login': (context) => GuardLogin(), // Replace LoginPage with your actual login page widget
    // Other routes...
  //},    
      
          
      
    );
  }
}
