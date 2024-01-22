import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late DateTime checkOut;
  List FlatNo = [];
  void Checkout() async {
    Map<String, dynamic> checkinn = {
      "checkout": checkOut,
    };
    await FirebaseFirestore.instance
        .collection("CheckIn")
        .doc(FlatNo[0])
        .set(checkinn);
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 182, 220, 238),
        title: const Text("CheckIn List"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("CheckIn")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> checkinVendors =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 116, 184, 215),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                trailing: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      checkOut = time;
                                      // FlatNo = checkinVendors["flatNo"];
                                      List<dynamic> FlatNo = List.from(
                                          checkinVendors['flatNo']
                                                  as List<dynamic>? ??
                                              []);
                                    });

                                    // Checkout();
                                    print(FlatNo);
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "OUT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    checkinVendors["profilePic"],
                                  ),
                                ),
                                title: Text(checkinVendors["name"]),
                                subtitle: Text(checkinVendors["category"]),
                              ),
                            );
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
