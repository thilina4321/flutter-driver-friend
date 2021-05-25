import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Question {
  String id;
  String question;
  String questionImage;
  String driverId;
  List<Answer> answers;

  Question(
      {this.question,
      this.questionImage,
      this.id,
      this.driverId,
      this.answers});
}

class Answer {
  String id;
  String questionId;
  String authorId;
  String authorImageUrl;
  String authorName;
  String answer;

  Answer(
      {this.answer,
      this.authorId,
      this.authorImageUrl,
      this.questionId,
      this.id});
}

class FaqProvider with ChangeNotifier {
  Question _question;
  List<Question> _answeredQuestions = [];
  List<Question> _notAnsweredQuestions = [];
  List _answers = [];
  List _questions = [];
  List _specificMechanicQuestions = [];
  final cloudinary = CloudinaryPublic('ddo9tyz6e', 'gre6o5vv', cache: false);

  var url = 'https://driver-friend.herokuapp.com/api/faq';
  Dio dio = new Dio();

  List get questions {
    return _questions;
  }

  List<Question> get notAnsweredquestions {
    return [..._notAnsweredQuestions];
  }

  List<Answer> get answers {
    return [..._answers];
  }

  Future<void> addQuestion(Question question) async {
    print(question.questionImage);

    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(question.questionImage,
            resourceType: CloudinaryResourceType.Image),
      );

      var formData = {
        'driverId': question.driverId,
        'question': question.question,
        'questionImage': response.secureUrl
      };

      await dio.post('$url/create', data: formData);
    } on CloudinaryException catch (e) {
      throw e;
    }
  }

  Future<void> fetchQuestions() async {
    _questions = [];
    try {
      var fetchedQuestions = await dio.get('$url/questions');
      var questions = fetchedQuestions.data;

      questions['fetchquiz'].forEach((question) {
        _questions.add(question);
      });

      print(_questions);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  findQuestion(String id) {
    var que = _questions.firstWhere((element) => element['_id'] == id);
    return que;
  }

  Future<void> deleteQuestion(String id) async {
    try {
      var fetchedQuestions = await dio.delete('$url/delete/$id');
      print(fetchedQuestions.data);
      notifyListeners();
      _answeredQuestions.removeWhere((question) => question.id == id);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addAnswer(answer, questionId, authorId) async {
    var data = {
      'authorId': authorId,
      'answer': answer,
      'questionId': questionId
    };

    try {
      await dio.post('$url/give-answer', data: data);
      await fetchQuestions();

      notifyListeners();

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future editComment(comment, commentId, questionId) async {
    var data = {'answer': comment};

    try {
      await dio.patch('$url/edit-answer/$questionId/$commentId', data: data);
      await fetchQuestions();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteAnswer(String questionId, String answerId) async {
    try {
      await dio.delete('$url/delete-answer/$questionId/$answerId');
      await fetchQuestions();
    } catch (e) {
      print(e);
    }
  }

  selectAnswersForQuestion(String questionId) {
    Question selectQuestion =
        _answeredQuestions.firstWhere((que) => que.id == questionId);
    _answers = selectQuestion.answers;
  }

  selectAnswersOfSpecificMechanic(id) {
    List specificQuestions = [];

    _questions.forEach((element) {
      element['answers'].forEach((ele) {
        if (ele['authorId'] != null) {
          if (ele['authorId']['_id'] == id) {
            specificQuestions.add(element);
          }
        }
      });
    });

    _specificMechanicQuestions = specificQuestions;
    return _specificMechanicQuestions;
  }
}
