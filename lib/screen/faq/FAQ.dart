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

class FAQ extends StatelessWidget {
  static String routeName = 'faq-screen';
  @override
  Widget build(BuildContext context) {
    var me = Provider.of<UserProvider>(context, listen: false).me;

    return Scaffold(
      drawer: me['role'] == 'driver' ? DriverDrawer() : MechanicDrawer(),
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
                  fontSize: 30,
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
              if (me['role'] == 'driver')
                CustomFaqCard(
                  icon: Icons.playlist_add_check_outlined,
                  route: DefaultQuestionScreen.routeName,
                  title: 'Looks For Solutions',
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
              if (me['role'] == 'mechanic')
                CustomFaqCard(
                  icon: Icons.not_listed_location,
                  route: NotAnswerdYetQuizScreen.routeName,
                  title: 'Not Answered yet',
                ),
            ],
          ),
        ),
      ),
    );
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
