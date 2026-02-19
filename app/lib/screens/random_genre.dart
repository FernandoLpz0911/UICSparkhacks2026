import 'package:flutter/material.dart';

class Announcement extends StatelessWidget {
  const Announcement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        // FIXED: Removed the stray 'g' after Center(
        child: SizedBox(
          width: 250, 
          height: 250,
          child: Image.asset(
            'assets/image_2.gif',
            fit: BoxFit.contain,
            // Error handling for local assets
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text('Could not find GIF'),
              );
            },
          ),
        ),
      ),
    );
  }
}

