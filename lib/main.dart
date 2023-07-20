import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: QuoteGenerator(),
    );
  }
}

class QuoteGenerator extends StatefulWidget {
  const QuoteGenerator({super.key});

  @override
  State<QuoteGenerator> createState() => _QuoteGeneratorState();
}

class _QuoteGeneratorState extends State<QuoteGenerator> {
  final String quoteURL = "https://api.adviceslip.com/advice";
  String quote = 'Random Quote';

  generateQuote() async {
    var res = await http.get(Uri.parse(quoteURL));
    var result = jsonDecode(res.body);
    print(result["slip"]["advice"]);
    setState(() {
      quote = result["slip"]["advice"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Random Quote Generator'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              quote,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                generateQuote();
              },
              child: Text('Generate'),
            ),
          ],
        ),
      ),
      drawer: Drawer(),
    );
  }
}
