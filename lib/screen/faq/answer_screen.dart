import 'package:driver_friend/provider/faq_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    // String data = ModalRoute.of(context).settings.arguments;
    String data = 'Why is my check engine\'s light on';
    // print(data);
    return Scaffold(
      appBar: AppBar(
        title: Text('Answer'),
      ),
      body: SingleChildScrollView(
        child: Consumer<FaqProvider>(builder: (ctx, faq, _) {
          return Column(
            children: [
              SingleChildScrollView(
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        margin: const EdgeInsets.all(2),
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/faq.jpg',
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
                            onPressed: saveComment,
                            child: Text('Answer'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/dri_pro.jpg',
                              ),
                            ),
                            title: Text(
                                'This is the default question that we provide just for UI part of the application'),
                          ),
                          Row(
                            children: [
                              Spacer(),
                              FlatButton(
                                onPressed: () {},
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
