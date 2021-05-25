import 'package:driver_friend/model/drivert.dart';
import 'package:driver_friend/provider/driver_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/driver/appointments.dart';
import 'package:driver_friend/screen/driver/my_questions.dart';
import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:driver_friend/screen/driver/driver_profile_screes.dart';
import 'package:driver_friend/screen/driver/driver_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverDrawer extends StatefulWidget {
  @override
  _DriverDrawerState createState() => _DriverDrawerState();
}

class _DriverDrawerState extends State<DriverDrawer> {
  var user;

  @override
  Widget build(BuildContext context) {
    Driver driver = Provider.of<DriverProvider>(context, listen: false).driver;
    if (driver == null) {
      user = Provider.of<UserProvider>(context, listen: false).me;
    }

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 20, left: 20),
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: driver.profileImageUrl == null
                  ? CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                    )
                  : CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(driver.profileImageUrl),
                    ),
            ),
            SizedBox(
              height: 8,
            ),
            driver == null
                ? Text(user['userName'])
                : Text(
                    driver.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Driver',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Divider(
              thickness: 2,
              height: 2,
            ),
            DrawerIcons(
                routeName: DriverProfileScreen.routeName,
                icon: Icons.folder_outlined,
                label: 'My Profile'),
            DrawerIcons(
                icon: Icons.supervised_user_circle,
                routeName: AppointmentScreen.routeName,
                label: 'Appointments'),
            DrawerIcons(
              icon: Icons.hourglass_top_sharp,
              label: 'My Questions',
              routeName: MyQuestionsScrenn.routeName,
            ),
            DrawerIcons(
              icon: Icons.question_answer_outlined,
              label: 'FAQ',
              routeName: FAQ.routeName,
            ),
            DrawerIcons(
              icon: Icons.logout,
              label: 'Log Out',
            ),
            DrawerIcons(
              icon: Icons.settings,
              label: 'Settings & Accounts',
              routeName: DriverSettignScreen.routeName,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerIcons extends StatelessWidget {
  final IconData icon;
  final String label;
  final String routeName;

  DrawerIcons({this.icon, this.label, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FlatButton.icon(
            label: Expanded(
              child: Text(
                label,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            icon: Icon(
              icon,
              size: 30,
            ),
            onPressed: () async {
              if (routeName == null) {
                Provider.of<UserProvider>(context, listen: false)
                    .logout(context);
              } else {
                Navigator.of(context).pushNamed(routeName);
              }
            }),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
