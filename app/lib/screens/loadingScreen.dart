import 'package:flutter/material.dart';

class BigOrangeCircle extends StatelessWidget {
  const BigOrangeCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust size as needed
      height: 800,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
    );
  }
}