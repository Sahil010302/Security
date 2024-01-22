import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:security/Guard/home.dart';
import 'package:security/Guard/verify.dart';

class UpdateDetails extends StatefulWidget {
  const UpdateDetails({super.key});

  @override
  State<UpdateDetails> createState() => _UpdateDetailsState();
}

class _UpdateDetailsState extends State<UpdateDetails> {
  var vendorList = [
    '01) MilkMan',
    '02) NewsPaper',
    '03) Maid',
    '04) CarWashing',
    '05) Laundary',
    '06) Tutorial'
  ];
  var currentselected;
  TextEditingController updateFlatNo = new TextEditingController();
  TextEditingController ID = new TextEditingController();
  TextEditingController Pin = new TextEditingController();

  void updateVendor() async {
    String pinNo = Pin.text.trim();
    String id = ID.text.trim();

    var maidSnapshot = await FirebaseFirestore.instance
        .collection('Vendor')
        .doc(id)
        .collection(currentselected)
        .doc(pinNo)
        .get();
    if (maidSnapshot.exists) {
      // Maid already exists, update the flat number
      List<dynamic> flatNo = maidSnapshot.data()?['flatNo'] ?? [];
      String newFlatNumber = updateFlatNo.text.trim();

      if (!flatNo.contains(newFlatNumber)) {
        flatNo.add(newFlatNumber);
        await FirebaseFirestore.instance
            .collection('Vendor')
            .doc(id)
            .collection(currentselected)
            .doc(pinNo)
            .update({
          'flatNo': flatNo,
        });
        updateFlatNo.clear();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Details updated successfully ',
          autoCloseDuration: const Duration(seconds: 3),
          showConfirmBtn: false,
        );
        Timer(
          const Duration(seconds: 3),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
        );
        // Maid details updated
        print('Maid details updated');
      } else {
        // Flat number already associated with this maid
        print('Flat number already associated with this maid');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Update Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 182, 220, 238),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: vendorDetails(
                controller: updateFlatNo,
                hinttext: "Add the flat no the vendor is visiting",
                labletext: "Flat No",
                icons: const Icon(
                  CupertinoIcons.house,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: vendorDetails(
                controller: ID,
                hinttext: "Enter Id of the vendor",
                labletext: "ID ",
                icons: const Icon(
                  CupertinoIcons.number,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: vendorDetails(
                controller: Pin,
                hinttext: "Enter Pin No",
                labletext: "Pin No",
                icons: const Icon(
                  CupertinoIcons.pin,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.only(top: 10, left: 45, right: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Category",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 16, 63, 101)),
                  ),
                  DropdownButton<String>(
                    items: vendorList
                        .map(
                          (String dropdown) => DropdownMenuItem<String>(
                            value: dropdown,
                            child: Text(dropdown),
                          ),
                        )
                        .toList(),
                    onChanged: (news) {
                      setState(() {
                        currentselected = news.toString();
                        print(currentselected);
                      });
                    },
                    value: currentselected,
                    hint: const Text("Select"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith(
                            (states) =>
                                const Color.fromARGB(255, 216, 163, 159)),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancle",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith(
                          (states) => const Color.fromARGB(255, 152, 167, 173),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => const Color.fromARGB(255, 182, 220, 238),
                        ),
                      ),
                      onPressed: () {
                        updateVendor();
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
