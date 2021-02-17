import 'package:driver_friend/provider/faq_provider.dart';
import 'package:driver_friend/screen/faq/answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultQuestionScreen extends StatelessWidget {
  static String routeName = 'default-quiz';
  final List quiz = [
    'Why is my check engine light on',
    'How do i check my engine oil level',
    'How often should i chage oil',
    'How do i change a tier',
    'How do i change my car battery',
    'How do i increase fuel efficiency',
    'How do i check the coolant level',
  ];

  List<Question> _questions = [];
  Future<void> fetchData(context) async {
    await Provider.of<FaqProvider>(context, listen: false).fetchQuestions();
  }

  var comment = TextEditingController();
  saveComment() {}

  @override
  Widget build(BuildContext context) {
    _questions =
        Provider.of<FaqProvider>(context, listen: false).answeredQuestions;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Frequently Ask Questions',
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
                          'Welcome to the Search option in FAQ section',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Search',
                          ),
                        ),
                        FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Serach',
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                            ))
                      ],
                    ),
                  );
                });
          },
          backgroundColor: Colors.purple,
          child: Icon(Icons.search),
        ),
        body: FutureBuilder(
          future:
              Provider.of<FaqProvider>(context, listen: false).fetchQuestions(),
          builder: (ctx, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (data.error != null) {
              print(data.error);
              return Center(child: Text('Sorry something gone wrong'));
            }
            return Consumer<FaqProvider>(builder: (ctx, que, child) {
              return que.answeredQuestions.length == 0
                  ? Center(child: Text('No questions available'))
                  : ListView.builder(
                      itemCount: que.answeredQuestions.length,
                      itemBuilder: (ctx, index) {
                        return Card(
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
                                        que.answeredQuestions[index].question,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          AnswerScreen.routeName,
                                          arguments:
                                              que.answeredQuestions[index].id);
                                    },
                                    child: Text('Check'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      });
            });
          },
        ));
  }
}
