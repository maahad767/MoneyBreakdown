import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Bhangti Chai'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int total = 0;
  Map<String, int> notes = {
    '500': 0,
    '100': 0,
    '50': 0,
    '20': 0,
    '10': 0,
    '5': 0,
    '2': 0,
    '1': 0,
  };

  // add money to total
  void addMoney(String money) {
    // if (total.toString().length > 6) {
    //   return;
    // }
    setState(() {
      total = int.parse(total.toString() + money);
    });
    updateNotes();
  }

  // clear money from total
  void clearMoney() {
    setState(() {
      total = 0;
      notes = {
        '500': 0,
        '100': 0,
        '50': 0,
        '20': 0,
        '10': 0,
        '5': 0,
        '2': 0,
        '1': 0,
      };
    });
  }

  // update notes
  void updateNotes() {
    int tmpTotal = total;
    List<int> noteAmounts = [500, 100, 50, 20, 10, 5, 2, 1];

    for (int note  in noteAmounts) {
      notes["$note"] = tmpTotal ~/ note;
      tmpTotal = tmpTotal % note;
    }
  }

  @override
  Widget build(BuildContext context) {
    // build keyboard
    List<Widget> buildButtons() {
      List<Widget> rows = [];
      int k = 1;
      for (int i = 0; i < 3; i++) {
        List<Widget> buttons = [];
        for (int j = 0; j < 3; j++) {
          KeyButton button = KeyButton(id: k, onPressed: addMoney);
          buttons.add(button);
          buttons.add(const SizedBox(width: 10));
          k++;
        }
        Row row = Row(children: buttons);
        rows.add(row);
      }

      Row finalRow = Row(
          children: [
            KeyButton(id: 0, onPressed: addMoney),
            const SizedBox(width: 10),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20, color: Colors.white60),
                backgroundColor: Colors.green,
                primary: Colors.white70,
                minimumSize: const Size(150, 30),
                maximumSize: const Size(200, 40),
              ),
              onPressed: (){
                clearMoney();
              },
              child: const Text("CLEAR"),
            )
          ]);
      rows.add(finalRow);
      return rows;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Taka: $total",
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.green,
                ),
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Flexible(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: notes.entries
                            .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                              child: Text(
                                "${e.key}: ${e.value}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 1.3,
                                  color: Colors.green,
                                ),
                                maxLines: 5,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: buildButtons()),
                ),
              ]),
            ),
          ],
        ));
  }
}

class KeyButton extends StatelessWidget {
  final int id;
  final Function(String) onPressed;

  KeyButton({required this.id, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20, color: Colors.white60),
        backgroundColor: Colors.green,
        primary: Colors.white70,
        minimumSize: const Size(70, 30),
        maximumSize: const Size(100, 40),
      ),
      onPressed: () => onPressed("$id"),
      child: Text("$id"),
    );
  }
}