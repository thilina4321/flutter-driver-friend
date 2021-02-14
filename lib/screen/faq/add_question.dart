import 'package:driver_friend/provider/faq_provider.dart';
import 'package:driver_friend/screen/faq/FAQ.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewQuestionPageScreen extends StatefulWidget {
  static String routeName = 'faq-new-quiz';

  @override
  _AddNewQuestionPageScreenState createState() =>
      _AddNewQuestionPageScreenState();
}

class _AddNewQuestionPageScreenState extends State<AddNewQuestionPageScreen> {
  final _form = GlobalKey<FormState>();
  Question question = Question();

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        question.questionImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context).settings.arguments;
    question.driverId = id;

    Future<void> _saveQuestion() async {
      _form.currentState.save();
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }

      await Provider.of<FaqProvider>(context, listen: false)
          .addQuestion(question);
      Navigator.of(context).pushReplacementNamed(FAQ.routeName);
    }

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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (value) {
                        question.question = value;
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'Question required';
                        }
                        return null;
                      },
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Type Here',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  child: Center(
                    child: question.questionImage == null
                        ? FlatButton.icon(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.purple,
                            ),
                            onPressed: getImage,
                            label: Text(
                              'Add photo',
                              style: TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            child: Image.file(
                              question.questionImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
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
                    onPressed: _saveQuestion,
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
