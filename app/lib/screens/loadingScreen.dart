import 'package:flutter/material.dart';

class BigOrangeCircle extends StatelessWidget {
  const BigOrangeCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
        height: 50, // Different from width to create the oval shape
        decoration: BoxDecoration(
          color: Colors.orange,
          border: Border.all(color: Colors.black, width: 2),
          // Setting radius to a very high number ensures the ends are perfectly round
          borderRadius: BorderRadius.all(Radius.circular(300))
        ),
      );
  }
}