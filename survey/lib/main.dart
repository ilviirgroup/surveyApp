import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:survey/models.dart';
import 'package:survey/questionItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Survey'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Questions> parseData(String response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<Questions>((json) => Questions.fromMap(json)).toList();
  }

  Future<List<Questions>> fetchData() async {
    http.Response res =
        await http.get(Uri.parse("http://127.0.0.1:8000/questions-list/"));
    if (res.statusCode == 200) {
      return parseData(res.body);
    } else {
      throw Exception('Unable to fetch Questions from the REST API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[400],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Questions',
          style: TextStyle(color: Colors.teal),
        ),
      ),
      body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print("No data");
            }
            final _questions = snapshot.data;
            List<QuestionItem> questionList = [];
            for (var item in _questions) {
              final question = item.question;
              final questionItem = QuestionItem(question: question);
              questionList.add(questionItem);
            }

            return ListView(
              children: questionList,
              padding: EdgeInsets.all(10.0),
            );
          }),
    );
  }
}
