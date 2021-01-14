import 'package:flutter/material.dart';

class MechanicListScreen extends StatelessWidget {
  static String routeName = 'mechanic-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Mechanics'),
      ),
    );
  }
}
