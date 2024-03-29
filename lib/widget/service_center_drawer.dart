import 'package:driver_friend/model/service_center.dart';
import 'package:driver_friend/provider/service_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
import 'package:driver_friend/screen/serviceCenter/add-services.dart';
import 'package:driver_friend/screen/serviceCenter/manage-appointment.dart';
import 'package:driver_friend/screen/serviceCenter/service_center_profile.dart';
import 'package:driver_friend/screen/serviceCenter/service_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceCenterDrawer extends StatefulWidget {
  @override
  _ServiceCenterDrawerState createState() => _ServiceCenterDrawerState();
}

class _ServiceCenterDrawerState extends State<ServiceCenterDrawer> {
  var me;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    me = Provider.of<UserProvider>(context, listen: false).me;
    ServiceCenter ser =
        Provider.of<ServiceCenterProvider>(context, listen: false)
            .serviceCenter;

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 20, left: 20),
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: ser.profileImageUrl == null
                  ? CircleAvatar(
                      backgroundColor: Colors.grey,
                    )
                  : CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(ser.profileImageUrl),
                    ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              me['userName'],
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
            DrawerIcons(
              icon: Icons.perm_data_setting,
              label: 'New Services',
              routeName: CreateNewServiceScreen.routeName,
            ),
            DrawerIcons(
              icon: Icons.supervised_user_circle,
              label: 'Manage Appointments',
              routeName: ManageAppointment.routeName,
            ),
            DrawerIcons(
              icon: Icons.logout,
              label: 'Log Out',
            ),
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
