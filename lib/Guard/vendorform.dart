import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:security/Guard/home.dart';
import 'package:quickalert/quickalert.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';

class VendorForm extends StatefulWidget {
  const VendorForm({super.key});

  @override
  State<VendorForm> createState() => _VendorFormState();
}

class _VendorFormState extends State<VendorForm> {
  TextEditingController Name = new TextEditingController();
  TextEditingController Date = new TextEditingController();
  TextEditingController BuildinagName = new TextEditingController();
  TextEditingController Flatno = new TextEditingController();
  TextEditingController AdharCard = new TextEditingController();
  TextEditingController Pin = new TextEditingController();
  TextEditingController ID = new TextEditingController();
  TextEditingController PhoneNumber = new TextEditingController();
  TextEditingController updateFlatNo = new TextEditingController();
  File? profilepic;

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  var vendorList = [
    '01) MilkMan',
    '02) NewsPaper',
    '03) Maid',
    '04) CarWashing',
    '05) Laundary',
    '06) Tutorial'
  ];
  var currentselected;

  void Vendor(BuildContext ctx) async {
    String name = Name.text.trim();
    String date = Date.text.trim();

    String buildingname = BuildinagName.text.trim();
    String flatno = Flatno.text.trim();
    String updateFlatno = updateFlatNo.text.trim();
    String adharCard = AdharCard.text.trim();
    String pinNo = Pin.text.trim();
    String id = ID.text.trim();
    String phoneNumber = PhoneNumber.text.trim();

    if (name != "" &&
        date != "" &&
        buildingname != "" &&
        flatno != "" &&
        adharCard != "" &&
        pinNo != "" &&
        id != "" &&
        profilepic != null) {
      UploadTask uploadtask = FirebaseStorage.instance
          .ref()
          .child("profilepic")
          .child(Uuid().v1())
          .putFile(profilepic!);

      TaskSnapshot taskSnapshot = await uploadtask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection("Vendor")
          .doc(id)
          .collection(currentselected)
          .doc(pinNo)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            text: 'Vendor already exist !! Plzz update the details',
            confirmBtnText: "Update",
            onConfirmBtnTap: () => _show(ctx),
            cancelBtnText: "Cancle",
            showCancelBtn: true,
            onCancelBtnTap: () => Navigator.pop(context),
            cancelBtnTextStyle:
                const TextStyle(color: Colors.red, fontSize: 20),
          );
        } else {
          Map<String, dynamic> Vendors = {
            "name": name,
            "flatNo": [flatno],
            "date": date,
            "profilePic": downloadUrl,
            "buldingName": buildingname,
            "adharCard": adharCard,
            "pin": pinNo,
            "phoneNumber": phoneNumber, 
          };
          FirebaseFirestore.instance
              .collection("Vendor")
              .doc(id)
              .collection(currentselected)
              .doc(pinNo)
              .set(Vendors);

          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Details inserted successfully ',
            autoCloseDuration: const Duration(seconds: 3),
            showConfirmBtn: false,
          );
          Timer(
            const Duration(seconds: 4),
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
          );
        }
      });
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: 'Fill All The Fields..Plzz',
        confirmBtnText: "Error",
        autoCloseDuration: const Duration(seconds: 3),
        showConfirmBtn: false,
      );
    }

/*
    FirebaseFirestore.instance
        .collection("Vendor")
        .doc(id)
        .collection(currentselected)
        .doc(pinNo)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'Vendor already exist !! Plzz update the details',
          confirmBtnText: "Update",
          onConfirmBtnTap: () => _show(ctx),
          cancelBtnText: "Cancle",
          showCancelBtn: true,
          onCancelBtnTap: () => Navigator.pop(context),
          cancelBtnTextStyle: const TextStyle(color: Colors.red, fontSize: 20),
        );
      } else {
        //print('Document does not exists in the database');
      }
      
    });
    */
  }

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

  void _show(BuildContext ctx) async {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        builder: (ctx) => Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    "Update Details",
                    style: TextStyle(fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.red),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancle",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
                                (states) =>
                                    const Color.fromARGB(255, 152, 167, 173),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) =>
                                    const Color.fromARGB(255, 182, 220, 238),
                              ),
                            ),
                            onPressed: () {
                              updateVendor();
                            },
                            child: const Text(
                              "Update",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 182, 220, 238),
        title: const Text("Vendor Form"),
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
              Stack(
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          (profilepic != null) ? FileImage(profilepic!) : null),
                  GestureDetector(
                    onTap: () async {
                      XFile? selectedImage = await ImagePicker()
                          .pickImage(source: ImageSource.camera);

                      if (selectedImage != null) {
                        File convertfile = File(selectedImage.path);
                        setState(() {
                          profilepic = convertfile;
                        });

                        print("file selected");
                      } else {
                        print("File is not selected ");
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 90, top: 90),
                      child: const Icon(
                        CupertinoIcons.photo_camera_solid,
                        color: Colors.grey,
                        shadows: [
                          Shadow(
                            blurRadius: 10.1,
                          )
                        ],
                      ),
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
                controller: PhoneNumber, 
                hinttext: "Enter Phone Number", 
                labletext: "Phone Number", 
                icons: const Icon(
                  CupertinoIcons.phone,
                  color: Colors.blue,
                ),
              ),
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
                      width: 8,
                    ),
                    const Text(
                      "Category",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 16, 63, 101)),
                    ),
                    const SizedBox(
                      width: 100,
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
                height: 10,
              ),
              vendorDetails(
                controller: ID,
                hinttext: "Enter the category id",
                labletext: "ID",
                icons: const Icon(
                  CupertinoIcons.pin_fill,
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
                labletext: "Registration Date",
                icons: const Icon(
                  CupertinoIcons.sun_dust,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: AdharCard,
                hinttext: "Enter Adharcard No ",
                labletext: "AdharCard NO",
                icons: const Icon(
                  CupertinoIcons.bookmark,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              vendorDetails(
                controller: Pin,
                hinttext: "Enter 4 digit pin .eg: last 4 digit of adharcard ",
                labletext: "Pin",
                icons: const Icon(
                  CupertinoIcons.pin,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Vendor(context);
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

  TextField vendorDetails({
  required String hinttext,
  required String labletext,
  required Icon icons,
  required TextEditingController controller,
}) {
    return TextField(
    controller: controller,
    keyboardType: labletext == "Phone Number" ? TextInputType.phone : null,
    inputFormatters: labletext == "Phone Number" ? <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly // Allow only digits
    ] : null,
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