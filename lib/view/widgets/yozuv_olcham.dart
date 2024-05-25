import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class YozuvOlcham extends StatefulWidget {
  const YozuvOlcham({super.key});

  @override
  State<YozuvOlcham> createState() => _YozuvOlchamState();
}

class _YozuvOlchamState extends State<YozuvOlcham> {

  final bool _isDarkMode = false;
  double _fontSize = 16.0;
  Color _fontColor = Colors.black;

  _changeTextAppearance(double fontSize, Color fontColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = fontSize;
      _fontColor = fontColor;
      prefs.setDouble('fontSize', _fontSize);
      prefs.setInt('fontColor', _fontColor.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text Appearance'),
          actions: [
            IconButton(
              icon: const Icon(Icons.format_size),
              onPressed: () {
                _changeTextAppearance(20.0, Colors.red);
              },
            ),
          ],
        ),
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(fontSize: _fontSize, color: _fontColor),
          ),
        ),
      ),
    );
  }
}
