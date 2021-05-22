import 'package:driver_friend/helper/error-helper.dart';
import 'package:driver_friend/provider/faq_provider.dart';
import 'package:driver_friend/provider/user_provider.dart';
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
  bool isLoading = false;

  File qImage;

  var me;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      question.questionImage = pickedFile.path;
      setState(() {
        qImage = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var me = Provider.of<UserProvider>(context, listen: false).me;
    question.driverId = me['id'];

    Future<void> _saveQuestion() async {
      _form.currentState.save();
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }

      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<FaqProvider>(context, listen: false)
            .addQuestion(question);
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacementNamed(FAQ.routeName);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        ErrorDialog.errorDialog(context, 'Something went wrong');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ask Questions'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        labelText: 'Question',
                      ),
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: getImage,
                  icon: Icon(Icons.camera_alt_outlined),
                  label: Text('Include Image'),
                ),
                qImage == null
                    ? Text('')
                    : Container(
                        height: 200,
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            child: Image.file(
                              qImage,
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
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
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
