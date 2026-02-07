import 'package:flutter/material.dart';

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
                  clipper: StarClipper(),
                  child: Container(
                    color: Colors.yellow,
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
              const Text(
                'Time is out!',
                style: TextStyle(
                  fontSize: 28,
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

// Custom clipper for star shape
class StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double w = size.width;
    double h = size.height;
    path.moveTo(w * 0.5, 0);
    path.lineTo(w * 0.6, h * 0.35);
    path.lineTo(w, h * 0.4);
    path.lineTo(w * 0.7, h * 0.65);
    path.lineTo(w * 0.8, h);
    path.lineTo(w * 0.5, h * 0.8);
    path.lineTo(w * 0.2, h);
    path.lineTo(w * 0.3, h * 0.65);
    path.lineTo(0, h * 0.4);
    path.lineTo(w * 0.4, h * 0.35);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}