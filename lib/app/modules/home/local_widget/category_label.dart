import 'package:flutter/material.dart';

class CategoryLabel extends StatelessWidget {
  final String text;
  final bool isActive;
  const CategoryLabel({super.key, required this.text, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isActive ? Colors.lightBlue : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
