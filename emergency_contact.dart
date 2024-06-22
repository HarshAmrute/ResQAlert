// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Contact {
//   final String name;
//   final String phoneNumber;

//   Contact({required this.name, required this.phoneNumber});
// }

// class EmergencyContactsApp extends StatefulWidget {
//   final List<Contact> emergencyContacts = [
//     Contact(name: 'Police', phoneNumber: '100'),
//     Contact(name: 'Fire Department', phoneNumber: '101'),
//     Contact(name: 'Ambulance', phoneNumber: '102'),
//     Contact(name: 'Women Helpline', phoneNumber: '1091'),
//     Contact(name: 'Medical Emergency', phoneNumber: '108'),
//     Contact(name: 'Electricity Emergency', phoneNumber: '1912'),
//     Contact(name: 'Disaster Management', phoneNumber: '1070'),
//     Contact(name: 'Child Helpline', phoneNumber: '1098'),
//     Contact(name: 'Melvin', phoneNumber: '8369154319'),
//     // Add more emergency contacts as needed
//   ];

//   @override
//   _EmergencyContactsAppState createState() => _EmergencyContactsAppState();
// }

// class _EmergencyContactsAppState extends State<EmergencyContactsApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Emergency Contacts',
//       theme: ThemeData(
//         primaryColor: Colors.red,
//         colorScheme: ColorScheme.fromSwatch().copyWith(
//           secondary: Colors.white,
//         ),
//       ),
//       debugShowCheckedModeBanner: false, // Remove the debug banner
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Emergency Contacts'),
//           leading: BackButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.red[400]!, Colors.red[800]!],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: ListView.builder(
//             itemCount: widget.emergencyContacts.length,
//             itemBuilder: (context, index) {
//               final contact = widget.emergencyContacts[index];
//               return Card(
//                 elevation: 8,
//                 shadowColor: Colors.redAccent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ListTile(
//                   title: Text(
//                     contact.name,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     'Call: ${contact.phoneNumber}',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                   trailing: IconButton(
//                     icon: Icon(Icons.phone, color: Colors.red),
//                     onPressed: () {
//                       callEmergencyNumber(contact.phoneNumber);
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   void callEmergencyNumber(String phoneNumber) async {
//     String uri = 'tel:$phoneNumber';
//     if (await canLaunch(uri)) {
//       await launch(uri);
//     } else {
//       throw 'Could not launch $uri';
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}

class EmergencyContactsApp extends StatefulWidget {
  final List<Contact> emergencyContacts = [
    Contact(name: 'Police', phoneNumber: '100'),
    Contact(name: 'Fire Department', phoneNumber: '101'),
    Contact(name: 'Ambulance', phoneNumber: '102'),
    Contact(name: 'Women Helpline', phoneNumber: '1091'),
    Contact(name: 'Medical Emergency', phoneNumber: '108'),
    Contact(name: 'Electricity Emergency', phoneNumber: '1912'),
    Contact(name: 'Disaster Management', phoneNumber: '1070'),
    Contact(name: 'Child Helpline', phoneNumber: '1098'),
    Contact(name: 'Melvin', phoneNumber: '8369154319'),
    // Add more emergency contacts as needed
  ];

  @override
  _EmergencyContactsAppState createState() => _EmergencyContactsAppState();
}

class _EmergencyContactsAppState extends State<EmergencyContactsApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency Contacts',
      theme: ThemeData(
        primaryColor: Colors.red,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Text('Emergency Contacts'),
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red[400]!, Colors.red[800]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView.builder(
            itemCount: widget.emergencyContacts.length,
            itemBuilder: (context, index) {
              final contact = widget.emergencyContacts[index];
              return Card(
                elevation: 8,
                shadowColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    contact.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Call: ${contact.phoneNumber}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.phone, color: Colors.red),
                    onPressed: () {
                      callEmergencyNumber(contact.phoneNumber);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void callEmergencyNumber(String phoneNumber) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (e) {
      print(e);
    }
  }
}
