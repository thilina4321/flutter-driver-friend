import 'package:flutter/material.dart';

class NotAnswerdYetQuizScreen extends StatefulWidget {
  static String routeName = 'not-answer-faq';

  @override
  _NotAnswerdYetQuizScreenState createState() =>
      _NotAnswerdYetQuizScreenState();
}

class _NotAnswerdYetQuizScreenState extends State<NotAnswerdYetQuizScreen> {
  var comment = TextEditingController();

  saveComment() {
    print(comment.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Not Answered'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        margin: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/faq_q.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: comment,
                          onChanged: (value) {
                            comment = value as TextEditingController;
                          },
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'write',
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          FlatButton(
                              onPressed: saveComment, child: Text('Comment')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
