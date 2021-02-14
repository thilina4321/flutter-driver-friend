import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Question {
  String id;
  String question;
  File questionImage;
  String driverId;

  Question({this.question, this.questionImage, this.id, this.driverId});
}

class Comment {
  File profileImage;
  String name;
  String answer;

  Comment({this.name, this.profileImage, this.answer});
}

class Answer {
  String id;
  String questionId;
  String authorId;
  String authorImageUrl;
  String question;

  Answer(
      {this.question,
      this.authorId,
      this.authorImageUrl,
      this.questionId,
      this.id});
}

class FaqProvider with ChangeNotifier {
  Question _question;
  Answer _answer;
  List<Question> _questions = [];
  List<Answer> _answers = [];
  var url = 'https://driver-friend.herokuapp.com/api';
  Dio dio = new Dio();

  List<Question> get questions {
    return [..._questions];
  }

  Question get question {
    return _question;
  }

  List<Answer> get answers {
    return [..._answers];
  }

  Answer get answer {
    return _answer;
  }

  Future<void> addQuestion(Question question) async {
    var data = {
      'driverId': question.driverId,
      'imageUrl': question.questionImage,
      'question': question.question
    };
    try {
      var question = await dio.post('$url/create', data: data);
      var quiz = question.data['savedQuestion'];
      _question = Question(
          id: quiz['_id'],
          question: quiz['question'],
          driverId: quiz['driverId'],
          questionImage: quiz['questionImage']);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchNotAnsweredQuestions() async {
    var questions = [];
    var fetchedQuestions = await dio.get('$url/not-answered');
  }

  Future<void> fetchAnsweredQuestions() async {
    var questions = [];
    var fetchedQuestions = await dio.get('$url/answered');
  }

  deleteQuestion(String id) {
    _questions.removeWhere((question) => question.id == id);
  }

  addAnswer(Answer answer) {
    _answers.add(answer);
  }

  deleteAnswer(String id) {
    _answers.removeWhere((answer) => answer.id == id);
  }
}
