import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = 'Hello';
  String _selectedLanguage = 'fr'; // Default language code for French

  Future<void> _translateText() async {
    final String apiKey = 'AIzaSyAFj2efLrrgZ0wB83uV6ZVPPaf_JXpyPcE'; // Replace with your API Key
    final String apiUrl =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey';

    final response = await http.post(Uri.parse(apiUrl), body: {
      'q': _text,
      'target': _selectedLanguage,
    });
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _text = data['data']['translations'][0]['translatedText'];
      });
    } else {
      throw Exception('Failed to load translation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: <String>['fr', 'es', 'de'] // Language codes
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _translateText,
              child: Text('Translate'),
            ),
          ],
        ),
      ),
    );
  }
}
