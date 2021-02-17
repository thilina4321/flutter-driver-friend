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

  bool a = true;

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    print(id);
    Provider.of<FaqProvider>(context, listen: false)
        .selectAnswersForQuestion(id);

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
                      title: Text('Thlina'),
                    ),
                    Text(
                        'This is thr questio that dhd kdhd hdkd dld d dhdld dhd kdd dhdkdd'),
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
