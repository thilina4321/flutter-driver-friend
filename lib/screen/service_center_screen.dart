import 'package:flutter/material.dart';

class ServiceCentersScreen extends StatelessWidget {
  static String routeName = '/service-centers';
  final List dummyServiceCenters = [
    {'name': 'Dmst Center', 'location': 'Dehiattakandiya', 'rating': 5},
    {'name': 'A Center', 'location': 'Alpitiya', 'rating': 5},
    {'name': 'P Center', 'location': 'Arachchikattuwa', 'rating': 5},
    {'name': 'M Center', 'location': 'Horana', 'rating': 5},
    {'name': 'T Center', 'location': 'Biyagama', 'rating': 3.5},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Centers'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
          itemCount: dummyServiceCenters.length,
          itemBuilder: (ctx, index) {
            return Container(
              height: 70,
              width: double.infinity,
              child: Card(
                elevation: 3,
                child: FlatButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  child: ListTile(
                    leading: CircleAvatar(
                      child:
                          Text(dummyServiceCenters[index]['rating'].toString()),
                    ),
                    title: Text(dummyServiceCenters[index]['name']),
                    trailing: Text(dummyServiceCenters[index]['location']),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
