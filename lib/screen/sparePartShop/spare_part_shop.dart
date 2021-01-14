import 'package:flutter/material.dart';

class SparepartShopListScreen extends StatelessWidget {
  static String routeName = 'spare-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Spare part shops'),
      ),
    );
  }
}
