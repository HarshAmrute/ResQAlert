import 'package:flutter/material.dart';
import 'emergency_contact.dart';
import 'Nearby Maps/hospital_map_page.dart';
import 'Nearby Maps/police_map_page.dart';
import 'Nearby Maps/fire_station_map_page.dart';
//import 'profile.dart'; // Import your ProfilePage
import 'login_page.dart'; // Import your LoginPage

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Text(
          'App by Melvin Antony, Aditya Kate and Harsh Amrute\n'
          'from Don Bosco Institute of Technology, Mumbai\n'
          'SE Computer Engineering department\n'
          '2024- Class\n'
          'Version 1.0.0',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: Text(
              'ResQalert',
              style: TextStyle(
                fontSize: 27,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.red,
            ),
            title: Text('Profile'),
            onTap: () {
              // Handle profile button press
              print('Profile button pressed');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => (LoginPage())),
              );
            },
          ),
          // Replaced "Login" with "Enter Personal Info"
          ListTile(
            leading: Icon(
              Icons.login,
              color: Colors.red,
            ),
            title: Text('Enter Personal Info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contacts,
              color: Colors.red,
            ),
            title: Text('Emergency Contact List'),
            onTap: () {
              // Handle emergency contact list button press
              print('Emergency Contact List button pressed');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmergencyContactsApp()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.local_hospital,
              color: Colors.red,
            ),
            title: Text('Hospitals'),
            onTap: () {
              // Handle hospitals button press
              print('Hospitals button pressed');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HospitalMapPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.local_police,
              color: Colors.red,
            ),
            title: Text('Police Stations'),
            onTap: () {
              // Handle police stations button press
              print('Police stations button pressed');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PoliceStationMapPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.fire_truck,
              color: Colors.red,
            ),
            title: Text('Fire Stations'),
            onTap: () {
              // Handle fire stations button press
              print('Fire Stations button pressed');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FireStationMapPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.red,
            ),
            title: Text('About Us'),
            onTap: () {
              // Handle about us button press
              print('About Us button pressed');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
