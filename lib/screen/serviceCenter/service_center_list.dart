import 'package:flutter/material.dart';

class ServiceCenterList extends StatelessWidget {
  static String routeName = 'service-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Service Center'),
      ),
    );
  }
}
