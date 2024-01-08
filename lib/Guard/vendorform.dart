import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:security/Guard/home.dart';

class VendorForm extends StatefulWidget {
  const VendorForm({super.key});

  @override
  State<VendorForm> createState() => _VendorFormState();
}

class _VendorFormState extends State<VendorForm> {
  TextEditingController Name = new TextEditingController();
  TextEditingController Date = new TextEditingController();
  TextEditingController Time = new TextEditingController();
  TextEditingController VisitingTo = new TextEditingController();
  TextEditingController BuildinagName = new TextEditingController();
  TextEditingController Flatno = new TextEditingController();

  void Vendor() async {
    String name = Name.text.trim();
    String date = Date.text.trim();
    String time = Time.text.trim();
    String visiting = VisitingTo.text.trim();
    String buildingname = BuildinagName.text.trim();
    String flatno = Flatno.text.trim();

    if (name != "" &&
        date != "" &&
        time != "" &&
        visiting != "" &&
        buildingname != "" &&
        flatno != "") {
      Map<String, dynamic> Vendors = {
        "name": name,
        "time": time,
        "visiting": visiting,
        "flatNo": flatno,
        "date": date,
        "buldingName": buildingname
      };
      await FirebaseFirestore.instance.collection("Vendor").add(Vendors);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    } else {
      print("Fill all the fields ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 182, 220, 238),
        title: Text("Vendor Form"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                  "Vendors Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              const Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      "https://www.pngall.com/wp-content/uploads/5/Profile.png",
                    ),
                  ),
                  Positioned(
                    top: 90,
                    left: 90,
                    child: Icon(
                      CupertinoIcons.photo_camera_solid,
                      color: Colors.grey,
                      shadows: [
                        Shadow(
                          blurRadius: 10.1,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: Name,
                hinttext: "Enter Vendors Name",
                labletext: "Name",
                icons: const Icon(
                  CupertinoIcons.person,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: VisitingTo,
                hinttext: "Enter Name OF The Person Vendor Is Visiting To ",
                labletext: "Visiting To",
                icons: const Icon(
                  CupertinoIcons.person_2,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: BuildinagName,
                hinttext: "Enter Building Name  ",
                labletext: "Building Name",
                icons: const Icon(
                  CupertinoIcons.building_2_fill,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: Flatno,
                hinttext: "Enter Flat Details ",
                labletext: "Flat Number",
                icons: const Icon(
                  CupertinoIcons.home,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: Date,
                hinttext: "22-02-2023 ",
                labletext: "Date",
                icons: const Icon(
                  CupertinoIcons.sun_dust,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: Time,
                hinttext: " 9:55 am",
                labletext: "Time",
                icons: const Icon(
                  CupertinoIcons.time,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Vendor();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 182, 220, 238),
                  ),
                  height: 60,
                  width: 120,
                  child: const Center(
                      child: Text(
                    "SUBMIT",
                    style: TextStyle(fontSize: 22),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
}
