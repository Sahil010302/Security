import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String Id;
  final String code;
  final String current;
  Details(
      {required String this.Id,
      required String this.code,
      required String this.current});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    fetchDetails();
    // TODO: implement initState
    super.initState();
  }

  String Name = "";
  String Adhadno = "";
  String PhoneNumber = "";
  String BuildingName = "";
  List FlatNo = [];
  String url = "";

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
        List<dynamic> flatNo = List.from(
          data['flatNo'] as List<dynamic>? ?? [],
        );
        String adharCard = data['adharCard'] ?? "";
        String name = data['name'] ?? "";
        String date = data['date'] ?? "";
        String phoneNumber = data['phoneNumber'] ?? "";
        String buildingName = data['buldingName'] ?? "";
        String profilePic = data['profilePic'] ?? "";

        setState(() {
          Name = name;
          Adhadno = adharCard;
          PhoneNumber = phoneNumber;
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 182, 220, 238),
        title: const Text("Vendor Details"),
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
                          const TextSpan(text: "Phone Number :"),
                          TextSpan(
                            text: PhoneNumber,
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
            ],
          ),
        ),
      )),
    );
  }
}
