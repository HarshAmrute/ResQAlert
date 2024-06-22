import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'dart:async'; // Import the dart:async library for Timer
import 'drawer.dart';
import 'report_page.dart';
import 'first_aid_page.dart';
import 'live_location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResQalert',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ValueNotifier<bool> _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = ValueNotifier(ThemeMode.system == ThemeMode.dark);
  }

  @override
  void dispose() {
    _isDarkMode.dispose();
    super.dispose();
  }

  void _toggleDarkMode() {
    final isDarkMode = _isDarkMode.value;
    _isDarkMode.value = !isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDarkMode,
      builder: (context, isDarkMode, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'ResQalert',
              style: TextStyle(
                fontSize: 27,
                color: Colors.white,
                fontFamily: 'Pacifico', // Custom font
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.red,
            actions: [
              IconButton(
                icon: Icon(isDarkMode ? Icons.lightbulb : Icons.lightbulb_outline),
                onPressed: _toggleDarkMode,
              ),
            ],
          ),
          backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
          drawer: Theme(
            data: ThemeData(
              brightness: isDarkMode ? Brightness.dark : Brightness.light,
            ),
            child: AppDrawer(),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        _buildButton(
                            context,
                            Icons.fire_truck,
                            'Fire',
                            Colors.deepOrange,
                            () => _handleButtonClick(context, 'Fire')),
                        _buildButton(
                            context,
                            Icons.local_hospital,
                            'Ambulance',
                            Colors.green,
                            () => _handleButtonClick(context, 'Ambulance')),
                        _buildButton(context, Icons.local_police, 'Police', Colors.blue,
                            () => _handleButtonClick(context, 'Police')),
                        _buildButton(
                            context,
                            Icons.flash_on,
                            ' Natural\nDisaster',
                            Colors.brown,
                            () => _handleButtonClick(context, 'Natural Disaster')),
                        _buildButton(context, Icons.location_on, 'Live Location',
                            Colors.red, () => _handleLiveLocationButtonClick(context)),
                        _buildButton(context, Icons.healing, 'First Aid', Colors.orange,
                            () => _handleFirstAidButtonClick(context)),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 20.0,
                left: 0,
                right: 0,
                child: SOSButton(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String label,
      Color color, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: SizedBox(
        width: 120,
        height: 120,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.white, width: 2),
            ),
            elevation: 10,
            shadowColor: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Roboto', // Custom font
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonClick(BuildContext context, String type) {
    print('$type button clicked');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReportPage()),
    );
  }

  void _handleFirstAidButtonClick(BuildContext context) {
    print('First Aid button clicked');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirstAidPage()),
    );
  }

  void _handleLiveLocationButtonClick(BuildContext context) {
    print('Live location button clicked');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen()),
    );
  }
}

class SOSButton extends StatefulWidget {
  @override
  _SOSButtonState createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> {
  int _secondsRemaining = 5;
  bool _timerStarted = false;
  late Timer _timer;

  void _startTimer() {
    setState(() {
      _timerStarted = true;
      _secondsRemaining = 5;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsRemaining--;
      });

      if (_secondsRemaining == 0) {
        _timer.cancel();
        _makeSOSCall();
      }
    });
  }

  void _cancelTimer() {
    _timer.cancel();
    setState(() {
      _timerStarted = false;
      _secondsRemaining = 5;
    });
  }

  Future<void> _makeSOSCall() async {
    const phoneNumber = '8369154319';
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    print("Call Initiated: ${res ?? false}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: SizedBox(
        width: 180,
        height: 80,
        child: _timerStarted
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _cancelTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto', // Custom font
                      ),
                    ),
                  ),
                  Text(
                    '$_secondsRemaining seconds',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Roboto', // Custom font
                    ),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: _startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sos,
                      size: 40,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
