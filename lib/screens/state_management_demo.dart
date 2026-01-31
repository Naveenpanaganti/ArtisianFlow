import 'package:flutter/material.dart';

class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({Key? key}) : super(key: key);

  @override
  State<StateManagementDemo> createState() => _StateManagementDemoState();
}

class _StateManagementDemoState extends State<StateManagementDemo> {
  int _counter = 0;
  bool _autoIncrement = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
      _autoIncrement = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _counter >= 5 ? Colors.greenAccent.shade100 : Colors.white;

    return Scaffold(
      appBar: AppBar(title: const Text('State Management Demo')),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: bgColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Button pressed:', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('$_counter times', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: _incrementCounter, child: const Text('Increment')),
                    const SizedBox(width: 12),
                    ElevatedButton(onPressed: _decrementCounter, child: const Text('Decrement')),
                    const SizedBox(width: 12),
                    ElevatedButton(onPressed: _reset, child: const Text('Reset')),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Auto-increment:'),
                    const SizedBox(width: 8),
                    Switch(
                      value: _autoIncrement,
                      onChanged: (v) {
                        setState(() {
                          _autoIncrement = v;
                        });
                        if (v) _startAutoIncrement();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startAutoIncrement() async {
    while (_autoIncrement && mounted) {
      await Future.delayed(const Duration(seconds: 1));
      if (!_autoIncrement || !mounted) break;
      setState(() => _counter++);
    }
  }

  @override
  void dispose() {
    _autoIncrement = false;
    super.dispose();
  }
}
