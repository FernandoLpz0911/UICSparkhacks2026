import 'dart:math';
import 'package:flutter/material.dart';
import 'package:app/services/firebase_firestore.dart';
import 'package:app/services/authentication.dart';
import 'package:app/screens/lobby.dart';
void showJoinLobbyOverlay(BuildContext context) {
  final TextEditingController codeController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Join a Lobby"),
        content: TextField(
          controller: codeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Enter 6-digit code",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              int? lobbyCode = int.tryParse(codeController.text);
              
              // MOCK LOGIC since auth isn't ready:
              var user = _authService.currentUser;
              int userId = user?.uid.hashCode ?? Random().nextInt(999999);
              String userName = user?.displayName ?? "Player_${Random().nextInt(100)}";

              if (lobbyCode != null) {
                // Now this runs even if 'user' is null
                await _firestoreService.addPlayer(
                  lobbyCode: lobbyCode,
                  userId: userId,
                  name: userName,
                );

                if (context.mounted) {
                  Navigator.pop(context); 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Lobby(lobbyCode: lobbyCode)
                    )
                  );
                }
              }
            },
            child: const Text("Join"),
          ),
        ],
      );
    },
  );
}