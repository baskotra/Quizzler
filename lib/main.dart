import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quizzler());


class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizHome(),
    );
  }
}

class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {

List<Icon> scoreKeeper =[];

void checkAnswer(bool userPickedAnswer){
bool correctAnswer = quizBrain.getQuestionAnswer();


setState(() {

if(quizBrain.isFinished()==true){
Alert(
      context: context,
      type: AlertType.success,
      title: "Quiz Ended!",
      desc: "You have completed all the questions.",
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();

quizBrain.resetBank();
scoreKeeper = [];
}

else{
if(correctAnswer == userPickedAnswer){
    scoreKeeper.add(Icon(Icons.check_circle, color: Colors.green));
  quizBrain.nextQuestion();
  }
  else{
    scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    
  quizBrain.nextQuestion();
  }
}
  });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text(quizBrain.getQuestionText(), style: TextStyle(color: Colors.white, fontSize: 20.0),
                textAlign: TextAlign.center,
                ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: (){
                      checkAnswer(false);
                      },
                child: Text("False", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                color: Colors.red,
                ),
              )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: (){
                    checkAnswer(true);   
                  },
                child: Text("True", style: TextStyle(color: Colors.white, fontSize: 20.0),
                
                ),
                color: Colors.green,
                ),
              ),
            ),
            Row(
              children: scoreKeeper
            )
          ],
        ),
      ),
    );
  }
}