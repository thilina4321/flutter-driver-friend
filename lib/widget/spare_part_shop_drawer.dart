import 'package:driver_friend/screen/sparePartShop/Spare_part_shop_profile_screen.dart';
import 'package:driver_friend/screen/sparePartShop/spare_setting.dart';
import 'package:flutter/material.dart';

class SparePartShopDrawer extends StatelessWidget {
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
                backgroundImage: AssetImage('assets/images/spa_pro.jpg'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Dmst Spare part Shop',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Spare part shop',
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
                routeName: SparePartShopProfileScreen.routeName,
                icon: Icons.folder_outlined,
                label: 'My Profile'),
            DrawerIcons(
                icon: Icons.center_focus_weak, label: 'Manage Services'),
            DrawerIcons(icon: Icons.logout, label: 'Log Out'),
            DrawerIcons(
              icon: Icons.settings,
              label: 'Settings & Accounts',
              routeName: SparePartShopSettignScreen.routeName,
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
