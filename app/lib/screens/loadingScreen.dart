import 'package:flutter/material.dart';

class BigOrangeCircle extends StatelessWidget {
  const BigOrangeCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Center widget takes up all available space and centers its child
      body: Center( 
        child: Container(
          margin: EdgeInsets.all(50),
          width: 450,  // Smaller width
          height: 450,  // Height is half the width for a clear oval shape
          clipBehavior: Clip.antiAlias, // Important: clips the GIF to the oval shape
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(110),
              border: Border.all(color: Colors.black, width: 2),
            ),
        child: Image.asset(
          'assets/image_3.gif', // Ensures the GIF fills the oval entirely
        ),
      ),
        ),
      );
  }
}