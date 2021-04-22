import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/helper/is-perform.dart';
import 'package:driver_friend/provider/faq_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnswerScreen extends StatefulWidget {
  static String routeName = 'answer-faq';

  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  bool a = true;
  final formKey = GlobalKey<FormState>();
  String _answer;
  String _questionId;
  String _authorId;

  _saveComment() async {
    formKey.currentState.save();
    bool isValid = formKey.currentState.validate();

    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<FaqProvider>(context, listen: false)
          .addAnswer(_answer, _questionId, _authorId);
      setState(() {
        isLoading = false;
      });
      formKey.currentState.reset();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ErrorDialog.errorDialog(context, 'Sorry activity failed');
    }
  }

  bool isLoading = false;
  final key = GlobalKey<FormState>();

  editComment(answerId) async {
    key.currentState.save();
    var isValid = key.currentState.validate();
    if (!isValid) {
      return;
    }

    Navigator.of(context).pop();

    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<FaqProvider>(context, listen: false)
          .editComment(editedComment, answerId, _questionId);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ErrorDialog.errorDialog(context, e.toString());
    }
  }

  String editedComment;

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context).settings.arguments;
    var me = Provider.of<UserProvider>(context, listen: false).me;
    var data =
        Provider.of<FaqProvider>(context, listen: false).findQuestion(id);

    _questionId = id;

    if (me['role'] == 'mechanic') {
      _authorId = me['id'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Answer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 25,
                      ),
                      title: Text(data['driverId']['userName']),
                    ),
                    Text(data['question']),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/faq.jpg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    if (me['role'] == 'mechanic')
                      Card(
                        elevation: 5,
                        child: Form(
                          key: formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    onSaved: (val) {
                                      _answer = val;
                                    },
                                    validator: (val) {
                                      if (val == '') {
                                        return 'Nothing to comment';
                                      }
                                      return null;
                                    },
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      labelText: 'write here',
                                    ),
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: _saveComment,
                                child: isLoading
                                    ? CircularProgressIndicator()
                                    : Icon(Icons.send),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Divider(
                      thickness: 3,
                    ),
                    ...data['answers'].map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(e['authorId']['userName']),
                            leading: CircleAvatar(
                              child: Text(e['authorId']['userName']
                                  .toString()
                                  .split('')[0]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Text(
                              e['answer'],
                              textAlign: TextAlign.start,
                            ),
                          ),
                          if (e['authorId']['_id'] == me['id'])
                            Row(
                              children: [
                                Spacer(),
                                FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Form(
                                              key: key,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                margin: const EdgeInsets.all(0),
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('Edit your comment'),
                                                    TextFormField(
                                                      initialValue: e['answer'],
                                                      onSaved: (val) {
                                                        editedComment = val;
                                                      },
                                                      validator: (val) {
                                                        if (val == '') {
                                                          return 'Enter comment';
                                                        }
                                                        return null;
                                                      },
                                                      maxLines: null,
                                                      decoration:
                                                          InputDecoration(),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        FlatButton(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            onPressed: () =>
                                                                editComment(
                                                                    e['_id']),
                                                            child: Text(
                                                              'Ok',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .purple),
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.purple,
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () async {
                                    try {
                                      var isPerform =
                                          await IsPerformDialog.performStatus(
                                              context);
                                      if (isPerform) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await Provider.of<FaqProvider>(context,
                                                listen: false)
                                            .deleteAnswer(
                                                _questionId, e['_id']);
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    } catch (e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      ErrorDialog.errorDialog(context,
                                          'Sorry something went wrong');
                                    }
                                  },
                                  child: Icon(Icons.delete, color: Colors.red),
                                ),
                              ],
                            ),
                          Divider(
                            thickness: 3,
                          ),
                        ].toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * (0.5),
                child: Consumer<FaqProvider>(builder: (context, ans, child) {
                  return ListView.builder(
                      itemCount: ans.answers.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.purple,
                            ),
                            title: Text(ans.answers[index].answer),
                          ),
                        );
                      });
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SingleChildScrollView(
//               child: Consumer<FaqProvider>(builder: (ctx, faq, _) {
//                 return Column(
//                   children: [
//                     SingleChildScrollView(
//                       child: Card(
//                         elevation: 3,
//                         child: Column(
//                           children: [
//                             Container(
//                               alignment: Alignment.topLeft,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'data',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               height: 200,
//                               margin: const EdgeInsets.all(2),
//                               width: double.infinity,
//                               child: Image.asset(
//                                 'assets/images/faq.jpg',
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: TextField(
//                                 controller: comment,
//                                 onChanged: (value) {
//                                   comment = value as TextEditingController;
//                                 },
//                                 keyboardType: TextInputType.text,
//                                 maxLines: null,
//                                 decoration: InputDecoration(
//                                   hintText: 'write',
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Spacer(),
//                                 FlatButton(
//                                   onPressed: saveComment,
//                                   child: Text('Answer'),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 500,
//                       child: ListView.builder(
//                           itemCount: 5,
//                           itemBuilder: (ctx, index) {
//                             return Column(
//                               children: [
//                                 ListTile(
//                                   leading: CircleAvatar(
//                                     backgroundImage: AssetImage(
//                                       'assets/images/dri_pro.jpg',
//                                     ),
//                                   ),
//                                   title: Text(
//                                       'This is the default question that we provide just for UI part of the application'),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Spacer(),
//                                     FlatButton(
//                                       onPressed: () {},
//                                       child: Text(
//                                         'Delete',
//                                         style: TextStyle(color: Colors.red),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             );
//                           }),
//                     ),
//                   ],
//                 );
//               }),
//             )
