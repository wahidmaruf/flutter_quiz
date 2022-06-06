import 'package:flutter_quiz/question.dart';

class QuestionBank {
  int _index = 0;
  final List<Question> _questionList = [
    Question("Conductors have low resistance.", true),
    Question("The human body comprises four lungs.", false),
    Question("Carnivores are animal eaters.", true),
    Question("Mars is the closest planet to the Sun.", false),
    Question("You cannot cry in space.", true),
    Question("A range of mountains is called a range.", true),
    Question("Shinbone is the largest bone in the human body.", false),
    Question("Sudan and Egypt are known for pyramids.", true),
    Question("‘A’ is the most common alphabet in English.", false),
    Question("Canada is the second-largest country in the world.", true),
    Question("Mount Everest is present in the Himalayas.", true),
    Question("Some animals can get a sunburn.", true),
  ];

  void nextQuestion() {
    if (_index < _questionList.length - 1) {
      _index++;
    }
  }

  void resetIndex() {
    _index = 0;
  }

  bool isIndexOutOfRange() {
    if (_index >= _questionList.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  String getQuestionText() {
    return _questionList[_index].questionText;
  }

  bool getQuestionAnswer() {
    return _questionList[_index].questionAnswer;
  }
}
