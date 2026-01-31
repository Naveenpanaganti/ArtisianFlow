import 'package:flutter/material.dart';

class AnimationsDemo extends StatefulWidget {
  const AnimationsDemo({super.key});

  @override
  State<AnimationsDemo> createState() => _AnimationsDemoState();
}

class _AnimationsDemoState extends State<AnimationsDemo>
    with SingleTickerProviderStateMixin {
  bool _toggled = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _implicitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Implicit Animation: AnimatedContainer', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => setState(() => _toggled = !_toggled),
          child: AnimatedContainer(
            width: _toggled ? 220 : 120,
            height: _toggled ? 120 : 220,
            decoration: BoxDecoration(
              color: _toggled ? Colors.teal : Colors.orange,
              borderRadius: BorderRadius.circular(_toggled ? 20 : 8),
            ),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            child: const Center(child: Text('Tap to toggle', style: TextStyle(color: Colors.white))),
          ),
        ),
        const SizedBox(height: 18),
        const Text('Implicit Animation: AnimatedOpacity', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AnimatedOpacity(
          opacity: _toggled ? 1.0 : 0.2,
          duration: const Duration(milliseconds: 500),
          child: Image.asset('assets/images/logo.png', width: 100, height: 100),
        ),
      ],
    );
  }

  Widget _explicitSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Explicit Animation: RotationTransition', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        RotationTransition(
          turns: Tween<double>(begin: -0.1, end: 0.1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
          child: Image.asset('assets/images/logo.png', width: 120, height: 120),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (_controller.isAnimating) {
              _controller.stop();
            } else {
              _controller.repeat(reverse: true);
            }
            setState(() {});
          },
          child: Text(_controller.isAnimating ? 'Pause' : 'Play'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animations Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _implicitSection(),
            const SizedBox(height: 30),
            _explicitSection(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 700),
                  pageBuilder: (context, animation, secondaryAnimation) => Scaffold(appBar: AppBar(title: const Text('Next Page')), body: const Center(child: Text('Slide Transition Target'))),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
                      child: child,
                    );
                  },
                ));
              },
              child: const Text('Show Page Transition'),
            ),
          ],
        ),
      ),
    );
  }
}
