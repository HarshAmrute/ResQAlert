// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:share/share.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapController;
//   LatLng _initialCameraPosition = LatLng(0.0, 0.0);

//   @override
//   void initState() {
//     super.initState();
//     _requestLocationPermission();
//   }

//   Future<void> _requestLocationPermission() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Handle denied permission
//       print('Location permission denied');
//     } else if (permission == LocationPermission.deniedForever) {
//       // Handle permanently denied permission
//       print('Location permission permanently denied');
//     } else {
//       // Permission granted, fetch current location
//       _getCurrentLocation();
//     }
//   }

//   Future<void> _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       setState(() {
//         _initialCameraPosition = LatLng(position.latitude, position.longitude);
//       });
//     } catch (e) {
//       print('Could not get the location: $e');
//     }
//   }

//   Future<void> _shareLocation() async {
//     if (_initialCameraPosition != null) {
//       String locationUrl = 'https://www.google.com/maps/search/?api=1&query=${_initialCameraPosition.latitude},${_initialCameraPosition.longitude}';
//       String message = 'Check out my current location: $locationUrl';
//       await Share.share(message);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map with Current Location'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: _shareLocation,
//           ),
//         ],
//       ),
//       body: _initialCameraPosition.latitude == 0.0 && _initialCameraPosition.longitude == 0.0
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition: CameraPosition(target: _initialCameraPosition, zoom: 15),
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//                 controller.showMarkerInfoWindow(MarkerId('currentLocation'));
//               },
//               markers: {
//                 Marker(
//                   markerId: MarkerId('currentLocation'),
//                   position: _initialCameraPosition,
//                   infoWindow: InfoWindow(title: 'Current Location'),
//                 ),
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/share.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng _initialCameraPosition = LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Handle denied permission
      print('Location permission denied');
    } else if (permission == LocationPermission.deniedForever) {
      // Handle permanently denied permission
      print('Location permission permanently denied');
    } else {
      // Permission granted, fetch current location
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _initialCameraPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Could not get the location: $e');
    }
  }

  Future<void> _shareLocation() async {
    if (_initialCameraPosition != null) {
      String locationUrl =
          'https://www.google.com/maps/search/?api=1&query=${_initialCameraPosition.latitude},${_initialCameraPosition.longitude}';
      String message = 'Check out my current location: $locationUrl';
      await Share.share(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Current Location'),
      ),
      body: _initialCameraPosition.latitude == 0.0 &&
              _initialCameraPosition.longitude == 0.0
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialCameraPosition, zoom: 15),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                controller.showMarkerInfoWindow(MarkerId('currentLocation'));
              },
              markers: {
                Marker(
                  markerId: MarkerId('currentLocation'),
                  position: _initialCameraPosition,
                  infoWindow: InfoWindow(title: 'Current Location'),
                ),
              },
            ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(
            bottom: 20.0), // Adjust the margin to raise the button above
        width: 150.0, // Set the desired width for the button
        child: FloatingActionButton(
          onPressed: _shareLocation,
          child: Icon(Icons.share),
          backgroundColor: Colors.blue, // Customize the color if needed
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, // Position the button at the bottom center
    );
  }
}
