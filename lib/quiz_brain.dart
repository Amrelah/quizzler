import 'package:flutter/material.dart';
import 'question.dart';

class QuizBrain {
  int _qno = 0;
  List<Question> _quetionAndAnswer = [
    Question('Question number 1', true),
    Question('Question number 2', false),
    Question('Question number 3', true)
  ];

  void nextQuestion() {
    if (_qno < _quetionAndAnswer.length - 1) {
      _qno++;
    } else {
      _qno = 0;
    }
  }

  int getLenght() {
    int l = _qno;
    return l;
  }

  String getQuestionText() {
    return _quetionAndAnswer[_qno].questionText;
  }

  bool getAnswer() {
    return _quetionAndAnswer[_qno].questionAnswer;
  }
}
