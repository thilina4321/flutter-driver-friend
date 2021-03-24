import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/driver/appointments.dart';
import 'package:driver_friend/screen/driver/cart.dart';
import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:driver_friend/screen/driver/driver_profile_screes.dart';
import 'package:driver_friend/screen/driver/driver_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverDrawer extends StatelessWidget {
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
                backgroundImage: AssetImage('assets/images/dri_pro.jpg'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Janitha Perera',
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
                routeName: Appointment.routeName,
                label: 'Appointments'),
            DrawerIcons(
                routeName: Cart.routeName,
                icon: Icons.shopping_cart_outlined,
                label: 'My Cart'),
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
