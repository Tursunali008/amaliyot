import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pinkod extends StatefulWidget {
  const Pinkod({super.key});

  @override
  _PinkodState createState() => _PinkodState();
}

class _PinkodState extends State<Pinkod> {
  bool _isDarkMode = false;
  bool _isPinEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = (prefs.getBool('isDarkMode') ?? false);
      _isPinEnabled = (prefs.getBool('isPinEnabled') ?? false);
    });
  }

  _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      prefs.setBool('isDarkMode', _isDarkMode);
    });
  }

  _togglePin(bool isEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPinEnabled = isEnabled;
      prefs.setBool('isPinEnabled', _isPinEnabled);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PIN Toggle'),
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                _toggleTheme();
              },
            ),
            Switch(
              value: _isPinEnabled,
              onChanged: (value) {
                _togglePin(value);
              },
            ),
          ],
        ),
        body: _isPinEnabled ? PinScreen() : HomeScreen(),
      ),
    );
  }
}

class PinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter PIN'),
      ),
      body: const Center(
        child: Text('PIN Screen'), // PIN code input logic will be here
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Hello World'));
  }
}
