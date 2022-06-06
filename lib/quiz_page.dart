import 'package:flutter/material.dart';
import 'package:flutter_quiz/question.dart';
import 'package:flutter_quiz/question_bank.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [
    const SizedBox(width: 24, height: 24)
  ];
  bool isLast = false;
  List<Question> questionList = QuestionBank().questionList;

  void addScoreKeeper(bool isCorrect) {
    if (questionList.length - 1 > index) {
      index++;
    } else if (questionList.length - 1 == index && !isLast) {
      updateIcons(isCorrect);
      isLast = true;
      return;
    } else {
      return;
    }
    updateIcons(isCorrect);
  }

  void updateIcons(bool isCorrect) {
    if (isCorrect) {
      scoreKeeper.add(const Icon(Icons.check_circle, color: Colors.green));
    } else {
      scoreKeeper.add(const Icon(Icons.close_rounded, color: Colors.red));
    }
  }

  void updateScoreKeeper() {
    addScoreKeeper(questionList[index].questionAnswer == true);
    index++;
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconButton(onPressed: () {
          setState(() {
            index = 0;
            scoreKeeper = [
              const SizedBox(width: 24, height: 24)
            ];
            isLast = false;
          });
        }, icon: const Icon(Icons.reset_tv), color: Colors.white,),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionList[index].questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.green.shade800,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  addScoreKeeper(questionList[index].questionAnswer == true);
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.red.shade800,
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  addScoreKeeper(questionList[index].questionAnswer == false);
                });
              },
            ),
          ),
        ),
        const SizedBox(
          height: 20
        ),
        Row(
          children: scoreKeeper
        )
      ],
    );
  }
}