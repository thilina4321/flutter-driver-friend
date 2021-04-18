import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Question {
  String id;
  String question;
  File questionImage;
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
    var data = {'driverId': question.driverId, 'question': question.question};

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

  Future<void> fetchQuestions() async {
    _questions = [];
    try {
      var fetchedQuestions = await dio.get('$url/questions');
      var questions = fetchedQuestions.data;

      questions['fetchquiz'].forEach((question) {
        _questions.add(question);
      });

      notifyListeners();

      // questions.forEach((que) {
      //   if (que['answers'].length > 0) {
      //     List<Answer> fetchedAnswers = [];
      //     que['answers'].forEach((ans) {
      //       fetchedAnswers.add(Answer(
      //           id: ans['_id'],
      //           questionId: que['_id'],
      //           authorId: ans['authorId'],
      //           answer: ans['answer']));
      //     });

      //     _answeredQuestions.add(
      //       Question(
      //         id: que['_id'],
      //         driverId: que['driverId'],
      //         question: que['question'],
      //         answers: fetchedAnswers,
      //       ),
      //     );
      //   } else {
      //     _notAnsweredQuestions.add(Question(
      //         id: que['_id'],
      //         driverId: que['driverId'],
      //         question: que['question']));
      //   }

      //   notifyListeners();
      // });
    } catch (e) {
      print(e);
    }
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

  Future<void> addAnswer(Answer answer) async {
    var data = {
      'authorId': answer.authorId,
      'answer': answer.answer,
      'questionId': answer.questionId
    };

    try {
      await dio.post('$url/give-answer', data: data);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteAnswer(String id) async {
    try {
      var answer = await dio.delete('$url/delete/$id');
      print(answer.data);
    } catch (e) {
      print(e);
    }
  }

  selectAnswersForQuestion(String questionId) {
    Question selectQuestion =
        _answeredQuestions.firstWhere((que) => que.id == questionId);
    _answers = selectQuestion.answers;
  }
}
