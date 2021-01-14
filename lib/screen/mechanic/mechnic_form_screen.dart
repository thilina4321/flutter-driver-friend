import 'package:driver_friend/screen/mechanic/Mechanic.dart';
import 'package:flutter/material.dart';

class MechanicFormScreen extends StatelessWidget {
  static String routeName = '/mechanic-form';
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Mechanic Details'),
      ),
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'NIC',
                  ),
                ),

                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'About',
                  ),
                ),

                // Column(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(
                //         'Vehicle types',
                //         style: TextStyle(
                //           fontSize: 18,
                //         ),
                //       ),
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         FlatButton(
                //           onPressed: () {},
                //           child: Text(
                //             'Deisel',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ),
                //         FlatButton(
                //           onPressed: () {},
                //           child: Text(
                //             'Hybrid',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ),
                //         FlatButton(
                //           onPressed: () {},
                //           child: Text(
                //             'Electric',
                //             style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.photo_camera,
                            color: Colors.purple,
                          ),
                          label: Text('Profile Picture')),
                    ),
                    Expanded(
                      child: FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_on,
                            color: Colors.purple,
                          ),
                          label: Text('Location')),
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  width: 200,
                  child: Center(child: Text('Profile Image')),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          MechanicProfileScreen.routeName);
                    },
                    color: Colors.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
