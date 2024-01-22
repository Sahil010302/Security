import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:security/Guard/home.dart';

class CheckIn extends StatefulWidget {
  final String Id;
  final String code;
  final String current;
  CheckIn(
      {required String this.Id,
      required String this.code,
      required String this.current});

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  void initState() {
    fetchDetails();

    super.initState();
  }

  String Name = "";
  String Adhadno = "";
  String VisitingTo = "";
  String BuildingName = "";
  List FlatNo = [];
  String url = "";
  late DateTime checkIn;

  void Checkin() async {
    Map<String, dynamic> checkinn = {
      "name": Name,
      "profilePic": url,
      "Checkin": checkIn,
      "checkout": "",
      "category": widget.current,
      "flatNo": FlatNo[0],
    };
    await FirebaseFirestore.instance
        .collection("CheckIn")
        .doc(FlatNo[0])
        .set(checkinn);

    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: ' successfully ',
      autoCloseDuration: const Duration(seconds: 3),
      showConfirmBtn: false,
    );

    Timer(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    });
  }

  void fetchDetails() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Vendor")
        .doc(widget.Id)
        .collection(widget.current)
        .doc(widget.code)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        String pin = data['pin'] ?? "";
        String time = data['time'] ?? "";
        List<dynamic> flatNo =
            List.from(data['flatNo'] as List<dynamic>? ?? []);
        String adharCard = data['adharCard'] ?? "";
        String name = data['name'] ?? "";
        String date = data['date'] ?? "";
        String visiting = data['visiting'] ?? "";
        String buildingName = data['buldingName'] ?? "";
        String profilePic = data['profilePic'] ?? "";

        setState(() {
          Name = name;
          Adhadno = adharCard;
          VisitingTo = visiting;
          BuildingName = buildingName;
          FlatNo = flatNo;
          url = profilePic;
        });
      }
    } else {
      print("Document does not exist");
    }
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 182, 220, 238),
        title: const Text("Verify Details"),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(12),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(url),
                  radius: 90,
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        children: [
                          const TextSpan(text: "Name: "),
                          TextSpan(
                            text: Name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        children: [
                          const TextSpan(text: "AdharCard No:"),
                          TextSpan(
                            text: Adhadno,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        children: [
                          const TextSpan(text: "Visiting To :"),
                          TextSpan(
                            text: VisitingTo,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        children: [
                          const TextSpan(text: "Building Name :"),
                          TextSpan(
                            text: BuildingName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        children: [
                          const TextSpan(text: "Flat No: "),
                          ...FlatNo.map(
                            (flat) => TextSpan(
                              text: '$flat ',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.red),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Cancle",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.green),
                    ),
                    onPressed: () {
                      setState(() {
                        checkIn = time;
                      });
                      Checkin();
                    },
                    child: const Text(
                      "Check In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
