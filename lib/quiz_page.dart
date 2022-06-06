import 'package:flutter/material.dart';
import 'package:flutter_quiz/question_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  QuestionBank questionBank = QuestionBank();

  void validateAnswer(bool userAnswer) {
    if (questionBank.isIndexOutOfRange()) {
      showAlert();
      return;
    }
    bool correctAnswer = questionBank.getQuestionAnswer();
    if (correctAnswer == userAnswer) {
      scoreKeeper.add(const Icon(Icons.check_circle, color: Colors.green));
    } else {
      scoreKeeper.add(const Icon(Icons.close_rounded, color: Colors.red));
    }
    setState(() {
      questionBank.nextQuestion();
    });
  }

  Future<void> showAlert() async {
    await Alert(
      context: context,
      title: "Congratulations!",
      desc: "You've answered all questions",
      buttons: [
        DialogButton(
            child: const Text(
              "Reset",
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: () => Navigator.pop(context)
        )
      ]
    ).show();
    reset();
  }

  void addScoreKeeper(bool isCorrect) {
    if (questionBank.isIndexOutOfRange()) {
      return;
    }

    if (isCorrect) {
      scoreKeeper.add(const Icon(Icons.check_circle, color: Colors.green));
    } else {
      scoreKeeper.add(const Icon(Icons.close_rounded, color: Colors.red));
    }
  }

  void updateScoreKeeper() {
    addScoreKeeper(questionBank.getQuestionAnswer() == true);
  }

  void reset() {
    setState(() {
      questionBank.resetIndex();
      scoreKeeper = [
        const SizedBox(width: 24, height: 24)
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconButton(onPressed: () {
          setState(() {
            reset();
            isLast = false;
          });
        }, icon: const Icon(Icons.reset_tv), color: Colors.white,),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getQuestionText(),
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
                validateAnswer(true);
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
                validateAnswer(false);
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