import 'package:flutter/material.dart';
import '../services/gemini.dart';
import 'AIscreen.dart';

class BigOrangeCircle extends StatefulWidget {
  const BigOrangeCircle({super.key});

  @override
  State<BigOrangeCircle> createState() => _BigOrangeCircleState();
}

class _BigOrangeCircleState extends State<BigOrangeCircle> {
  final Gemini _gemini = Gemini();
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _runAI();
  }

  Future<void> _runAI() async {
    if (_started) return;
    _started = true;

    // TEMP prompt – replace later with real player text
    final prompt = """
You are given a set of short story sentences written by players.
Combine them into one cohesive story.
Make the story flow naturally.
Do NOT mention genres.
""";

    final aiText = await _gemini.sendMessage(prompt);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AIScreen(aiText: aiText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50),
          width: 450,
          height: 450,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(110),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Image.asset(
            'assets/image_3.gif',
          ),
        ),
      ),
    );
  }
}