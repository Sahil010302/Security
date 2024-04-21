import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VisitorForm extends StatefulWidget {
  const VisitorForm({Key? key}) : super(key: key);

  @override
  _VisitorFormState createState() => _VisitorFormState();
}

class _VisitorFormState extends State<VisitorForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController whomToVisitController = TextEditingController();
  TextEditingController fromController = TextEditingController();

  void showRegistrationSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(15),
        content: Text(
          "Visitor details submitted successfully!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void submitVisitorForm() async {
    String name = nameController.text.trim();
    String mobile = mobileController.text.trim();
    String whomToVisit = whomToVisitController.text.trim();
    String from = fromController.text.trim();

    if (name.isNotEmpty &&
        mobile.isNotEmpty &&
        whomToVisit.isNotEmpty &&
        from.isNotEmpty) {
      await FirebaseFirestore.instance.collection('Visitors').add({
        'name': name,
        'mobile': mobile,
        'whomToVisit': whomToVisit,
        'from': from,
        'timestamp': DateTime.now(),
      });

      showRegistrationSnackBar();

      nameController.clear();
      mobileController.clear();
      whomToVisitController.clear();
      fromController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(15),
          content: Text(
            "Please fill in all fields!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visitor Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vendorDetails(
              controller: nameController,
              hintText: 'Enter Visitor\'s Name',
              labelText: 'Name',
              icon: Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            vendorDetails(
              controller: mobileController,
              hintText: 'Enter Mobile Number',
              labelText: 'Mobile Number',
              icon: Icon(
                Icons.phone,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            vendorDetails(
              controller: whomToVisitController,
              hintText: 'Whom to Visit',
              labelText: 'Whom to Visit',
              icon: Icon(
                Icons.person_pin,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            vendorDetails(
              controller: fromController,
              hintText: 'From',
              labelText: 'From',
              icon: Icon(
                Icons.location_on,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitVisitorForm,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField vendorDetails(
      {required TextEditingController controller,
      required String hintText,
      required String labelText,
      required Icon icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Color.fromARGB(255, 16, 63, 101)),
        icon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Visitor Form'),
      ),
      body: VisitorForm(),
    ),
  ));
}
