import 'package:flutter/foundation.dart';

import '../data/dummy_questions.dart';
import '../models/question.dart';


class QuizProvider extends ChangeNotifier {
  QuizProvider({List<Question> questions = dummyQuestions})
      : _questions = questions,
        _answers = List<int?>.filled(questions.length, null);

  final List<Question> _questions;
  final List<int?> _answers;
  String _userName = '';
  int _currentIndex = 0;


  List<Question> get questions => List.unmodifiable(_questions);
  List<int?> get answers => List.unmodifiable(_answers);
  String get userName => _userName;
  int get currentIndex => _currentIndex;
  int get totalQuestions => _questions.length;
  Question get currentQuestion => _questions[_currentIndex];
  bool get isLastQuestion => _currentIndex == totalQuestions - 1;


  double get progress => (_currentIndex + 1) / totalQuestions;

  int? get selectedAnswer => _answers[_currentIndex];
  bool get isCurrentAnswered => selectedAnswer != null;
  bool get isCurrentCorrect => selectedAnswer == currentQuestion.correctIndex;

  int get answeredCount => _answers.where((a) => a != null).length;

  int get score {
    var correct = 0;
    for (var i = 0; i < _questions.length; i++) {
      if (_answers[i] == _questions[i].correctIndex) correct++;
    }
    return correct;
  }

  int get wrongCount => totalQuestions - score;

  double get scorePercent => totalQuestions > 0 ? (score / totalQuestions * 100) : 0;

  String get resultTitle {
    final pct = scorePercent;
    if (pct == 100) return 'Luar Biasa! Sempurna!';
    if (pct >= 80) return 'Sangat Bagus!';
    if (pct >= 60) return 'Bagus!';
    if (pct >= 40) return 'Cukup Bagus!';
    return 'Tetap Semangat!';
  }

  String get resultMessage {
    final pct = scorePercent;
    if (pct == 100) return 'Kamu menjawab semua pertanyaan dengan benar!';
    if (pct >= 80) return 'Pengetahuan musikmu sangat luar biasa!';
    if (pct >= 60) return 'Hasil yang baik, tingkatkan terus pemahaman musikmu!';
    if (pct >= 40) return 'Hasil lumayan, coba ulas kembali jawabanmu.';
    return 'Jangan berkecil hati, coba lagi dan raih skor lebih tinggi!';
  }


  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }


  void selectAnswer(int optionIndex) {
    if (isCurrentAnswered) return;
    if (optionIndex < 0 || optionIndex >= currentQuestion.options.length) return;
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (isLastQuestion) return;
    _currentIndex++;
    notifyListeners();
  }


  void restart() {
    _answers.fillRange(0, _answers.length, null);
    _currentIndex = 0;
    notifyListeners();
  }
}