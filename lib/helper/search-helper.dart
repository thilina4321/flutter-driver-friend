import 'package:flutter/material.dart';

class SearchHelper {
  static final key = GlobalKey<FormState>();
  static String place;

  static _findUser(context) {
    key.currentState.save();
    bool isValid = key.currentState.validate();
    if (!isValid) {
      return;
    }
    Navigator.of(context).pop();
  }

  static Future userSearch(context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () => _findUser(context),
                child: Text('Find'),
              ),
            ],
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Find Mechanic\'s by place',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Form(
                    key: key,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Enter Place'),
                          maxLines: null,
                          onSaved: (val) {
                            place = val;
                          },
                          validator: (val) {
                            if (val == '') {
                              return 'Please enter place name';
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });

    return place;
  }
}
