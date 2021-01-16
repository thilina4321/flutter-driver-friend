import 'package:flutter/material.dart';

class AnswerScreen extends StatefulWidget {
  static String routeName = 'answer-faq';

  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  var comment = TextEditingController();

  saveComment() {
    print(comment.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Answer'),
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
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: 21,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/dri_pro.jpg'),
                            ),
                            title: Text(
                                'this is a game chaning movement this is a game chaning movement'),
                          ),
                          Row(
                            children: [
                              Spacer(),
                              FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                          )
                        ],
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
