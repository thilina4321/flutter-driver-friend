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
    Question data = ModalRoute.of(context).settings.arguments;
    print(data.questionImage);
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
                          child: Text(data.question),
                        ),
                      ),
                      if (data.questionImage != null)
                        Container(
                          height: 200,
                          margin: const EdgeInsets.all(2),
                          width: double.infinity,
                          child: Image.file(
                            data.questionImage,
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
              // Container(
              //   height: 500,
              //   child: ListView.builder(
              //       itemCount: 21,
              //       itemBuilder: (ctx, index) {
              //         return Column(
              //           children: [
              //             ListTile(
              //               leading: CircleAvatar(
              //                 backgroundImage: FileImage(
              //                     faq.answer.comment[index].profileImage),
              //               ),
              //               title: Text(faq.answer.comment[index].answer),
              //             ),
              //             Row(
              //               children: [
              //                 Spacer(),
              //                 FlatButton(
              //                   onPressed: () {},
              //                   child: Text(
              //                     'Delete',
              //                     style: TextStyle(color: Colors.red),
              //                   ),
              //                 ),
              //               ],
              //             )
              //           ],
              //         );
              //       }),
              // ),
            ],
          );
        }),
      ),
    );
  }
}
