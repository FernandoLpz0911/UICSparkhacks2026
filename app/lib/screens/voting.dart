import 'package:flutter/material.dart';
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VotePage(),
  ));
}

class VotePage extends StatelessWidget {
  const VotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 247, 247),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 247, 247),
        elevation: 0.0,
        centerTitle: true,
      ),
    );
  }
}