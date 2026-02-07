import 'package:flutter/material.dart';
import 'package:app/widgets/navigate.dart';
import 'package:app/main.dart';
import 'package:app/services/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lobby extends StatefulWidget {
  final int lobbyCode;

  const Lobby({super.key, required this.lobbyCode});

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  final FirestoreService _firestoreService = FirestoreService();

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
            // StreamBuilder listens to the specific lobby's players sub-collection
            StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.listenToPlayers(widget.lobbyCode),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Map database documents to a list of names
                final players = snapshot.data!.docs
                    .map((doc) => doc['name'] as String)
                    .toList();

                return Expanded(
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
                            return playerSlot(null); // Empty slot
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              },
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
            name ?? 'Waiting...',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}