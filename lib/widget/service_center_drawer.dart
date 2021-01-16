import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:driver_friend/screen/serviceCenter/service_settings.dart';
import 'package:flutter/material.dart';

class ServiceCenterDrawer extends StatelessWidget {
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
                backgroundImage: AssetImage('assets/images/ser_pro.jpg'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'DMST Service Center',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Service center',
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
                routeName: ServiceCenterProfileScreen.routeName,
                icon: Icons.folder_outlined,
                label: 'My Profile'),
            DrawerIcons(icon: Icons.perm_data_setting, label: 'Manage Parts'),
            DrawerIcons(icon: Icons.logout, label: 'Log Out'),
            DrawerIcons(
              icon: Icons.settings,
              label: 'Settings & Accounts',
              routeName: ServiceCenterSettignScreen.routeName,
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
