import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Flutter App',
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
  final String apiUrl = 'http://47.128.72.247/nwr-api/system/controllers/webservice/url/CheckoutUpdate/';
  final String signatureToken = 'SXFhdkZlYnhUcEFScWZEWm9tTXNDdz09';
  final String cardMemberID = '1212124';

  // Define a variable to hold the retrieved data
  dynamic data;

  // Function to fetch data from the API
  Future<void> fetchData() async {
    var response = await http.post(
      apiUrl,
      body: {
        'signatureToken': signatureToken,
        'CardMemberID': cardMemberID,
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Flutter App'),
      ),
      body: Center(
        child: data == null
            ? CircularProgressIndicator()
            : Text(data.toString()),
      ),
    );
  }
}
