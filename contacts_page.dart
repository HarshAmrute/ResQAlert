import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State
{
final TextEditingController _contactController = TextEditingController();
final TextEditingController _relationshipController = TextEditingController();
List<Map<String, String>> contacts = [];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Personal Contacts'),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
TextFormField(
controller: _contactController,
decoration: InputDecoration(labelText: 'Contact Number'),
keyboardType: TextInputType.phone,
),
TextFormField(
controller: _relationshipController,
decoration: InputDecoration(labelText: 'Relationship'),
),
SizedBox(height: 10),
ElevatedButton(
onPressed: () {
// Add contact and relationship to the list
setState(() {
contacts.add({
'contact': _contactController.text,
'relationship': _relationshipController.text,
});
// Clear text fields after adding contact
_contactController.clear();
_relationshipController.clear();
});
},
child: Text('Add Contact'),
),
SizedBox(height: 20),
Text(
'Contacts List:',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
SizedBox(height: 10),
Expanded(
child: ListView.builder(
itemCount: contacts.length,
itemBuilder: (context, index) {
return ListTile(
title: Text('Contact: ${contacts[index]['contact']}'),
subtitle: Text('Relationship: ${contacts[index]['relationship']}'),
);
},
),
),
],
),
),
);
}
}