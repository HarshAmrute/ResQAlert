// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ReportService {
//   final String _url = 'https://eo7877d6q47xgx.m.pipedream.net';

//   Future<void> sendReport(
//       String text, String imageBase64, String location) async {
//     final headers = {'Content-Type': 'application/json'};
//     final body = jsonEncode({
//       'text': text,
//       'image': imageBase64,
//       'location': location,
//     });

//     try {
//       final response =
//           await http.post(Uri.parse(_url), headers: headers, body: body);
//       if (response.statusCode != 200) {
//         throw Exception('Failed to send report: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error sending report: $e');
//       rethrow;
//     }
//   }
// }

// import 'dart:async';
// // import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ReportService {
//   Future<void> sendReport(
//       String description, String imageBase64, String location) async {
//     try {
//       final url =
//           'https://eo7877d6q47xgx.m.pipedream.net'; // Replace with your RequestBin URL

//       final response = await http.post(
//         Uri.parse(url),
//         body: {
//           'description': description,
//           'image': imageBase64,
//           'location': location,
//         },
//       );

//       if (response.statusCode == 200) {
//         print('Report sent successfully');
//       } else {
//         throw Exception('Failed to submit report: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Failed to submit report: $e');
//     }
//   }
// }

import 'dart:async';
// import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportService {
  Future<void> sendReport(
      String description, String imagePath, String location) async {
    try {
      final url =
          'https://eol45f24lme75va.m.pipedream.net'; // Replace with your RequestBin URL

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['description'] = description;
      request.fields['location'] = location;
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Report sent successfully');
      } else {
        throw Exception('Failed to submit report: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to submit report: $e');
    }
  }
}
