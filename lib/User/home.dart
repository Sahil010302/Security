import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:security/Guard/updatedetails.dart';
import 'package:security/Guard/vendorform.dart';
import 'package:security/Guard/view.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              "https://images.pexels.com/photos/2380794/pexels-photo-2380794.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
              fit: BoxFit.cover,
            ),
          ),
        ),
        automaticallyImplyLeading: true,
        // title: const Text(
        //   "Hello!! Manoj Pandey",
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        // ),
        // centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: ListTile(
            title: Text("Hello!! Manoj Pandey. "),
            titleTextStyle: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            subtitle: Text("Flat No 101"),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 182, 220, 238),
      ),
      endDrawer: Drawers(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  VendorsContainer(
                    "01) MilkMan",
                    "milkman.png",
                    context,
                    "01",
                  ),
                  VendorsContainer(
                    "02) NewsPaper",
                    "newspaper.jpg",
                    context,
                    "02",
                  ),
                  VendorsContainer(
                    "03) Maid",
                    "maid.png",
                    context,
                    "03",
                  ),
                  VendorsContainer(
                    "04) CarWashing",
                    "car.png",
                    context,
                    "04",
                  ),
                  VendorsContainer(
                    "05) Laundary",
                    "laundary.jpg",
                    context,
                    "05",
                  ),
                  VendorsContainer(
                    "06) Tutorial",
                    "tutorial.jpg",
                    context,
                    "06",
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            height: 170,
            width: 500,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 182, 220, 238),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: const Column(
              children: [
                Text(
                  "Important Notices",
                  style: TextStyle(
                    fontFamily: "Oswald",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Notice1."),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text("Notice!"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget VendorsContainer(
    String name,
    String image,
    BuildContext context,
    String id,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) =>
                      ViewDetails(id: id, vendorCategory: name))));
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: const Color.fromARGB(255, 182, 220, 238),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Image.asset("images/${image}"),
              ),
              Text(name)
            ],
          ),
        ),
      ),
    );
  }
}

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    void signUserOut() async {
      FirebaseAuth.instance.signOut().then((value) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    }

    final user = FirebaseAuth.instance.currentUser!;
    String email = user.email.toString();
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  "https://icon-library.com/images/profile-icon-vector/profile-icon-vector-7.jpg",
                ),
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 182, 220, 238),
              ),
              accountName: const Text(
                // user.displayName!,
                "Manoj Pandey",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                user.email!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            listtile("Register Vendor ", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VendorForm(),
                ),
              );
            }),
            Divider(),
            listtile("Update Details", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateDetails(),
                ),
              );
            }),
            Divider(),
            listtile("Daily Logs", () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Verify(),
              //   ),
              // );
            }),
            Divider(),
            listtile("Bills", () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Checkout(),
              //   ),
              // );
            }),
            Divider(),
            listtile(
              "Check Out Log",
              () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Checkout()),
                // );
              },
            ),
            Divider(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.red)),
              onPressed: () {
                signUserOut();
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ListTile listtile(
  String title,
  VoidCallback function,
) {
  return ListTile(
    trailing: IconButton(
      icon: const Icon(
        CupertinoIcons.chevron_right,
      ),
      onPressed: function,
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 21,
        color: Colors.black87,
        fontFamily: "Roboto",
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
