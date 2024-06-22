import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_webservice/places.dart';

class HospitalMapPage extends StatefulWidget {
  @override
  _HospitalMapPageState createState() => _HospitalMapPageState();
}

class _HospitalMapPageState extends State<HospitalMapPage> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  late GoogleMapsPlaces places;
  late LatLng currentLocation = LatLng(0.0, 0.0); // Initialize currentLocation
  late Marker currentLocationMarker;

  @override
  void initState() {
    super.initState();
    places =
        GoogleMapsPlaces(apiKey: "AIzaSyDutXMDXxzv_-f1oYbnN4VIgB0jZLiGz38");
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      CameraPosition cameraPosition = CameraPosition(
        target: currentLocation,
        zoom: 15.0,
      );
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      // Since currentLocationMarker is always initialized in initState,
      // we can safely assume it's not null here.
      currentLocationMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position: currentLocation,
        infoWindow: InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
      markers.add(currentLocationMarker);

      _getNearbyHospitals(currentLocation);
    });
  }

  void _getNearbyHospitals(LatLng currentLocation) async {
    PlacesSearchResponse response = await places.searchNearbyWithRadius(
      Location(
        lat: currentLocation.latitude,
        lng: currentLocation.longitude,
      ),
      5000, // Specify the radius in meters
      type: 'hospital',
    );
    setState(() {
      markers.clear();
      for (var result in response.results) {
        if (result.geometry?.location != null) {
          markers.add(Marker(
            markerId: MarkerId(result.name ?? " "),
            position: LatLng(
              result.geometry!.location.lat,
              result.geometry!.location.lng,
            ),
            infoWindow: InfoWindow(title: result.name),
            onTap: () {
              _navigateToHospital(LatLng(
                result.geometry!.location.lat,
                result.geometry!.location.lng,
              ));
            },
          ));
        }
      }
    });
  }

  void _navigateToHospital(LatLng hospitalLocation) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${hospitalLocation.latitude},${hospitalLocation.longitude}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 15.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        markers: markers,
      ),
    );
  }
}
