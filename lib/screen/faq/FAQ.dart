import 'package:driver_friend/model/userType.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/faq/add_question.dart';
import 'package:driver_friend/screen/faq/default_quiz_screen.dart';
import 'package:driver_friend/widget/driver_drawer.dart';
import 'package:driver_friend/widget/mechanic_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQ extends StatelessWidget {
  static String routeName = '/faq';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Provider.of<UserProvider>(context, listen: false).user ==
              UserType.driver
          ? DriverDrawer()
          : MechanicDrawer(),
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
              CustomFaqCard(
                icon: Icons.message,
                route: AddNewQuestionPageScreen.routeName,
                title: 'New Question',
              ),
              CustomFaqCard(
                icon: Icons.thumb_up_sharp,
                route: DefaultQuestionScreen.routeName,
                title: 'Find Answers',
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/faq_1.png'),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/faq_2.jpg'),
                  ),
                ],
              ),
              CustomFaqCard(
                icon: Icons.not_listed_location,
                route: DefaultQuestionScreen.routeName,
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

  CustomFaqCard({this.icon, this.route, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed(route);
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
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
