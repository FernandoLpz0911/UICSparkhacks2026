import 'package:flutter/material.dart';

class Announcement extends StatelessWidget {
  const Announcement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The background color of the app
      backgroundColor: Colors.white, 
      body: Center(
        child: SizedBox(
          width: 250, // Constrain the size of the GIF
          height: 250,
          child: Image.asset(
            // Replace with your specific GIF URL
            'assets/image_2.gif',
            fit: BoxFit.contain,
            // Displays a progress indicator while the GIF downloads

            // Error handling if the link is broken
          ),
        ),
      ),
    );
  }
}