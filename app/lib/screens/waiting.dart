import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WaitingScreen extends StatefulWidget {
  final String lobbyCode;
  final int initialSeconds;

  const WaitingScreen({
    super.key,
    required this.lobbyCode,
    required this.initialSeconds,
  });

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  late int _secondsLeft;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.initialSeconds;
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ServerLobby')
            .doc(widget.lobbyCode)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "⭐ ⭐ ⭐",
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Waiting for other\nplayers to finish...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26),
                ),
                const SizedBox(height: 30),
                Text(
                  _secondsLeft > 0
                      ? "Time left: $_secondsLeft s"
                      : "Time's up!",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}