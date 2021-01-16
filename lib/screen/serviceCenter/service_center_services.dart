import 'package:flutter/material.dart';

class ServiceCenterServices extends StatelessWidget {
  static String routeName = 'service-center-services';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (ctx, index) {
            return ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/ser_cover.PNG',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Full Service',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'With the full service we provide so many things for you to do ...................................'),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Rs. 3000',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Spacer(),
                        FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
