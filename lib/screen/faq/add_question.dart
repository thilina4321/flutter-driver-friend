import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AddNewQuestionPageScreen extends StatefulWidget {
  static String routeName = 'faq-new-quiz';

  @override
  _AddNewQuestionPageScreenState createState() =>
      _AddNewQuestionPageScreenState();
}

class _AddNewQuestionPageScreenState extends State<AddNewQuestionPageScreen> {
  final _form = GlobalKey<FormState>();

  File _quizPhoto;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _quizPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Question'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 8,
                      decoration: InputDecoration(
                          labelText: 'Type Here', border: InputBorder.none),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: getImage,
                  child: Text(
                    'Add photo',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: Center(child: Text('No image added')),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  color: Colors.purple,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(FAQ.routeName);
                    },
                    child: Text(
                      'Post Question',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
