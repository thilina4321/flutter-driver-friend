import 'package:driver_friend/model/mechanic_model.dart';
import 'package:driver_friend/provider/faq_provider.dart';
import 'package:driver_friend/provider/mechanic_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotAnswerdYetQuizScreen extends StatefulWidget {
  static String routeName = 'not-answer-faq';

  @override
  _NotAnswerdYetQuizScreenState createState() =>
      _NotAnswerdYetQuizScreenState();
}

class _NotAnswerdYetQuizScreenState extends State<NotAnswerdYetQuizScreen> {
  String myAnswer;
  List<GlobalKey<FormState>> _key = [];
  var userId;
  Answer answer;
  bool isLoading = false;

  Future<void> saveComment(int index, String id) async {
    _key[index].currentState.save();

    print(id);
    print(userId);
    print(myAnswer);

    // answer.questionId = id;
    // answer.answer = myAnswer;
    // answer.authorId = userId;
    answer = Answer(questionId: id, answer: myAnswer, authorId: userId);
    setState(() {
      isLoading = true;
    });
    try {
      // await Provider.of<FaqProvider>(context, listen: false).addAnswer(answer);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Something went wrong try again later'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Mechanic mechanic =
        Provider.of<MechanicProvider>(context, listen: false).mechanic;
    print(mechanic.id);

    var a = Provider.of<FaqProvider>(context, listen: false)
        .selectAnswersOfSpecificMechanic('607c349709ef3d00154e9a24');
    print(a);

    return Scaffold(
      appBar: AppBar(
        title: Text('Answered Questions'),
      ),
      body: isLoading
          // 607c344609ef3d00154e9a21
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: Provider.of<FaqProvider>(context, listen: false)
                  .fetchQuestions(),
              builder: (ctx, data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (data.error != null) {
                  print(data.error);
                  return Center(child: Text('Something went wrong..'));
                }
                return Consumer<FaqProvider>(builder: (ctx, que, child) {
                  _key = new List(que.notAnsweredquestions.length);
                  for (var i = 0; i < que.notAnsweredquestions.length; i++) {
                    _key[i] = GlobalKey<FormState>();
                  }
                  return que.notAnsweredquestions.length == 0
                      ? Center(child: Text('No questions available'))
                      : ListView.builder(
                          itemCount: que.notAnsweredquestions.length,
                          itemBuilder: (ctx, index) {
                            return Card(
                              elevation: 3,
                              child: Column(
                                children: [
                                  if (que.notAnsweredquestions[index]
                                          .questionImage !=
                                      null)
                                    Container(
                                      height: 200,
                                      margin: const EdgeInsets.all(2),
                                      width: double.infinity,
                                      child: Image.asset(
                                        '_questions[index].questionImage',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(8),
                                    child: Text(
                                      que.notAnsweredquestions[index].question,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    child: Form(
                                      key: _key[index],
                                      child: TextFormField(
                                        onSaved: (value) {
                                          myAnswer = value;
                                        },
                                        maxLines: null,
                                        decoration: InputDecoration(),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      FlatButton(
                                        onPressed: () => saveComment(index,
                                            que.notAnsweredquestions[index].id),
                                        child: Text('Post'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                });
              },
            ),
    );
  }
}
