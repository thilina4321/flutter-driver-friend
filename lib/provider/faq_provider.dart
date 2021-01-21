import 'dart:io';

import 'package:flutter/material.dart';

class Question {
  String id;
  String question;
  File questionImage;

  Question({this.question, this.questionImage, this.id});
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

  addQuestion(Question question) {
    question.id = (_questions.length + 1).toString();
    _questions.add(question);
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
