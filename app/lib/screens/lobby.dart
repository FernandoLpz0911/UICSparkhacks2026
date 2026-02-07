import 'package:flutter/material.dart';
import 'package:app/widgets/navigate.dart';
import 'package:app/main.dart';
import 'package:app/services/firebase_firestore.dart';
import 'package:app/screens/writing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lobby extends StatefulWidget {
  final int lobbyCode;

  const Lobby({super.key, required this.lobbyCode});

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  final FirestoreService _firestoreService = FirestoreService();

  // Logic to handle game start
  Future<void> _startGame() async {
    try {
      
      /// set the roles of the game
      await _firestoreService.assignRolesAndGenres(
        lobbyCode: widget.lobbyCode,
        mainGenre: "Horror",
        impostorGenre: "Comedy",
      );

      // 60 seconds on the clock starts at this point
      await _firestoreService.startWriting(widget.lobbyCode);
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error starting game: $e")),
        );
      }
    }
  }

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
      body: StreamBuilder<DocumentSnapshot>(

        /// Listen to the main lobby doc to check the game phase
        stream: FirebaseFirestore.instance
            .collection('ServerLobby')
            .doc(widget.lobbyCode.toString())
            .snapshots(),
        builder: (context, lobbySnapshot) {
          if (!lobbySnapshot.hasData) return const Center(child: CircularProgressIndicator());

          final lobbyData = lobbySnapshot.data!.data() as Map<String, dynamic>;
          final String phase = lobbyData['PlayerPhase'] ?? 'waiting';

          /// Auto-navigate to Writing Screen if the phase changes to 'writing'
          if (phase == 'writing') {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => WriteStory(
                    genre: "Check your role!", // Ideally fetched from player sub-collection
                    lobbyCode: widget.lobbyCode.toString(),
                  ),
                ),
              );
            });
          }

          return StreamBuilder<QuerySnapshot>(
            stream: _firestoreService.listenToPlayers(widget.lobbyCode),
            builder: (context, playerSnapshot) {
              if (!playerSnapshot.hasData) return const SizedBox.shrink();

              final players = playerSnapshot.data!.docs;
              final playerNames = players.map((doc) => doc['name'] as String).toList();

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lobby ${widget.lobbyCode}',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text('${playerNames.length}/8 players'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView(
                        children: List.generate(8, (index) {
                          if (index < playerNames.length) {
                            return playerSlot(playerNames[index]);
                          }
                          return playerSlot(null);
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    /// START GAME BUTTON (Visible for testing; ideally restricted to host)
                    if (playerNames.length >= 3) // Game requires at least 3 players
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(double.infinity, 60),
                        ),
                        onPressed: _startGame,
                        child: const Text("START GAME", style: TextStyle(fontSize: 20, color: Colors.white)),
                      )
                    else
                      const Text("Need at least 3 players to start"),
                  ],
                ),
              );
            },
          );
        },
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
            width: 30, height: 30,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 2)),
          ),
          const SizedBox(width: 12),
          Text(name ?? 'Waiting...', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}