import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  var vendorList = [
    '01) MilkMan',
    '02) NewsPaper',
    '03) Maid',
    '04) CarWashing'
  ];
  var currentselected;
  TextEditingController code = new TextEditingController();
  TextEditingController id = new TextEditingController();

  void VerifyVendor() async {
    String Code = code.text.toString();
    String ID = id.text.toString();

    FirebaseFirestore.instance
        .collection("Vendor")
        .doc(ID)
        .collection(currentselected)
        .where(Code,
            isEqualTo: FirebaseFirestore.instance
                .collection("Vendor")
                .doc(ID)
                .collection(currentselected)
                .doc(Code)
                .get());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 182, 220, 238),
        title: const Text("Verify Details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 12, left: 45),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Category",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 16, 63, 101)),
                    ),
                    const SizedBox(
                      width: 130,
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
                      hint: Text("Select"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: id,
                hinttext: "Enter Vendors Name",
                labletext: "ID",
                icons: const Icon(
                  CupertinoIcons.person,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: id,
                hinttext: "Enter Vendors Name",
                labletext: "Code",
                icons: const Icon(
                  CupertinoIcons.person,
                  color: Colors.blue,
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}

TextField vendorDetails(
    {required String hinttext,
    required String labletext,
    required Icon icons,
    required TextEditingController controller}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hinttext,
      labelText: labletext,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 16, 63, 101)),
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
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    ),
  );
}
