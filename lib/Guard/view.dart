import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatelessWidget {
  const ViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          margin: EdgeInsets.only(left: 5, bottom: 2),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Image.asset(
            "images/logo.png",
            fit: BoxFit.cover,
          ),
        ),
        title: const Text(
          "GuardianLock",
          style: TextStyle(fontFamily: "Roboto", fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 182, 220, 238),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Vendor").snapshots(),
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
                                color: const Color.fromARGB(255, 116, 184, 215),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ListTile(
                                trailing:
                                    const Icon(CupertinoIcons.chevron_right),
                                leading: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      "https://www.pngall.com/wp-content/uploads/5/Profile.png"),
                                ),
                                title: Text(vendorss["name"]),
                                subtitle: Text(vendorss["buldingName"]),
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
