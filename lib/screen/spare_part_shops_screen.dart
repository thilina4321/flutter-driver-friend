import 'package:flutter/material.dart';

class SparePartShopsScreen extends StatelessWidget {
  static String routeName = '/spare-part-shops';
  final List dummySparePartShop = [
    {'name': 'Dmst Shop', 'location': 'Dehiattakandiya', 'rating': 5},
    {'name': 'A Shop', 'location': 'Alpitiya', 'rating': 5},
    {'name': 'P Shop', 'location': 'Arachchikattuwa', 'rating': 5},
    {'name': 'M Shop', 'location': 'Horana', 'rating': 5},
    {'name': 'T Shop', 'location': 'Biyagama', 'rating': 2.5},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spare part shops'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
          itemCount: 5,
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
                          Text(dummySparePartShop[index]['rating'].toString()),
                    ),
                    title: Text(dummySparePartShop[index]['name']),
                    trailing: Text(dummySparePartShop[index]['location']),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
