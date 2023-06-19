import 'package:flutter/material.dart';

class RegTestPage extends StatefulWidget {
  const RegTestPage({super.key});

  @override
  State<RegTestPage> createState() => _RegTestPageState();
}

class _RegTestPageState extends State<RegTestPage> {
  Color contcol = Colors.red;

  void changeColor() {
    setState(() {
      if (contcol == Colors.red) {
        contcol = Colors.black;
      } else {
        contcol = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () => changeColor(),
                child: const Text("change color")),
            Container(
              color: contcol,
              width: 100,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
