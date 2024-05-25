import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class TunKun extends StatefulWidget {
  const TunKun({super.key});

  @override
  _TunKunState createState() => _TunKunState();
}

class _TunKunState extends State<TunKun> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = (prefs.getBool('isDarkMode') ?? false);
    });
  }

  _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      prefs.setBool('isDarkMode', _isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme Toggle'),
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                _toggleTheme();
              },
            ),
          ],
        ),
        body: const Center(child: Text('Hello World')),
      ),
    );
  }
}
