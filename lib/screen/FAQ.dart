import 'package:driver_friend/screen/default_quiz_screen.dart';
import 'package:driver_friend/widget/drawer.dart';
import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  static String routeName = '/faq';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Do you want any help ?',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'This is the area you can get help from the expert mechanics',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 5,
                child: FlatButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.question_answer_outlined,
                          color: Colors.purple,
                          size: 30,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'New Question',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(DefaultQuestionScreen.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.message_outlined,
                          color: Colors.purple,
                          size: 30,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Find Answer',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
