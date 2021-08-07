import 'dart:math';
import 'package:math_expressions/math_expressions.dart';

class SetUpQuestion {
  String _questionValue;
  List<int> _optionsList = [0, 0, 0, 0];
  int _realAnswer;
  int _realPosition;

  SetUpQuestion() {
    setUpNewQuestion();
  }

  void setUpNewQuestion() {
    resetList();
    Random random = Random();
    int firstNumber = random.nextInt(9) + 1;
    int secondNumber = random.nextInt(9) + 1;
    String operator = (<String>['*', '+', '-'])[random.nextInt(3)];
    _questionValue =
        firstNumber.toString() + operator + secondNumber.toString();

    Parser p = Parser();
    Expression exp = p.parse(
        _questionValue); //_questionValue is the expression we are supposed to solve
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    _realAnswer = eval.toInt();

    _realPosition = random.nextInt(3);
    _optionsList.insert(_realPosition, _realAnswer);
    _optionsList.removeAt(_realPosition +
        1); //Remove another position's value which is zero and needed
    for (int i = 0; i < 4; i++) {
      if (i == _realPosition) {
        continue;
      }
      bool repeatAgain=true;
      int randomNumber = random.nextInt(_realAnswer + 5) + (_realAnswer - 5);// In the range of number nearer to correct number by 5 either low or more
      while (repeatAgain) {
        print('I am trapped, setupquestion line 33');
        repeatAgain=isRandomNumberSame(randomNumber) || _optionsList[i]==0;
        print(isRandomNumberSame(randomNumber));
        _optionsList.insert(i, randomNumber);
        _optionsList.removeAt(i + 1);
        randomNumber++;
        // TODO: To not allow options to be repeated
        //repeatAgain=false;//Since sometime code was getting trapped in same loop i have to set repeat again as false
      }
    }
    print(_optionsList);
  }

  bool isRandomNumberSame(int newNumber) {
    for (int i = 0; i < 4; i++) {
      if (newNumber == _optionsList[i]) {
        return true;
      }
    }
    return false;
  }

  void resetList() {
    _optionsList.clear();
    _optionsList = [0, 0, 0, 0];
  }

  String getQuestion() => _questionValue;

  List<int> getOptionsList() => _optionsList;

  bool isCorrectAnswer({int buttonPosition}) {
    return buttonPosition == _realPosition;
  }
}
