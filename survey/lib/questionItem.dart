import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:survey/models.dart';

class QuestionItem extends StatefulWidget {
  final String question;
  QuestionItem({Key key, this.question}) : super(key: key);

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  List<Answer> parseAnswers(String response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<Answer>((json) => Answer.fromMap(json)).toList();
  }

  Future<List<Answer>> fetchAnswers() async {
    http.Response res =
        await http.get(Uri.parse("http://127.0.0.1:8000/results-list/"));
    if (res.statusCode == 200) {
      return parseAnswers(res.body);
    } else {
      throw Exception('Unable to fetch Questions from the REST API');
    }
  }

  bool showAnswers = false;
  bool submitted = false;
  var _result1;
  List answerList = [];
  void changeAnswer() {
    setState(() {
      showAnswers = !showAnswers;
    });
  }

  void checkSubmitted() {
    setState(() {
      if (_result1 != null) {
        submitted = !submitted;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: fetchAnswers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print('No Data');
            }
            final _answers = snapshot.data;

            for (var item in _answers) {
              final question = item.question;
              final answer = item.result;

              if (question == widget.question) {
                answerList.add(answer);
              }
            }

            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Card(
                child: GestureDetector(
                  onTap: () {
                    changeAnswer();
                  },
                  child: showAnswers
                      ? Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.question),
                              RadioListTile(
                                  title: Text('${answerList[0]}'),
                                  value: answerList[0],
                                  groupValue: _result1,
                                  onChanged: (value) {
                                    setState(() {
                                      _result1 = value;
                                    });
                                  }),
                              RadioListTile(
                                  title: Text('${answerList[1]}'),
                                  value: answerList[1],
                                  groupValue: _result1,
                                  onChanged: (value) {
                                    setState(() {
                                      _result1 = value;
                                    });
                                  }),
                              RadioListTile(
                                  title: Text('${answerList[2]}'),
                                  value: answerList[2],
                                  groupValue: _result1,
                                  onChanged: (value) {
                                    setState(() {
                                      _result1 = value;
                                    });
                                  }),
                              RadioListTile(
                                title: Text('${answerList[3]}'),
                                value: answerList[3],
                                groupValue: _result1,
                                onChanged: (value) {
                                  setState(() {
                                    _result1 = value;
                                  });
                                },
                              ),
                              FlatButton(
                                color: submitted ? Colors.green : Colors.red,
                                onPressed: () {
                                  checkSubmitted();
                                  if (submitted) {
                                    print(_result1.toString());
                                    print(widget.question);
                                    http
                                        .post(
                                            Uri.parse(
                                                "http://127.0.0.1:8000/app/user_results-list/"),
                                            headers: <String, String>{
                                              'Content-Type':
                                                  'application/json; charset=UTF-8',
                                              'connection': 'keep-alive'
                                            },
                                            body: jsonEncode(<String, dynamic>{
                                              "results": _result1.toString(),
                                              "question": widget.question,
                                            }))
                                        .then((http.Response res) {
                                      setState(() {
                                        print("Successfully submitted!");
                                      });
                                    });
                                  }
                                },
                                child: submitted
                                    ? Text(
                                        'Submitted',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        'Submit',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            ],
                          ),
                        )
                      : ListTile(
                          leading: Text(widget.question),
                        ),
                ),
              ),
            );
          }),
    );
  }
}

// import 'package:flutter/material.dart';

// class QuestionItem extends StatefulWidget {
//   QuestionItem({Key key}) : super(key: key);

//   @override
//   _QuestionItemState createState() => _QuestionItemState();
// }

// class _QuestionItemState extends State<QuestionItem> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
//         child: Column(
//           children: <Widget>[
//             Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(widget.questions[0]),
//                     RadioListTile(
//                       title: Text('One'),
//                       value: Answer01.one,
//                       groupValue: _result1,
//                       onChanged: (value) {
//                         setState(() {
//                           _result1 = value;
//                         });
//                       },
//                     ),
//                     RadioListTile(
//                       title: Text('Two'),
//                       value: Answer01.two,
//                       groupValue: _result1,
//                       onChanged: (value) {
//                         setState(() {
//                           _result1 = value;
//                         });
//                       },
//                     ),
//                     RadioListTile(
//                       title: Text('Three'),
//                       value: Answer01.three,
//                       groupValue: _result1,
//                       onChanged: (value) {
//                         setState(() {
//                           _result1 = value;
//                         });
//                       },
//                     ),
//                     RadioListTile(
//                       title: Text('Four'),
//                       value: Answer01.four,
//                       groupValue: _result1,
//                       onChanged: (value) {
//                         setState(() {
//                           _result1 = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 5)
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Question 2'),
//                     RadioListTile(
//                       title: Text('Five'),
//                       value: Answer02.five,
//                       groupValue: _result2,
//                       onChanged: (value) {
//                         setState(() {
//                           _result2 = value;
//                         });
//                       },
//                     ),
//                     RadioListTile(
//                       title: Text('Six'),
//                       value: Answer02.six,
//                       groupValue: _result2,
//                       onChanged: (value) {
//                         setState(() {
//                           _result2 = value;
//                         });
//                       },
//                     ),
//                     RadioListTile(
//                       title: Text('Seven'),
//                       value: Answer02.seven,
//                       groupValue: _result2,
//                       onChanged: (value) {
//                         setState(() {
//                           _result2 = value;
//                         });
//                       },
//                     ),
//                     RadioListTile(
//                       title: Text('Eight'),
//                       value: Answer02.eight,
//                       groupValue: _result2,
//                       onChanged: (value) {
//                         setState(() {
//                           _result2 = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 5)
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Question 3'),
//                     RadioListTile(
//                       title: Text('Ten'),
//                       value: Answer03.ten,
//                       groupValue: _result3,
//                       onChanged: (value) {
//                         setState(() {
//                           _result3 = value;
//                         });
//                       },
//                     ),
//                     RadioListTile(
//                       title: Text('Eleven'),
//                       value: Answer03.eleven,
//                       groupValue: _result3,
//                       onChanged: (value) {
//                         setState(() {
//                           _result3 = value;
//                         });
//                       },
//                     ),
//                     RadioListTile(
//                       title: Text('Twelve'),
//                       value: Answer03.twelve,
//                       groupValue: _result3,
//                       onChanged: (value) {
//                         setState(() {
//                           _result3 = value;
//                         });
//                       },
//                     ),
//                     RadioListTile(
//                       title: Text('Thirteen'),
//                       value: Answer03.thirteen,
//                       groupValue: _result3,
//                       onChanged: (value) {
//                         setState(() {
//                           _result3 = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 5)
//                   ],
//                 ),
//               ),
//             ),
//             TextButton(
//                 onPressed: () {
//                   addAnswerToList();
//                   for (var result in resultList) {
//                     if (resultList != null) {
//                       String answer = result.substring(9);
//                       print(answer);
//                       postResult(answer);
//                     }
//                   }
//                 },
//                 child: Text('Submit'))
//           ],
//         ),
//       ),
//     );
//   }
// }
