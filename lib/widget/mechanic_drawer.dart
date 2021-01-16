import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:driver_friend/screen/mechanic/mechanic_setting.dart';
import 'package:driver_friend/screen/sparePartShop/spare_part_shop_list.dart';
import 'package:flutter/material.dart';

class MechanicDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 20, left: 20),
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/mec_pro.jpg'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Prageesha Perera',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Mechanic',
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
                routeName: MechanicProfileScreen.routeName,
                icon: Icons.folder_outlined,
                label: 'My Profile'),
            DrawerIcons(
              icon: Icons.question_answer_outlined,
              label: 'FAQ',
              routeName: FAQ.routeName,
            ),
            DrawerIcons(icon: Icons.logout, label: 'Log Out'),
            DrawerIcons(
              icon: Icons.settings,
              label: 'Settings & Accounts',
              routeName: MechanicSettignScreen.routeName,
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
            onPressed: () {
              routeName == null
                  ? Navigator.of(context).pushReplacementNamed('/')
                  : Navigator.of(context).pushNamed(routeName);
            }),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
