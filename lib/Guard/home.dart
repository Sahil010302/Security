import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:security/Guard/checkout.dart';
import 'package:security/Guard/logs.dart';
import 'package:security/Guard/updatedetails.dart';
import 'package:security/Guard/vendorform.dart';
import 'package:line_icons/line_icons.dart';
import 'package:security/Guard/verify.dart';
import 'package:security/Guard/view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Home page",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 182, 220, 238),
      ),
      drawer: Drawers(),
      body: SingleChildScrollView(
        
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text(
                  "DAILY VENDORS",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VendorsContainer(
                      image: "milkman.png",
                      name: "Milk Man",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewDetails(
                              id: "01",
                              vendorCategory: '01) MilkMan',
                            ),
                          ),
                        );
                      }),
                  VendorsContainer(
                      image: "newspaper.jpg",
                      name: "Newspaper",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewDetails(
                              id: "02",
                              vendorCategory: '02) NewsPaper',
                            ),
                          ),
                        );
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VendorsContainer(
                      image: "maid.png",
                      name: "Maid",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewDetails(
                              id: "03",
                              vendorCategory: '03) Maid',
                            ),
                          ),
                        );
                      }),
                  VendorsContainer(
                      image: "car.png",
                      name: "Car Washing",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewDetails(
                              id: "04",
                              vendorCategory: '04) CarWashing',
                            ),
                          ),
                        );
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VendorsContainer(
                      image: "laundary.jpg",
                      name: "Laundary",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewDetails(
                              id: "05",
                              vendorCategory: '05) Laundary',
                            ),
                          ),
                        );
                      }),
                  VendorsContainer(
                      image: "tutorial.jpg",
                      name: "Tutorial",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewDetails(
                              id: "06",
                              vendorCategory: '06) Tutorial',
                            ),
                          ),
                        );
                      })
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 22, top: 15),
                child: Text(
                  " XYZ Visitors",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VendorsContainer(
                      image: "Amazon.png",
                      name: "Amazon Delivery",
                      function: () {}),
                  VendorsContainer(
                      image: "Zomato.png",
                      name: "Zomato Delivery",
                      function: () {})
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VendorsContainer(
                      image: "Amazon.png",
                      name: "Amazon Delivery",
                      function: () {}),
                  VendorsContainer(
                      image: "Zomato.png",
                      name: "Zomato Delivery",
                      function: () {})
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom Nav bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Container(
            color: const Color.fromARGB(255, 182, 220, 238),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                backgroundColor: const Color.fromARGB(255, 182, 220, 238),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                  ),
                  GButton(
                    icon: LineIcons.book,
                    text: 'Register',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VendorForm(),
                        ),
                      );
                    },
                  ),
                  GButton(
                    icon: LineIcons.searchengin,
                    text: 'Update',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateDetails(),
                        ),
                      );
                    },
                  ),
                  GButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Verify(),
                        ),
                      );
                    },
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container VendorsContainer(
      {required String image,
      required String name,
      required VoidCallback function}) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 220,
      width: 180,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(60, 229, 228, 228)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset("images/${image}"),
          ),
          Text(
            name,
            style: const TextStyle(
                fontSize: 19,
                // fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 48, 48, 48)),
          ),
          ElevatedButton(onPressed: function, child: Text("View"))
        ],
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
              accountName: Text(
                "Raj",
                style: const TextStyle(
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
            listtile("Vendor Form", () {
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
            listtile("Verify Vendor", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Verify(),
                ),
              );
            }),
            Divider(),
            listtile("Check In", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Checkout(),
                ),
              );
            }),
            Divider(),
            listtile(
              "Check Out Log",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Logs()),
                );
              },
            ),
            Divider(),
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
