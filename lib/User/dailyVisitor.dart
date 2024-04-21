import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Visiting extends StatefulWidget {
  @override
  State<Visiting> createState() => _VisitingState();
}

class _VisitingState extends State<Visiting> {
  Future<String?> getCurrentUserFlatNumber() async {
    String? flatNumber;

    // Check if a user is currently logged in
    User? user = FirebaseAuth.instance.currentUser;
    print(user?.email);
    if (user != null) {
      // Get the user's document from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection("UserDetails")
          .doc(user.email)
          .get();

      // Retrieve the flat number from the document
      if (userDoc.exists) {
        // Assuming the flat number is stored under the field "FlatNo"
        flatNumber = userDoc.data()?['workAt'];
        print(flatNumber);
      }
    }

    return flatNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          margin: const EdgeInsets.only(left: 5, bottom: 2),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Image.asset(
            "images/logo1.png",
            fit: BoxFit.cover,
          ),
        ),
        title: const Text(
          "Daily Logs",
          style: TextStyle(fontFamily: "Roboto", fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 182, 220, 238),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Visiting")
                    .doc("601")
                    .collection('601')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> vendorss =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;

                            return Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 116, 184, 215),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 167, 198, 224),
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  height: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "NAME : ${vendorss['name']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "Check in time  : ${vendorss['Checkin']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        "Check out time : ${vendorss['Checkout']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Category : ${vendorss['category']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      );
                    } else {
                      return Text("No Data");
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}