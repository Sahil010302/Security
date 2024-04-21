import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VisitorLogs extends StatefulWidget {
  const VisitorLogs({Key? key}) : super(key: key);

  @override
  _VisitorLogsState createState() => _VisitorLogsState();
}

class _VisitorLogsState extends State<VisitorLogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset(
                "images/flogo.png",
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "Visitor Logs",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Visitors').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var visitorData = snapshot.data!.docs;
              List<Widget> visitorList = [];

              for (var visitor in visitorData) {
                var visitorName = visitor['name'];
                var visitorMobile = visitor['mobile'];
                var whomToVisit = visitor['whomToVisit'];
                var from = visitor['from'];
                var timestamp = (visitor['timestamp'] as Timestamp).toDate();

                var visitorCard = Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      'Name: $visitorName',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mobile: $visitorMobile'),
                        Text('Whom to Visit: $whomToVisit'),
                        Text('From: $from'),
                        Text('Timestamp: $timestamp'),
                      ],
                    ),
                  ),
                );

                visitorList.add(visitorCard);
              }

              return ListView(
                children: visitorList,
              );
            },
          ),
        ),
      ),
    );
  }
}
