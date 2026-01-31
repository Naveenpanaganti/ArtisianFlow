import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final EdgeInsets padding;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.teal,
    this.padding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: padding,
        elevation: 4,
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }
}
