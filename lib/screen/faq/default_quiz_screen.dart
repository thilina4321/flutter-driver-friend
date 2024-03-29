import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/provider/faq_provider.dart';
import 'package:driver_friend/screen/faq/answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultQuestionScreen extends StatefulWidget {
  static String routeName = 'default-quiz';

  @override
  _DefaultQuestionScreenState createState() => _DefaultQuestionScreenState();
}

class _DefaultQuestionScreenState extends State<DefaultQuestionScreen> {
  var place;
  List questions = [];
  List dupQuestions = [];
  bool isLoading = false;

  _filterQuestions(String city) {
    List fl = [];
    dupQuestions.forEach((element) {
      if (element.toString().contains(city)) {
        fl.add(element);
      }
    });

    Navigator.pop(context);
    setState(() {
      questions = fl;
    });
  }

  Future fetchQuestions() async {
    questions = Provider.of<FaqProvider>(context, listen: false).questions;
    dupQuestions = questions;
  }

  allQuestions() {
    setState(() {
      questions = dupQuestions;
    });
  }

  @override
  void initState() {
    fetchQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: allQuestions,
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
        title: Text(
          'Questions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              context: context,
              builder: (ctx) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Search for existing problem',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          place = val;
                        },
                        decoration: InputDecoration(
                          labelText: 'Search',
                        ),
                      ),
                      FlatButton(
                        onPressed: () => _filterQuestions(place),
                        child: Text(
                          'Serach',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        backgroundColor: Colors.purple,
        child: Icon(Icons.search),
      ),
      body: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AnswerScreen.routeName,
                    arguments: questions[index]['_id']);
              },
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            child: Text(
                              questions[index]['question'],
                              // que.answeredQuestions[index].question,
                              textAlign: TextAlign.start,

                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
