import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/faq_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/faq/add_question.dart';
import 'package:driver_friend/screen/faq/default_quiz_screen.dart';
import 'package:driver_friend/screen/faq/not_answer_quiz.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/mechanic_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQ extends StatefulWidget {
  static String routeName = 'faq-screen';

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var me = Provider.of<UserProvider>(context, listen: false).me;

    return Scaffold(
        drawer: me['role'] == 'driver' ? DriverDrawer() : MechanicDrawer(),
        appBar: AppBar(
          title: Text('FAQ'),
          backgroundColor: Colors.purple,
        ),
        body: FutureBuilder(
          future:
              Provider.of<FaqProvider>(context, listen: false).fetchQuestions(),
          builder: (context, faq) {
            if (faq.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (faq.error != null) {
              return Center(
                child: Text('Something went wrong. Please try again later'),
              );
            }
            return Container(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Frequently Ask Question',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Any Question? Here is the place',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomFaqCard(
                      icon: Icons.playlist_add_check_outlined,
                      route: DefaultQuestionScreen.routeName,
                      title: me['role'] == 'driver'
                          ? 'Looks For Solutions'
                          : "Check Questions",
                    ),
                    if (me['role'] == 'driver')
                      CustomFaqCard(
                        icon: Icons.question_answer_outlined,
                        route: AddNewQuestionPageScreen.routeName,
                        title: 'Ask New Question',
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    // if (me['role'] == 'mechanic')
                    //   CustomFaqCard(
                    //     icon: Icons.soap_outlined,
                    //     route: NotAnswerdYetQuizScreen.routeName,
                    //     title: 'You Answered Questions',
                    //   ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class CustomFaqCard extends StatelessWidget {
  final String route;
  final String title;
  final IconData icon;
  final String args;

  CustomFaqCard({this.icon, this.route, this.title, this.args});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed(route, arguments: args);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.purple,
                size: 30,
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
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
