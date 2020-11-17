import 'package:flutter/material.dart';

class MechanicsScreen extends StatelessWidget {
  static String routeName = '/mechanics';
  final List dummyMechanic = [
    {'name': 'Tharuka', 'location': 'Dehiattakandiya', 'rating': 5},
    {'name': 'Anuradha', 'location': 'Alpitiya', 'rating': 5},
    {'name': 'Prageesha', 'location': 'Arachchikattuwa', 'rating': 5},
    {'name': 'Malikshi', 'location': 'Horana', 'rating': 5},
    {'name': 'Thilina', 'location': 'Biyagama', 'rating': 4.5},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Mechanics'),
      ),
      body: ListView.builder(
          itemCount: dummyMechanic.length,
          itemBuilder: (ctx, index) {
            return Container(
              height: 70,
              width: double.infinity,
              child: Card(
                elevation: 3,
                child: FlatButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(dummyMechanic[index]['rating'].toString()),
                    ),
                    title: Text(dummyMechanic[index]['name']),
                    trailing: Text(dummyMechanic[index]['location']),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
