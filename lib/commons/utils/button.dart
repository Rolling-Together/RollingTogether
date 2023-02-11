import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  RoundedButton({required this.text, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}