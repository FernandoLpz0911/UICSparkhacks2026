import 'package:flutter/material.dart';
import 'dart:math';

class TimeUpScreen extends StatelessWidget {
  const TimeUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Yellow star shape
              Transform.rotate(
                angle: 0, // you can rotate if you want
                child: ClipPath(
                  clipper: BurstClipper(),
                  child: Container(
                    color: Colors.yellow,
                    width: 600,
                    height: 600,
                  ),
                ),
              ),
              const Text(
                'Time is out!',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




//star like shape 
class BurstClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const spikes = 18;

    for (int i = 0; i < spikes * 2; i++) {
      final angle = (pi / spikes) * i;
      final r = i.isEven ? radius : radius * 0.65;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}