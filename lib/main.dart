import 'package:flutter/material.dart';
import 'SetUpQuestion.dart';
// import 'package:audioplayers/audio_cache.dart';

void main() => runApp(MyApp());
SetUpQuestion questionClass = SetUpQuestion();
List<int> optionList;
List<Icon> outputIconsList;
int questionAnswered=0;
int score=0;
// final player = AudioCache();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    questionClass = SetUpQuestion();
    optionList = questionClass.getOptionsList();
    outputIconsList = List();
    return MaterialApp(
      title: 'Math Quiz App',
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: Text('Math Quiz App'),
        ),
        body: SafeArea(
          child: Center(
            child: MathQuizPage(),
          ),
        ),
      ),
    );
  }
}

class MathQuizPage extends StatefulWidget {
  @override
  _MathQuizPageState createState() => _MathQuizPageState();
}

class _MathQuizPageState extends State<MathQuizPage> {
  List<Icon> userScore = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(questionClass.getQuestion() + " =",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FlatButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(optionList[0].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    onPressed: () {
                      setState(() {
                        setUpButtonPressedAction(0);
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FlatButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(optionList[1].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    onPressed: () {
                      setState(() {
                        setUpButtonPressedAction(1);
                      });
                    },
                  ),
                ),
              ),
            ],
          )),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FlatButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(optionList[2].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                      onPressed: () {
                        setState(() {
                          setUpButtonPressedAction(2);
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FlatButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(optionList[3].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                      onPressed: () {
                        setState(() {
                          setUpButtonPressedAction(3);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: outputIconsList,
            ),
          )
        ],
      ),
    );
  }

  setUpButtonPressedAction(int position) {
    bool isCorrect = questionClass.isCorrectAnswer(buttonPosition: position);
    if (isCorrect) {
      outputIconsList.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
      score++;

    } else {
      outputIconsList.add(Icon(
        Icons.clear,
        color: Colors.red,
      ));
    }
    questionClass.setUpNewQuestion();
    optionList = questionClass.getOptionsList();
    questionAnswered++;
    checkWhetherGameFinished();

  }

  void checkWhetherGameFinished() {
    if (questionAnswered == 10) {
      questionAnswered=0;
      outputIconsList.clear();
      _showMyDialog();
      score=0;
    }
  }

  Future<void> _showMyDialog() async {
     String scoreValue='Your Scored $score out of 10 questions';
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must not tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game is finished'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(scoreValue),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
