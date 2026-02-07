

import 'dart:async'; 
import 'package:flutter/material.dart'; 
import 'package:app/screens/writing.dart';
import 'timeout.dart';
 
class WriteStory extends StatefulWidget { 
  final String genre; 
 
  const WriteStory({Key? key, required this.genre}) : super(key: key); 
 
  @override 
  State<WriteStory> createState() => _WriteStoryState(); 
} 
 
class _WriteStoryState extends State<WriteStory> { 
  static const int totalTime = 60; // seconds 
  int remainingTime = totalTime; 
 
  Timer? _timer; 
  final TextEditingController _textController = TextEditingController(); 
 
  @override 
  void initState() { 
    super.initState(); 
    _startTimer(); 
  } 
 
  void _startTimer() { 
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) { 
      if (remainingTime == 0) { 
        timer.cancel(); 
        _goToTimeUp(); 
      } else { 
        setState(() { 
          remainingTime--; 
        }); 
      } 
    }); 
  } 
 
  // void _goToNextScreen() { 
  //   _timer?.cancel(); 
 
    // TODO: Save text to Firebase later 
    // final text = _textController.text; 
 
    //Navigator.pushReplacement( 
    //  context, 
     // MaterialPageRoute( 
      //  builder: (_) => const WaitingScreen(), 
    //  ), 
  //  ); 
 // } 
 
 void _goToTimeUp() { 
    Navigator.pushReplacement( 
      context, 
      MaterialPageRoute( 
        builder: (_) => const TimeUpScreen(), 
      ), 
    ); 
  } 
 
  String get formattedTime { 
    final minutes = remainingTime ~/ 60; 
    final seconds = remainingTime % 60; 
    return '$minutes:${seconds.toString().padLeft(2, '0')}'; 
  } 
 
  @override 
  void dispose() { 
    _timer?.cancel(); 
    _textController.dispose(); 
    super.dispose(); 
  } 
 
  @override 
  Widget build(BuildContext context) { 
    bool isSubmitted = false; //Checks the state of the submit button, if the user has submitted their story or not.
    return Scaffold( 
      backgroundColor: const Color(0xFFEFEF6A), 
      body: Padding( 
        padding: const EdgeInsets.all(24), 
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [ 
            const SizedBox(height: 40), 
 
            const Text( 
              "Make a story!", 
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), 
            ), 
 
            const SizedBox(height: 8), 
 
            Text( 
              "Genre: ${widget.genre}", 
              style: const TextStyle(fontSize: 18), 
            ), 
 
            const SizedBox(height: 20), 
 
            Center( 
              child: Container( 
                padding: 
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12), 
                decoration: BoxDecoration( 
                  border: Border.all(color: Colors.black, width: 2), 
                  borderRadius: BorderRadius.circular(20), 
                ), 
                child: Text( 
                  formattedTime, 
                  style: const TextStyle( 
                    fontSize: 40, 
                    fontWeight: FontWeight.bold, 
                  ), 
                ), 
              ), 
            ), 
 
            const SizedBox(height: 20), 
 
            Expanded( 
              child: TextField( 
                controller: _textController, 
                maxLines: null, 
                expands: true, 
                decoration: const InputDecoration( 
                  border: InputBorder.none, 
                  hintText: "Start writing...", 
                ), 
                style: const TextStyle(fontSize: 18), 
              ), 
            ), 
 
            const SizedBox(height: 20), 
 
            Center(
              child: ElevatedButton( // The button is disabled if the user has already submitted their story, preventing multiple submissions, and stops the timer when the user submits their story.
                onPressed: isSubmitted
                  ? null
                  : () {
                  setState(() {
                    isSubmitted = true;
                });
            _timer?.cancel();
          },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFD88B4A),
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 16,
      ),
    ),
    child: const Text(
      "I'm done!",
      style: TextStyle(fontSize: 18),
    ),
  ),
),

          ], 
        ), 
      ), 
    ); 
  } 
} 
