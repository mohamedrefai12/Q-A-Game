import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  bool yes = false;
  List<Padding> answers = [];
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('assets/image_1.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Is this Image a Dog?',
                style: TextStyle(
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.3, // Always 30% of available hight
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
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
                  });
                },
                child: Text(
                  'True',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: FractionallySizedBox(
                heightFactor: 0.3, // Always 30% of available hight
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
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
                  });
                },
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
