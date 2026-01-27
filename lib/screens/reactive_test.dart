import 'package:flutter/material.dart';

class ReactiveTestScreen extends StatefulWidget {
  @override
  _ReactiveTestScreenState createState() => _ReactiveTestScreenState();
}

class _ReactiveTestScreenState extends State<ReactiveTestScreen> {
  int _counter = 0;
  bool _isBlue = true;

  void _updateState() {
    setState(() {
      _counter++;
      _isBlue = !_isBlue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Widget Tree Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // This Text widget rebuilds when _counter changes
            Text("Button pressed $_counter times", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            // This Container changes color reactively
            Container(
              width: 100,
              height: 100,
              color: _isBlue ? Colors.blue : Colors.orange,
            ),
            ElevatedButton(
              onPressed: _updateState,
              child: Text("Change State"),
            ),
          ],
        ),
      ),
    );
  }
}