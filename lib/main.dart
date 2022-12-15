import 'package:flutter/material.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  return runApp(const Quizler());
}

class Quizler extends StatelessWidget {
  const Quizler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade600,
        appBar: AppBar(
          title: const Center(
            child: Text('Quizzler'),
          ),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizpage(),
          ),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  const Quizpage({Key? key}) : super(key: key);

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  bool userCheckedAnswer = true;
  List<Icon> scorekeeper = [];

  void checkAnswer() {
    bool checkanswer = quizBrain.getAnswer();
    if (scorekeeper.length <= quizBrain.getLenght()) {
      if (checkanswer == userCheckedAnswer) {
        setState(() {
          quizBrain.nextQuestion();
          scorekeeper.add(
            const Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        });
      } else {
        setState(() {
          quizBrain.nextQuestion();
          scorekeeper.add(
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        });
      }
    } else {
      setState(() {
        scorekeeper.clear();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              alignment: Alignment.center,
              title: Text('Finished!'),
              content: Text('You\'ve finished the questions.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                )
              ],
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                userCheckedAnswer = true;
                checkAnswer();
              },
              child: const Text(
                'TRUE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                userCheckedAnswer = false;
                checkAnswer();
              },
              child: const Text(
                'FALSE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}
