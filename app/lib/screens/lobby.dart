import 'package:flutter/material.dart';
import 'package:app/widgets/navigate.dart';
import 'package:app/screens/home.dart';
import 'package:app/services/firebase_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lobby extends StatefulWidget {
  final String title; /// lobby information

  const Lobby({super.key, required this.title});

  @override
  State<Lobby> createState() => _Lobby();
}

class _Lobby extends State<Lobby> {
  final FirestoreService _firestoreService = FirestoreService(); /// run the database

  @override
  Widget build(BuildContext context) {
    
    /// parse the lobby code from the widget title
    int lobbyCode = int.tryParse(widget.title) ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lobby"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: NavigateButton(
              label: "Home",
              destination: const HomePage(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// stream builder has a listener where we can keep a stream of information, use it
            StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.listenToPlayers(lobbyCode),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                /// get the players from the lobby
                final players = snapshot.data!.docs.map((doc) => doc['name'] as String).toList();

                return Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lobby ${widget.title}',
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// set each player's slot essentially
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