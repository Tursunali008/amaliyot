import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Til extends StatefulWidget {
  const Til({super.key});

  @override
  State<Til> createState() => _TilState();
}

class _TilState extends State<Til> {
  Locale _locale = const Locale('en');

  _changeLanguage(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _locale = locale;
      prefs.setString('languageCode', _locale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('uz'),
        Locale('ru'),
      ],
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Language Change'),
          actions: [
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                _changeLanguage(const Locale('uz'));
              },
            ),
          ],
        ),
        body: const Center(child: Text('Hello World')),
      ),
    );
  }
}
