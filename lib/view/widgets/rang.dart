import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rang extends StatefulWidget {
  const Rang({super.key});

  @override
  _RangState createState() => _RangState();
}

class _RangState extends State<Rang> {
  bool _isDarkMode = false;
  Color _appBarColor = Colors.blue;
  Color _scaffoldColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = (prefs.getBool('isDarkMode') ?? false);
      _appBarColor = Color(prefs.getInt('appBarColor') ?? Colors.blue.value);
      _scaffoldColor =
          Color(prefs.getInt('scaffoldColor') ?? Colors.white.value);
    });
  }

  _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      prefs.setBool('isDarkMode', _isDarkMode);
    });
  }

  _changeColors(Color appBarColor, Color scaffoldColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _appBarColor = appBarColor;
      _scaffoldColor = scaffoldColor;
      prefs.setInt('appBarColor', appBarColor.value);
      prefs.setInt('scaffoldColor', scaffoldColor.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: _appBarColor,
          title: const Text('Theme Toggle'),
          actions: [
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: () {
                _changeColors(Colors.red, Colors.yellow);
              },
            ),
            Switch(
              value: _isDarkMode,
              onChanged: (value) {
                _toggleTheme();
              },
            ),
          ],
        ),
        backgroundColor: _scaffoldColor,
        body: const Center(child: Text('Hello World')),
      ),
    );
  }
}
