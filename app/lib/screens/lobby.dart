import 'package:flutter/material.dart';
import 'package:app/widgets/navigate.dart';
import 'package:app/main.dart';

class Lobby extends StatefulWidget {
  final int lobbyCode;

  const Lobby({super.key, required this.lobbyCode});

  @override
  State<Lobby> createState() => _Lobby();
}

class _Lobby extends State<Lobby> {
  final List<String> players = [
    'Fawaz',
    'Joseph',
    'Connie',
    'Fernando',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lobby"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: NavigateButton(
              label: "Home",
              destination: HomePage(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lobby ${widget.lobbyCode}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('${players.length}/8 players'),
              ],
            ),

            const SizedBox(height: 30),

            Expanded(
              child: ListView(
                children: List.generate(8, (index) {
                  if (index < players.length) {
                    return playerSlot(players[index]);
                  }
                  return playerSlot(null);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget playerSlot(String? name) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEF6A),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name ?? '',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}