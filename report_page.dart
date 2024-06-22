
import 'dart:io';
import 'dart:convert'; // Import for base64Encode

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'report_service.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ReportService _reportService = ReportService();
  final TextEditingController _textController = TextEditingController();
  File? _image;
  String? _imagePath;
  Position? _currentPosition;

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled.')));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied.')));
        return;
      }
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _markers.add(Marker(
          markerId: const MarkerId("currentPosition"),
          position: LatLng(position.latitude, position.longitude),
        ));
      });

      _moveCameraToPosition(position.latitude, position.longitude);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _moveCameraToPosition(double latitude, double longitude) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
      ),
    );
  }

  Future<void> _getImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
      _imagePath = pickedFile.path;
    });
  }
}

  Future<void> _submitReport() async {
    if (_imagePath == null ||
        _textController.text.isEmpty ||
        _currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    try {
      final location =
          '${_currentPosition!.latitude}, ${_currentPosition!.longitude}';
      final url =
          'https://eone5qp085dhmrg.m.pipedream.net'; // Replace with your specific URL

      // Read image file as bytes
      final bytes = File(_imagePath!).readAsBytesSync();

      // Encode image bytes into Base64 string
      final base64Image = base64Encode(bytes);

      var request = http.MultipartRequest('POST', Uri.parse(url));
      // Add Base64 encoded image as a field
      request.fields['image'] = base64Image;
      request.fields['description'] = _textController.text;
      request.fields['location'] = location;

      var response = await request.send();
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report submitted successfully')),
        );
      } else {
        throw Exception('Failed to submit report: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit report: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Scenario')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _image!,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 60,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _getImage,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                            ),
                            child: const Text('Capture Image',
                                style: TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              hintText: "Tell us your concern.",
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding: const EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            minLines: 3,
                            maxLines: null,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _getLocation,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 5,
                            ),
                            child: const Text('Get Location',
                                style: TextStyle(fontSize: 18)),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Latitude: ${_currentPosition?.latitude ?? "N/A"}, Longitude: ${_currentPosition?.longitude ?? "N/A"}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 300,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  _currentPosition?.latitude ?? 0.0,
                                  _currentPosition?.longitude ?? 0.0,
                                ),
                                zoom: 15,
                              ),
                              markers: _markers,
                              onMapCreated: (controller) {
                                setState(() {
                                  _mapController = controller;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitReport,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
              ),
              child:
                  const Text('Submit Report', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}