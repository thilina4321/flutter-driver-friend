import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/sai.jpg'),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Sai Pallavi',
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
              Container(
                  color: Color(0xffE4A0F7),
                  child: DrawerIcons(Icons.folder_outlined, 'My Profile')),
              DrawerIcons(Icons.person_pin_circle_outlined, 'Mechanic'),
              DrawerIcons(Icons.shopping_cart_outlined, 'Spare Part Shop'),
              DrawerIcons(Icons.car_repair, 'Service Center'),
              DrawerIcons(Icons.question_answer_outlined, 'FAQ'),
              DrawerIcons(Icons.logout, 'Log Out'),
              Spacer(),
              DrawerIcons(Icons.settings, 'Settings & Accounts'),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerIcons extends StatelessWidget {
  final IconData icon;
  final String label;

  DrawerIcons(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatButton.icon(
            label: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: Icon(
              icon,
              size: 40,
            ),
            onPressed: () {}),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
