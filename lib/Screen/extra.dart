// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:translator/translator.dart';
//
// void main()
// {
//   runApp(
//       MaterialApp(
//         home: App(),
//       )
//   );
//
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   String _text = 'Hello';
//   String _selectedLanguage = 'fr'; // Default language code for French
//
//   Future<void> _translateText() async {
//     final String apiKey = 'AIzaSyAFj2efLrrgZ0wB83uV6ZVPPaf_JXpyPcE'; // Replace with your API Key
//     final String apiUrl =
//         'https://translation.googleapis.com/language/translate/v2?key=$apiKey';
//
//     final response = await http.post(Uri.parse(apiUrl), body: {
//       'q': _text,
//       'target': _selectedLanguage,
//     });
//     print(response.body);
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       setState(() {
//         _text = data['data']['translations'][0]['translatedText'];
//       });
//     } else {
//       throw Exception('Failed to load translation');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Translate App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(_text),
//             DropdownButton<String>(
//               value: _selectedLanguage,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   _selectedLanguage = newValue!;
//                 });
//               },
//               items: <String>['fr', 'es', 'de'] // Language codes
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             ElevatedButton(
//               onPressed: _translateText,
//               child: Text('Translate'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
import 'dart:convert';

import 'package:businessgym/Utils/ApiUrl.dart';
import 'package:businessgym/model/SearchListModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Search with Translation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = "Press the button and start speaking";
  double _confidence = 1.0;
  List<Serchlistmodeldata> searchlist = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
            ),
            Text(
              _isListening ? 'Listening...' : 'Not Listening',
            ),
            Text(
              _text,
            ),
            Expanded(child: ListView.builder(
                itemCount: searchlist.length,
                shrinkWrap: true,
                itemBuilder: (context,position){
                  return Text(searchlist[position].name);
                }),),
            ElevatedButton(
              onPressed: !_isListening ? _initializeSpeechRecognition : _stopListening,
              child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
            ),
          ],
        ),
      ),
    );
  }
  void _initializeSpeechRecognition() async {
    bool available = await _speech!.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      _startListening();
    }
  }

  void _startListening() {
    _speech?.listen(
      onResult: (val) => setState(() {
        _text = val.recognizedWords;

        if (val.hasConfidenceRating && val.confidence > 0) {
          _confidence = val.confidence;
        }
        searchWithFilter(_text);
      }),
    );
  }

  void _stopListening() {
    _speech!.stop();
    setState(() => _isListening = false);
  }

  searchWithFilter(String value) async {
    searchlist = [];
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.searchFilterUrl),
      );
      request.fields['text'] = value;
      final response = await request.send();
      final data = await http.Response.fromStream(response);
      print(data.body);
      print(data.body.length);
      print(data.statusCode);
      if (response.statusCode == 200) {
        Serchlistmodel vehicalTypeModel =
        Serchlistmodel.fromJson(jsonDecode(data.body));
        searchlist = vehicalTypeModel.data;
        setState(() {});
      } else {}
    } catch (e) {
      print(e);
    }
  }
}



