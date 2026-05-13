import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quiz(),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //bool yes = false;
  final player = AudioPlayer();
  List<Padding> answers = [];
  List<String> get quistions => [
    'Is this a Dog?',
    'These are Eight planets',
    'There is a yellow car',
    'This is a road',
    'This is a road',
  ];
  List<Image> images = [
    Image.asset('assets/image_1.jpg', gaplessPlayback: true),
    Image.asset('assets/image_2.jpg', gaplessPlayback: true),
    Image.asset('assets/image_3.jpg', gaplessPlayback: true),
    Image.asset('assets/image_4.jpg', gaplessPlayback: true),
    Image.asset('assets/image_4.jpg', gaplessPlayback: true),
  ];
  List<bool> answer = [
    false,
    true,
    true,
    false,
  ];
  Expanded truefalse(Color clr, String trufal, bool corrects) {
    return Expanded(
      flex: 1,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: clr,
        ),
        onPressed: () async {
          bool right = answer[qnumber];
          if (right == corrects) {
            await player.play(AssetSource('audio/correct.mp3'));
            setState(() {
              answers.add(
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.thumb_up,
                    color: Colors.green,
                  ),
                ),
              );
              qnumber++;
              score++;
            });
          } else {
            await player.play(AssetSource('audio/wrong.mp3'));
            setState(() {
              answers.add(
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.thumb_down,
                    color: Colors.red,
                  ),
                ),
              );
              qnumber++;
            });
          }
          if (qnumber == 4) {
            await Future.delayed(const Duration(seconds: 1));
            await player.play(AssetSource('audio/win-fx.mp3'));
            if (!mounted) return;
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('You Win!!'),
                  content: Text('Your Score is:$score'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          qnumber = 0;
                          score = 0;
                          answers.clear();
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Play Again'),
                    ),
                  ],
                );
              },
              barrierDismissible: false,
            );
          }
        },
        child: Text(
          trufal,
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  var qnumber = 0;
  int score = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[600],
        title: Text(
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          'Q&A Game',
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: answers,
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: images[qnumber],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                quistions[qnumber],
                style: TextStyle(
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            truefalse(Colors.blue, 'True', true),
            Flexible(
              flex: 2,
              child: FractionallySizedBox(
                heightFactor: 0.3, // Always 30% of available hight
              ),
            ),
            truefalse(Colors.red, 'False', false),
          ],
        ),
      ),
    );
  }
}
