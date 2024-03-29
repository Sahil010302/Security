import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:security/const.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var time = DateTime.now();
  var date;
  var checkIn_Time;
  var checkOut_Time;
  Update() {
    FirebaseFirestore.instance
        .collection("CheckIn")
        .doc(date)
        .collection(date)
        .doc(checkIn_Time)
        .update(
      {
        "Checkout": checkOut_Time,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime checkinDate =
        DateTime(time.year, time.month, time.day); // 2024-01-27 00:00:00.000
    // Formated time this is use to get only date from both date aand time
    String formattedDate =
        '${time.year}-${_twoDigits(time.month)}-${_twoDigits(time.day)}'; // 2024-01-27
    date = formattedDate;
    String formattedTime = '${time.hour}:${_twoDigits(time.minute)}';
    checkOut_Time = formattedTime;

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
              Container(
                  margin: const EdgeInsets.all(5),
                  child: RichText(
                    text: TextSpan(
                      text: 'Current Date : ',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Oswald'),
                      children: <TextSpan>[
                        TextSpan(
                          text: formattedDate.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  )),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("CheckIn")
                    .doc(date)
                    .collection(date)
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
                                  // color: const Color.fromARGB(255, 116, 184, 215),
                                  color: Color.fromARGB(248, 209, 208, 208),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black)),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Image.network(
                                            checkinVendors["profilePic"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        margin: const EdgeInsets.all(2),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "NAME: ${checkinVendors["name"]}",
                                              style: checkin,
                                            ),
                                            Text(
                                              "Flat No : ${checkinVendors["flatNo"]}",
                                              style: checkin,
                                            ),
                                            Text(
                                              "Category: ${checkinVendors["category"]} ",
                                              style: checkin,
                                            ),
                                            Text(
                                              "Check In Time:  ${checkinVendors["Checkin"]} ",
                                              style: checkin,
                                            ),
                                            Text(
                                              "Check Out Time: ${checkinVendors["Checkout"]}",
                                              style: checkin,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.pink,
                                      onTap: () {
                                        checkIn_Time =
                                            checkinVendors["Checkin"];
                                        print(checkIn_Time);

                                        setState(
                                          () {
                                            Update();
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 18),
                                        height: 35,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "OUT",
                                            style: TextStyle(
                                              fontFamily: "Oswald",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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

String _twoDigits(int n) {
  if (n >= 10) return '$n';
  return '0$n';
}
